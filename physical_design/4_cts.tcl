###############################################################################
# Stage 4: Clock Tree Synthesis and post-CTS optimization
# Run: innovus -stylus -files 4_cts.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  4_cts
set DESIGN counter

set INPUT_DB    /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_place
set OUTPUT_PATH /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc
set REPORT_PATH /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/reports/mmmc/4_cts
set OUTPUT_DB   /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_post_cts

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Check and read input database
###############################
if {![file exists $INPUT_DB]} {
    error "Stage 3 database not found: $INPUT_DB"
}

read_db $INPUT_DB

###############################
# Create and optimize clock tree
###############################
create_clock_tree_spec
clock_opt_design
set_propagated_clock [all_clocks]

###############################
# Report and save design
###############################
report_timing -late  -max_paths 50 > [file join $REPORT_PATH setup.rpt]
report_timing -early -max_paths 50 > [file join $REPORT_PATH hold.rpt]
time_design -report_only > [file join $REPORT_PATH timing_summary.rpt]
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
