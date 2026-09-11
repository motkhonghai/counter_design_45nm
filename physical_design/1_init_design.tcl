###############################################################################
# Stage 1: Design initialization
# Run: innovus -stylus -files 1_init_design.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  1_init_design
set DESIGN counter

set PROJECT_PATH /home/icd1/workspace/counter_design_45nm/

set INPUT_DB    ${PROJECT_PATH}/synthesis/outputs/mmmc/INVS
set OUTPUT_PATH ${PROJECT_PATH}/physical_design/outputs/mmmc
set REPORT_PATH ${PROJECT_PATH}/physical_design/reports/mmmc/1_init_design
set OUTPUT_DB   ${PROJECT_PATH}/physical_design/outputs/mmmc/counter_init

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

set_db init_power_nets  VDD
set_db init_ground_nets VSS

###############################
# Check input
###############################
if {![file exists $INPUT_DB]} {
    error "Genus MMMC database not found: $INPUT_DB"
}

###############################
# Read Genus MMMC handoff
###############################
read_db -common $INPUT_DB

puts "MMMC analysis views: [get_db analysis_views]"

###############################
# Save design
###############################
write_db $OUTPUT_DB

puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
