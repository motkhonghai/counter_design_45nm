###############################################################################
# Stage 4: Clock Tree Synthesis and post-CTS optimization
# Run: innovus -stylus -files 4_cts.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  4_cts
set DESIGN counter

set PROJECT_PATH /home/icd1/workspace/counter_design_45nm

set INPUT_DB    ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_place
set OUTPUT_PATH ${PROJECT_PATH}/physical_design/outputs/mmmc
set REPORT_PATH ${PROJECT_PATH}/physical_design/reports/mmmc/4_cts
set OUTPUT_DB   ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_post_cts

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Use in-memory design or read input database
###############################
if {[info exists PD_DATABASE_LOADED] && $PD_DATABASE_LOADED} {
    puts "Use design already loaded in memory"
} else {
    if {![file exists $INPUT_DB]} {
        error "Stage 3 database not found: $INPUT_DB"
    }
    read_db $INPUT_DB
    set PD_DATABASE_LOADED true
}

###############################
# Create and optimize clock tree
###############################
clock_opt_design
set_propagated_clock [all_clocks]

###############################
# Report and save design
###############################
report_timing -late  -max_paths 50 > [file join $REPORT_PATH setup.rpt]
report_timing -early -max_paths 50 > [file join $REPORT_PATH hold.rpt]
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
