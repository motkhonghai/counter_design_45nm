###############################################################################
# Stage 2: Floorplan, I/O placement and power planning
# Run: innovus -stylus -files 2_floorplan_power.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  2_floorplan_power
set DESIGN counter

set INPUT_DB    /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_init
set OUTPUT_PATH /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc
set REPORT_PATH /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/reports/mmmc/2_floorplan_power
set OUTPUT_DB   /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_floorplan_power
set IO_FILE     /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/pins_mmmc.io

set POWER_NET       VDD
set GROUND_NET      VSS
set CORE_SITE       CoreSite
set CORE_UTILIZATION 0.70

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Check and read input database
###############################
if {![file exists $INPUT_DB]} {
    error "Stage 1 database not found: $INPUT_DB"
}

read_db $INPUT_DB

###############################
# Create floorplan
###############################
create_floorplan \
    -core_margins_by die \
    -site $CORE_SITE \
    -core_density_size 1 $CORE_UTILIZATION 2.5 2.5 2.5 2.5

check_floorplan -detailed > [file join $REPORT_PATH floorplan_before_io.rpt]

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
# Connect global power nets
###############################
connect_global_net $POWER_NET  -type pg_pin -pin_base_name $POWER_NET  -inst_base_name *
connect_global_net $GROUND_NET -type pg_pin -pin_base_name $GROUND_NET -inst_base_name *
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
    -block_pin_target nearest_target \
    -core_pin_target first_after_row_end \
    -allow_jogging true \
    -allow_layer_change true

###############################
# Check, report and save design
###############################
check_floorplan -detailed > [file join $REPORT_PATH floorplan_after_power.rpt]
time_design -report_only > [file join $REPORT_PATH timing.rpt]
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
