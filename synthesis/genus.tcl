if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

## --- design / effort settings -------------------------------------------------
set DESIGN counter
set SYN_EFF medium
set MAP_EFF medium
set OPT_EFF medium

## --- output/report folders ---------------------------------------------------
set RELEASE [lindex [get_db program_version] end]
if {$RELEASE == ""} { set RELEASE default }
set _OUTPUTS_PATH OUTPUT/outputs_${RELEASE}
set _REPORTS_PATH OUTPUT/reports_${RELEASE}

if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}
if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}

## --- Genus DB / search paths -------------------------------------------------
set_db init_lib_search_path {. ../}
set_db script_search_path { . }
set_db init_hdl_search_path {. ../rtl}

set_db max_cpus_per_server 8

set_db syn_generic_effort $SYN_EFF
set_db syn_map_effort $MAP_EFF
set_db syn_opt_effort $OPT_EFF

set_db information_level 9
# set_db pbs_mmmc_flow true

set_db tns_opto true
set_db lp_insert_clock_gating true

## --- MMMC and physical libraries --------------------------------------------
read_mmmc ../mmmc.tcl

read_physical -lefs { \
    /home/dex/workspace/counter_design_45nm/lef/gsclib045_macro.lef \
    /home/dex/workspace/counter_design_45nm/lef/gsclib045_tech.lef \
}

## --- read RTL / constraints -------------------------------------------------
read_hdl ../rtl/counter.v
elaborate $DESIGN

## --- init and checks --------------------------------------------------------
init_design
time_info init_design
check_design -unresolved

## --- synthesis flow ---------------------------------------------------------
syn_generic
write_snapshot -directory $_OUTPUTS_PATH -tag syn_generic
report_summary -directory $_REPORTS_PATH
report_timing -verbose > ${_REPORTS_PATH}/report_timing_syn_generic.rpt
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC

syn_map
write_snapshot -directory $_OUTPUTS_PATH -tag syn_map
report_summary -directory $_REPORTS_PATH
report_timing -verbose > ${_REPORTS_PATH}/report_timing_syn_map.rpt
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED

syn_opt
write_snapshot -innovus -directory $_OUTPUTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH
report_timing -verbose > ${_REPORTS_PATH}/report_timing_syn_opt.rpt
puts "Runtime & Memory after syn_opt"
time_info OPT

## --- write downstream artifacts --------------------------------------------
write_hdl > ${_OUTPUTS_PATH}/${DESIGN}_netlist.v
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_sdc.sdc
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge -setuphold split > ${_OUTPUTS_PATH}/delays.sdf

report_power > ${_REPORTS_PATH}/report_power.rpt
report_area  > ${_REPORTS_PATH}/report_area.rpt
report_qor   > ${_REPORTS_PATH}/report_qor.rpt

## --- final database and summary --------------------------------------------
write_db ${DESIGN}.db

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

quit
