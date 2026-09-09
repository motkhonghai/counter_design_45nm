#      created by HuuTien
#===============================
#=    creata multi-corners     =
#===============================

create_library_set -name wcl_slow -timing { \
    ../lib/slow_vdd1v0_basicCells.lib
}

create_library_set -name wcl_fast -timing { \
    ../lib/fast_vdd1v0_basicCells.lib
}

create_opcond -name op_cond_wcl_slow   -process 1  -voltage 0.9   -temperature 125
create_opcond -name op_cond_wcl_fast   -process 1  -voltage 1.1    -temperature 0

create_timing_condition -name timing_cond_wcl_slow  -opcond op_cond_wcl_slow    -library_sets {wcl_slow}
create_timing_condition -name timing_cond_wcl_fast  -opcond op_cond_wcl_fast    -library_sets {wcl_fast}

create_rc_corner -name rc_corner -cap_table ../captable/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl

create_delay_corner -name delay_corner_wcl_slow -early_timing_condition timing_cond_wcl_slow \
                                                -late_timing_condition  timing_cond_wcl_slow \
                                                -early_rc_corner    rc_corner \
                                                -late_rc_corner     rc_corner 
create_delay_corner -name delay_corner_wcl_fast -early_timing_condition timing_cond_wcl_fast \
                                                -late_timing_condition  timing_cond_wcl_fast \
                                                -early_rc_corner    rc_corner \
                                                -late_rc_corner     rc_corner


#===============================
#=    creata multi-modes       =
#===============================

create_constraint_mode -name functional_wcl_slow -sdc_files { \
    ../constraints/constraints_top.sdc   
}

create_constraint_mode -name functional_wcl_fast -sdc_files { \
    ../constraints/constraints_top.sdc   
}

#===============================
#=    creata multi-views       =
#===============================

create_analysis_view -name view_wcl_slow -constraint_mode functional_wcl_slow -delay_corner delay_corner_wcl_slow
create_analysis_view -name view_wcl_fast -constraint_mode functional_wcl_fast -delay_corner delay_corner_wcl_fast

set_analysis_view -setup { view_wcl_slow view_wcl_fast}