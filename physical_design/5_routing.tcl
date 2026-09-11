###############################################################################
# Stage 5: Routing and post-route optimization
# Run: innovus -stylus -files 5_routing.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  5_routing
set DESIGN counter

set PROJECT_PATH /home/icd1/workspace/counter_design_45nm/

set INPUT_DB    ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_post_cts
set OUTPUT_PATH ${PROJECT_PATH}/physical_design/outputs/mmmc
set REPORT_PATH ${PROJECT_PATH}/physical_design/reports/mmmc/5_routing
set OUTPUT_DB   ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_post_route

set BOTTOM_ROUTING_LAYER Metal1
set TOP_ROUTING_LAYER    Metal11

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Check and read input database
###############################
if {![file exists $INPUT_DB]} {
    error "Stage 4 database not found: $INPUT_DB"
}

read_db $INPUT_DB

###############################
# Set routing options
###############################
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
set_db design_bottom_routing_layer $BOTTOM_ROUTING_LAYER
set_db design_top_routing_layer $TOP_ROUTING_LAYER

###############################
# Route and optimize design
###############################
route_opt_design

###############################
# Report and save design
###############################
report_timing -late  -max_paths 50 > [file join $REPORT_PATH setup.rpt]
report_timing -early -max_paths 50 > [file join $REPORT_PATH hold.rpt]
time_design -report_only > [file join $REPORT_PATH timing_summary.rpt]
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
