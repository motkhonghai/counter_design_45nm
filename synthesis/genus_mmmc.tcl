if {[file exists /proc/cpuinfo]} {
    sh grep "model name" /proc/cpuinfo
    sh grep "cpu MHz" /proc/cpuinfo
}

puts "Hostname : [info hostname]"

# ============================================================
# Configuration
# ============================================================

set DESIGN  counter
set SYN_EFF medium
set MAP_EFF medium
set OPT_EFF medium

set RELEASE [lindex [get_db program_version] end]

set _OUTPUTS_PATH outputs/outputs_${RELEASE}
set _REPORTS_PATH outputs/reports_${RELEASE}

# ============================================================
# Create output directories
# ============================================================

if {![file exists ${_OUTPUTS_PATH}]} {
    file mkdir ${_OUTPUTS_PATH}
    puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
    file mkdir ${_REPORTS_PATH}
    puts "Creating directory ${_REPORTS_PATH}"
}

# ============================================================
# Search paths
# ============================================================

set_db init_lib_search_path {. ../}
set_db script_search_path {.}
set_db init_hdl_search_path {. ../rtl}

# ============================================================
# Genus configuration
# ============================================================

set_db max_cpus_per_server 8

set_db syn_generic_effort $SYN_EFF
set_db syn_map_effort     $MAP_EFF
set_db syn_opt_effort     $OPT_EFF

set_db information_level 9

set_db tns_opto true

# Enable only when clock gating is intentionally used
# set_db lp_insert_clock_gating true

# ============================================================
# MMMC / Physical libraries
# ============================================================

read_mmmc ../mmmc.tcl

read_physical -lefs {
    ../lef/gsclib045_macro.lef
    ../lef/gsclib045_tech.lef
}

# ============================================================
# Read RTL / Elaborate
# ============================================================

read_hdl ../rtl/counter.v

elaborate $DESIGN

# ============================================================
# Initialize design
# ============================================================

init_design
time_info INIT_DESIGN

check_design -unresolved

# Recommended checks
report_clocks > ${_REPORTS_PATH}/report_clocks_init.rpt

# ============================================================
# Generic synthesis
# ============================================================

syn_generic

write_snapshot \
    -directory $_OUTPUTS_PATH \
    -tag syn_generic

report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after syn_generic"
time_info GENERIC

# ============================================================
# Technology mapping
# ============================================================

syn_map

write_snapshot \
    -directory $_OUTPUTS_PATH \
    -tag syn_map

report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after syn_map"
time_info MAPPED

# ============================================================
# Optimization
# ============================================================

syn_opt

write_snapshot \
    -innovus \
    -directory $_OUTPUTS_PATH \
    -tag syn_opt

report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after syn_opt"
time_info OPT

# ============================================================
# Reports
# ============================================================

report_timing \
    > ${_REPORTS_PATH}/report_timing.rpt

report_timing_summary \
    > ${_REPORTS_PATH}/report_timing_summary.rpt

report_power \
    > ${_REPORTS_PATH}/report_power.rpt

report_area \
    > ${_REPORTS_PATH}/report_area.rpt

report_qor \
    > ${_REPORTS_PATH}/report_qor.rpt

report_clocks \
    > ${_REPORTS_PATH}/report_clocks.rpt

# ============================================================
# Output
# ============================================================

write_hdl \
    > ${_OUTPUTS_PATH}/${DESIGN}_syn.v

write_db ${_OUTPUTS_PATH}/${DESIGN}.db

# Depending on Genus version / flow:
# write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_syn.sdc

puts "Final Runtime & Memory."
time_info FINAL

puts "============================"
puts "Synthesis Finished ........."
puts "============================"

# quit