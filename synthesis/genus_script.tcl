# Genus Common UI single-corner synthesis flow for the counter design.
# Run from any directory with: genus -files <path>/genus_script.tcl

if {[file exists /proc/cpuinfo]} {
    sh grep "model name" /proc/cpuinfo
    sh grep "cpu MHz" /proc/cpuinfo
}
puts "Hostname : [info hostname]"

###############################################################################
## Global variables and tool settings
###############################################################################

set DESIGN counter
set SYN_EFF medium
set MAP_EFF medium
set OPT_EFF medium

# Resolve every input and output relative to this script, not the launch path.
set _SYNTHESIS_PATH [file dirname [file normalize [info script]]]
set _PROJECT_PATH   [file dirname $_SYNTHESIS_PATH]
set _RTL_PATH       [file join $_PROJECT_PATH rtl]
set _LIB_PATH       [file join $_PROJECT_PATH lib]
set _CONSTRAINT_PATH [file join $_PROJECT_PATH constraints]
set _OUTPUTS_PATH   [file join $_SYNTHESIS_PATH outputs]
set _REPORTS_PATH   [file join $_SYNTHESIS_PATH reports]

foreach directory [list $_OUTPUTS_PATH $_REPORTS_PATH] {
    if {![file exists $directory]} {
        file mkdir $directory
        puts "Creating directory $directory"
    }
}

set_db init_lib_search_path [list $_LIB_PATH]
set_db init_hdl_search_path [list $_RTL_PATH]
set_db script_search_path [list $_SYNTHESIS_PATH]
set_db information_level 9

set_db syn_generic_effort $SYN_EFF
set_db syn_map_effort $MAP_EFF
set_db syn_opt_effort $OPT_EFF

###############################################################################
## Load and initialize the design
###############################################################################

puts "Now load the slow-corner library and RTL"
read_libs [file join $_LIB_PATH slow_vdd1v0_basicCells.lib]
read_hdl [file join $_RTL_PATH counter.v]
elaborate $DESIGN
read_sdc [file join $_CONSTRAINT_PATH constraints_top.sdc]

check_design -unresolved
check_timing_intent
time_info ELABORATION

###############################################################################
## Synthesis
###############################################################################

syn_generic
write_snapshot -directory $_OUTPUTS_PATH -tag syn_generic
write_reports -directory $_REPORTS_PATH -tag syn_generic
time_info GENERIC

syn_map
write_snapshot -directory $_OUTPUTS_PATH -tag syn_map
write_reports -directory $_REPORTS_PATH -tag syn_map
time_info MAPPED

syn_opt
write_snapshot -directory $_OUTPUTS_PATH -tag syn_opt
write_reports -directory $_REPORTS_PATH -tag syn_opt
time_info OPTIMIZED

###############################################################################
## Final reports and handoff files
###############################################################################

report_timing > [file join $_REPORTS_PATH ${DESIGN}_timing.rpt]
report_power  > [file join $_REPORTS_PATH ${DESIGN}_power.rpt]
report_area   > [file join $_REPORTS_PATH ${DESIGN}_area.rpt]
report_qor    > [file join $_REPORTS_PATH ${DESIGN}_qor.rpt]
report_messages > [file join $_REPORTS_PATH ${DESIGN}_messages.rpt]

write_hdl > [file join $_OUTPUTS_PATH ${DESIGN}_netlist.v]
write_sdc > [file join $_OUTPUTS_PATH ${DESIGN}_sdc.sdc]
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge \
          -setuphold split > [file join $_OUTPUTS_PATH ${DESIGN}_delays.sdf]
write_db [file join $_OUTPUTS_PATH ${DESIGN}.db]

puts "Final Runtime & Memory."
time_info FINAL
puts "Synthesis finished."
puts "Outputs: $_OUTPUTS_PATH"
puts "Reports: $_REPORTS_PATH"
