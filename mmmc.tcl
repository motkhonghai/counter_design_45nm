#      created by HuuTien
# Resolve paths independently of the directory where the tool was launched.
set counter_root [file dirname [file normalize [info script]]]

#===============================
#=    Create timing corners   =
#===============================

create_library_set -name wcl_slow -timing [list [file join $counter_root lib slow_vdd1v0_basicCells.lib]]

create_library_set -name wcl_fast -timing [list [file join $counter_root lib fast_vdd1v0_basicCells.lib]]

create_opcond -name op_cond_wcl_slow   -process 1  -voltage 0.9   -temperature 125
create_opcond -name op_cond_wcl_fast   -process 1  -voltage 1.1   -temperature 0

create_timing_condition -name timing_cond_wcl_slow  -opcond op_cond_wcl_slow    -library_sets {wcl_slow}
create_timing_condition -name timing_cond_wcl_fast  -opcond op_cond_wcl_fast    -library_sets {wcl_fast}

# GPDK045 extraction technology; do not mix with the legacy 28nm cap table.
create_rc_corner -name rc_corner -qrc_tech [file join $counter_root QRC_Tech gpdk045.tch]

create_delay_corner -name delay_corner_wcl_slow -early_timing_condition timing_cond_wcl_slow \
                                                -late_timing_condition  timing_cond_wcl_slow \
                                                -early_rc_corner    rc_corner \
                                                -late_rc_corner     rc_corner 
create_delay_corner -name delay_corner_wcl_fast -early_timing_condition timing_cond_wcl_fast \
                                                -late_timing_condition  timing_cond_wcl_fast \
                                                -early_rc_corner    rc_corner \
                                                -late_rc_corner     rc_corner


#===============================
#=    Create constraint mode  =
#===============================

# Both PVT corners use the same functional constraints.
create_constraint_mode -name functional -sdc_files [list [file join $counter_root constraints constraints_top.sdc]]

#===============================
#=    Create analysis views   =
#===============================

create_analysis_view -name view_wcl_slow -constraint_mode functional -delay_corner delay_corner_wcl_slow
create_analysis_view -name view_wcl_fast -constraint_mode functional -delay_corner delay_corner_wcl_fast

# Check setup and hold at both available PVT corners.
set_analysis_view -setup {view_wcl_slow view_wcl_fast} \
                  -hold  {view_wcl_slow view_wcl_fast}
