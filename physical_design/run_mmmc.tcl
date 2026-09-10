###############################################################################
## Global variables and paths
###############################################################################

set DESIGN counter

set _PD_PATH       [file dirname [file normalize [info script]]]
set _PROJECT_PATH  [file dirname $_PD_PATH]
set _HANDOFF_PATH  [file join $_PROJECT_PATH synthesis outputs mmmc INVS]
set _OUTPUTS_PATH  [file join $_PD_PATH outputs mmmc]
set _REPORTS_PATH  [file join $_PD_PATH reports mmmc]
set _IO_FILE       [file join $_PD_PATH pins_mmmc.io]

foreach directory [list $_OUTPUTS_PATH $_REPORTS_PATH] {
    if {![file exists $directory]} {
        file mkdir $directory
        puts "Creating directory $directory"
    }
}

if {![file isdirectory $_HANDOFF_PATH]} {
    error "Genus Common UI handoff not found: $_HANDOFF_PATH"
}

set_db max_cpus_per_server 8
set_db init_power_nets VDD
set_db init_ground_nets VSS

###############################################################################
## Load the Genus MMMC handoff
###############################################################################

# This Common UI database already contains the synthesized netlist, slow/fast
# libraries, functional constraints, QRC corner and active analysis views.
read_db -common $_HANDOFF_PATH

puts "Active setup views: [get_db analysis_views -if {.is_setup == true} .name]"
puts "Active hold views : [get_db analysis_views -if {.is_hold == true} .name]"

###############################################################################
## Floorplan and I/O assignment
###############################################################################

create_floorplan \
    -core_margins_by die \
    -site CoreSite \
    -core_density_size 1 0.70 2.5 2.5 2.5 2.5

check_floorplan -detailed

# On the first run, create an I/O template from the ports in the MMMC netlist.
# Innovus pauses so the generated side/layer/spacing assignments can be edited.
# Save the file, then type "resume" in Innovus to continue the same run.
if {![file exists $_IO_FILE]} {
    write_io_file -template $_IO_FILE
    puts "Generated I/O template: $_IO_FILE"
    puts "Edit the template, save it, then type 'resume' to continue."
    suspend
}

read_io_file $_IO_FILE

###############################################################################
## Power planning
###############################################################################

connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name *
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name *
connect_global_net VDD -type tie_hi
connect_global_net VSS -type tie_lo

set_db add_rings_skip_shared_inner_ring none
set_db add_rings_avoid_short true
set_db add_rings_ignore_rows false
set_db add_rings_extend_over_row false

add_rings \
    -type core_rings \
    -nets [list VDD VSS] \
    -follow core \
    -layer [list bottom Metal11 top Metal11 right Metal10 left Metal10] \
    -width 0.7 \
    -spacing 0.4 \
    -offset 0.6 \
    -jog_distance 0.6 \
    -threshold 0.6

add_stripes \
    -nets [list VDD VSS] \
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

route_special \
    -connect core_pin \
    -nets [list VDD VSS] \
    -layer_change_range [list Metal1(1) Metal11(11)] \
    -crossover_via_layer_range [list Metal1(1) Metal11(11)] \
    -target_via_layer_range [list Metal1(1) Metal11(11)] \
    -block_pin_target nearest_target \
    -core_pin_target first_after_row_end \
    -allow_jogging true \
    -allow_layer_change true

write_db [file join $_OUTPUTS_PATH ${DESIGN}_floorplan]
time_design -report_only > [file join $_REPORTS_PATH ${DESIGN}_floorplan_timing.rpt]

###############################################################################
## Placement
###############################################################################

place_opt_design
write_db [file join $_OUTPUTS_PATH ${DESIGN}_place]
time_design -report_only > [file join $_REPORTS_PATH ${DESIGN}_place_timing.rpt]

###############################################################################
## Clock-tree synthesis
###############################################################################

create_clock_tree_spec
clock_opt_design
set_propagated_clock [all_clocks]

write_db [file join $_OUTPUTS_PATH ${DESIGN}_post_cts]
time_design -report_only > [file join $_REPORTS_PATH ${DESIGN}_post_cts_timing.rpt]

###############################################################################
## Routing and extraction
###############################################################################

set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
set_db design_bottom_routing_layer Metal1
set_db design_top_routing_layer Metal11

route_design -global_detail
reset_parasitics
extract_rc

write_db [file join $_OUTPUTS_PATH ${DESIGN}_post_route]
time_design -report_only > [file join $_REPORTS_PATH ${DESIGN}_post_route_timing.rpt]

###############################################################################
## Final checks, reports and outputs
###############################################################################

check_drc > [file join $_REPORTS_PATH ${DESIGN}_drc.rpt]
verify_connectivity > [file join $_REPORTS_PATH ${DESIGN}_connectivity.rpt]
report_area > [file join $_REPORTS_PATH ${DESIGN}_area.rpt]
report_power > [file join $_REPORTS_PATH ${DESIGN}_power.rpt]
report_timing_summary > [file join $_REPORTS_PATH ${DESIGN}_timing_summary.rpt]

write_netlist [file join $_OUTPUTS_PATH ${DESIGN}_physical.v]
write_def [file join $_OUTPUTS_PATH ${DESIGN}.def]
write_sdc -view view_wcl_slow \
    > [file join $_OUTPUTS_PATH ${DESIGN}_post_route_view_wcl_slow.sdc]
write_sdc -view view_wcl_fast \
    > [file join $_OUTPUTS_PATH ${DESIGN}_post_route_view_wcl_fast.sdc]
write_db [file join $_OUTPUTS_PATH ${DESIGN}_final]

puts "Final Runtime & Memory."
time_info FINAL
puts "MMMC physical design finished."
puts "Outputs: $_OUTPUTS_PATH"
puts "Reports: $_REPORTS_PATH"
