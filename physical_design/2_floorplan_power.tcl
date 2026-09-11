###############################################################################
# Stage 2: Floorplan, I/O placement and power planning
# Run: innovus -stylus -files 2_floorplan_power.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  2_floorplan_power
set DESIGN counter

set PROJECT_PATH /home/icd1/workspace/counter_design_45nm

set INPUT_DB    ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_init
set OUTPUT_PATH ${PROJECT_PATH}/physical_design/outputs/mmmc
set REPORT_PATH ${PROJECT_PATH}/physical_design/reports/mmmc/2_floorplan_power
set OUTPUT_DB   ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_floorplan_power
set IO_FILE     ${PROJECT_PATH}/physical_design/pins_mmmc.io

set POWER_NET       VDD
set GROUND_NET      VSS

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Use in-memory design or read input database
###############################
if {[info exists PD_DATABASE_LOADED] && $PD_DATABASE_LOADED} {
    puts "Use design already loaded in memory"
} else {
    if {![file exists $INPUT_DB]} {
        error "Stage 1 database not found: $INPUT_DB"
    }
    read_db $INPUT_DB
    set PD_DATABASE_LOADED true
}

###############################
# Create floorplan automatically
###############################
floorplan_design -reshape -predict

###############################
# Create or read I/O constraint
###############################
if {![file exists $IO_FILE]} {
    write_io_file -template $IO_FILE
    puts "Created I/O template: $IO_FILE"
    puts "Edit pins_mmmc.io, save it, then type resume in Innovus."
    suspend
}

read_io_file $IO_FILE

###############################
# Finish floorplan
###############################
set_db finish_floorplan_active_objs [list macro soft_blockage core]
finish_floorplan -fill_place_blockage soft 20.0

###############################
# Connect global power nets
###############################
connect_global_net $POWER_NET  -type pg_pin -pin $POWER_NET  -inst_base_name *
connect_global_net $GROUND_NET -type pg_pin -pin $GROUND_NET -inst_base_name *
connect_global_net $POWER_NET  -type tie_hi
connect_global_net $GROUND_NET -type tie_lo

###############################
# Create power rings
###############################
set_db add_rings_skip_shared_inner_ring none
set_db add_rings_avoid_short true
set_db add_rings_ignore_rows false
set_db add_rings_extend_over_row false

add_rings \
    -type core_rings \
    -nets [list $POWER_NET $GROUND_NET] \
    -follow core \
    -layer [list bottom Metal11 top Metal11 right Metal10 left Metal10] \
    -width 0.7 \
    -spacing 0.4 \
    -offset 0.6 \
    -jog_distance 0.6 \
    -threshold 0.6

###############################
# Create power stripes
###############################
add_stripes \
    -nets [list $POWER_NET $GROUND_NET] \
    -layer Metal10 \
    -width 0.3 \
    -spacing 0.4 \
    -set_to_set_distance 5.0 \
    -merge_stripes_value 0.6 \
    -max_same_layer_jog_length 0.44 \
    -pad_core_ring_bottom_layer_limit Metal9 \
    -pad_core_ring_top_layer_limit Metal11 \
    -block_ring_bottom_layer_limit Metal9 \
    -block_ring_top_layer_limit Metal11

###############################
# Route power nets
###############################
route_special \
    -connect core_pin \
    -nets [list $POWER_NET $GROUND_NET] \
    -layer_change_range [list Metal1(1) Metal11(11)] \
    -crossover_via_layer_range [list Metal1(1) Metal11(11)] \
    -target_via_layer_range [list Metal1(1) Metal11(11)] \
    -core_pin_target first_after_row_end \
    -allow_jogging true \
    -allow_layer_change true

###############################
# Report and save design
###############################
report_timing -late -max_paths 20 > [file join $REPORT_PATH timing.rpt]
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
