###############################################################################
# Full physical-design flow: run stages 1 through 7 in one Innovus session
# Run: innovus -stylus -files run_full.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set PROJECT_PATH /home/icd1/workspace/counter_design_45nm
set SCRIPT_PATH  ${PROJECT_PATH}/physical_design

###############################
# Stage 1: Design initialization
###############################
source ${SCRIPT_PATH}/1_init_design.tcl

###############################
# Stage 2: Floorplan and power
###############################
source ${SCRIPT_PATH}/2_floorplan_power.tcl

###############################
# Stage 3: Placement
###############################
source ${SCRIPT_PATH}/3_placement.tcl

###############################
# Stage 4: Clock Tree Synthesis
###############################
source ${SCRIPT_PATH}/4_cts.tcl

###############################
# Stage 5: Routing
###############################
source ${SCRIPT_PATH}/5_routing.tcl

###############################
# Stage 6: Chip finishing
###############################
source ${SCRIPT_PATH}/6_chip_finish.tcl

###############################
# Stage 7: Export
###############################
source ${SCRIPT_PATH}/7_export.tcl

puts "Full physical-design flow completed"
