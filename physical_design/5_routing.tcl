###############################################################################
# Stage 5: Routing and post-route optimization
# Run: innovus -stylus -files 5_routing.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  5_routing
set DESIGN counter

set PROJECT_PATH /home/icd1/workspace/counter_design_45nm

set INPUT_DB    ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_post_cts
set OUTPUT_PATH ${PROJECT_PATH}/physical_design/outputs/mmmc
set REPORT_PATH ${PROJECT_PATH}/physical_design/reports/mmmc/5_routing
set OUTPUT_DB   ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_post_route

set FILLER_CELLS [list FILL64 FILL32 FILL16 FILL8 FILL4 FILL2 FILL1]

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Use in-memory design or read input database
###############################
if {[info exists PD_DATABASE_LOADED] && $PD_DATABASE_LOADED} {
    puts "Use design already loaded in memory"
} else {
    if {![file exists $INPUT_DB]} {
        error "Stage 4 database not found: $INPUT_DB"
    }
    read_db $INPUT_DB
    set PD_DATABASE_LOADED true
}

###############################
# Insert filler cells before routing
###############################
set_db add_fillers_cells $FILLER_CELLS
add_fillers

###############################
# Route and optimize design
###############################
route_opt_design

###############################
# Report and save design
###############################
report_timing -late  -max_paths 50 > [file join $REPORT_PATH setup.rpt]
report_timing -early -max_paths 50 > [file join $REPORT_PATH hold.rpt]
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
