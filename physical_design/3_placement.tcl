###############################################################################
# Stage 3: Placement and pre-CTS optimization
# Run: innovus -stylus -files 3_placement.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  3_placement
set DESIGN counter

set PROJECT_PATH /home/tienpnh/workspace/cadence/counter_design_45nm

set INPUT_DB    ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_floorplan_power
set OUTPUT_PATH ${PROJECT_PATH}/physical_design/outputs/mmmc
set REPORT_PATH ${PROJECT_PATH}/physical_design/reports/mmmc/3_placement
set OUTPUT_DB   ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_place

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Check and read input database
###############################
if {![file exists $INPUT_DB]} {
    error "Stage 2 database not found: $INPUT_DB"
}

read_db $INPUT_DB

###############################
# Place standard cells and optimize
###############################
place_opt_design

###############################
# Report and save design
###############################
report_timing -late -max_paths 50 > [file join $REPORT_PATH setup.rpt]
time_design -report_only > [file join $REPORT_PATH timing_summary.rpt]
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
