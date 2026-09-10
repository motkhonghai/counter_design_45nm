###############################################################################
## Global variables and tool settings
###############################################################################

set DESIGN counter
set SYN_EFF medium
set MAP_EFF medium
set OPT_EFF medium

set _SYNTHESIS_PATH [file dirname [file normalize [info script]]]
set _PROJECT_PATH   [file dirname $_SYNTHESIS_PATH]
set _RTL_PATH       [file join $_PROJECT_PATH rtl]
set _LIB_PATH       [file join $_PROJECT_PATH lib]
set _LEF_PATH       [file join $_PROJECT_PATH lef]
set _OUTPUTS_PATH   [file join $_SYNTHESIS_PATH outputs mmmc]
set _REPORTS_PATH   [file join $_SYNTHESIS_PATH reports mmmc]

foreach directory [list $_OUTPUTS_PATH $_REPORTS_PATH] {
    if {![file exists $directory]} {
        file mkdir $directory
        puts "Creating directory $directory"
    }
}

set_db init_lib_search_path [list $_LIB_PATH]
set_db init_hdl_search_path [list $_RTL_PATH]
set_db script_search_path [list $_SYNTHESIS_PATH $_PROJECT_PATH]
set_db information_level 9

set_db syn_generic_effort $SYN_EFF
set_db syn_map_effort $MAP_EFF
set_db syn_opt_effort $OPT_EFF

###############################################################################
## MMMC, physical libraries and RTL
###############################################################################

# The shared MMMC file defines the slow/fast library sets, RC corner,
# functional constraint mode and active setup/hold analysis views.
read_mmmc [file join $_PROJECT_PATH mmmc.tcl]

read_physical -lefs [list \
    [file join $_LEF_PATH gsclib045_tech.lef] \
    [file join $_LEF_PATH gsclib045_macro.lef] \
]

puts "Now load RTL"
read_hdl [file join $_RTL_PATH counter.v]
elaborate $DESIGN
init_design

check_design -unresolved
check_timing_intent
time_info ELABORATION

###############################################################################
## Cost groups for each active setup view
###############################################################################

set _HAS_REGISTERS [expr {[llength [all_registers]] > 0}]
if {$_HAS_REGISTERS} {
    define_cost_group -name I2C -design $DESIGN
    define_cost_group -name C2O -design $DESIGN
}
define_cost_group -name I2O -design $DESIGN

foreach view [get_db analysis_views -if {.is_setup == true}] {
    if {$_HAS_REGISTERS} {
        path_group -from [all_inputs] -to [all_registers] \
                   -group I2C -name I2C -view $view
        path_group -from [all_registers] -to [all_outputs] \
                   -group C2O -name C2O -view $view
    }

    path_group -from [all_inputs] -to [all_outputs] \
               -group I2O -name I2O -view $view
}

foreach cost_group [get_db cost_groups *] {
    report_timing -group [list $cost_group] \
        >> [file join $_REPORTS_PATH ${DESIGN}_pre_synthesis_timing.rpt]
}

###############################################################################
## MMMC synthesis
###############################################################################

syn_generic
write_snapshot -directory $_OUTPUTS_PATH -tag syn_generic
write_reports -directory $_REPORTS_PATH -tag syn_generic
time_info GENERIC

syn_map
write_snapshot -directory $_OUTPUTS_PATH -tag syn_map
write_reports -directory $_REPORTS_PATH -tag syn_map
time_info MAPPED

foreach cost_group [get_db cost_groups *] {
    set cost_group_name [vbasename $cost_group]
    report_timing -group [list $cost_group] \
        > [file join $_REPORTS_PATH ${DESIGN}_${cost_group_name}_post_map.rpt]
}

syn_opt
write_snapshot -innovus -directory $_OUTPUTS_PATH -tag syn_opt
write_reports -directory $_REPORTS_PATH -tag syn_opt
time_info OPTIMIZED

###############################################################################
## Final reports and Innovus handoff
###############################################################################

report_messages > [file join $_REPORTS_PATH ${DESIGN}_messages.rpt]
report_gates    > [file join $_REPORTS_PATH ${DESIGN}_gates.rpt]
report_power    > [file join $_REPORTS_PATH ${DESIGN}_power.rpt]
report_area     > [file join $_REPORTS_PATH ${DESIGN}_area.rpt]
report_qor      > [file join $_REPORTS_PATH ${DESIGN}_qor.rpt]

write_hdl > [file join $_OUTPUTS_PATH ${DESIGN}_netlist.v]

# A multi-mode design requires the analysis view to be specified explicitly.
# Export one SDC per active view so neither corner is silently omitted.
write_sdc -view view_wcl_slow \
    > [file join $_OUTPUTS_PATH ${DESIGN}_view_wcl_slow.sdc]
write_sdc -view view_wcl_fast \
    > [file join $_OUTPUTS_PATH ${DESIGN}_view_wcl_fast.sdc]

write_db [file join $_OUTPUTS_PATH ${DESIGN}.db]

# Export a self-consistent Innovus handoff (netlist, constraints and MMMC data).
write_design -innovus -base_name [file join $_OUTPUTS_PATH $DESIGN]

puts "Final Runtime & Memory."
time_info FINAL
puts "MMMC synthesis finished."
puts "Outputs: $_OUTPUTS_PATH"
puts "Reports: $_REPORTS_PATH"
