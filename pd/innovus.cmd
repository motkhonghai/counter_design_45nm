#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Tue Sep  8 14:38:09 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v25.13-s088_1 (64bit) 03/26/2026 12:37 (Linux 4.18.0-305.el8.x86_64)
#@(#)CDS: NanoRoute 25.13-s088_1 NR260309-1855/25_13-UB (database version 18.20.683) {superthreading v2.20}
#@(#)CDS: AAE 25.13-s023 (64bit) 03/26/2026 (Linux 4.18.0-305.el8.x86_64)
#@(#)CDS: CTE 25.13-s044_1 () Mar 24 2026 17:45:14 ( )
#@(#)CDS: SYNTECH 25.13-s012_1 () Mar 10 2026 03:01:02 ( )
#@(#)CDS: CPE v25.13-s019
#@(#)CDS: IQuantus/TQuantus 24.1.0-s476 (64bit) Wed Feb 11 22:11:27 PST 2026 (Linux 4.18.0-305.el8.x86_64)

gui_select -point {0.06400 0.07400}
set_db init_power_nets VDD
set_db init_ground_nets VSS
read_mmmc ../mmmc.tcl
#@ Begin verbose source ../mmmc.tcl (pre)
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
create_constraint_mode -name functional_wcl_slow -sdc_files { \
    ../constraints/constraints_top.sdc   
}
create_constraint_mode -name functional_wcl_fast -sdc_files { \
    ../constraints/constraints_top.sdc   
}
create_analysis_view -name view_wcl_slow -constraint_mode functional_wcl_slow -delay_corner delay_corner_wcl_slow
create_analysis_view -name view_wcl_fast -constraint_mode functional_wcl_fast -delay_corner delay_corner_wcl_fast
set_analysis_view -setup { view_wcl_slow view_wcl_fast}
#@ End verbose source ../mmmc.tcl
