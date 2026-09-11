if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name wcl_fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast_vdd1v0_basicCells.lib]
create_library_set -name wcl_slow\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow_vdd1v0_basicCells.lib]
create_opcond -name op_cond_wcl_fast -process 1 -voltage 1.1 -temperature 0
create_opcond -name op_cond_wcl_slow -process 1 -voltage 0.9 -temperature 125
create_timing_condition -name timing_cond_wcl_slow\
   -library_sets [list wcl_slow]\
   -opcond op_cond_wcl_slow
create_timing_condition -name timing_cond_wcl_fast\
   -library_sets [list wcl_fast]\
   -opcond op_cond_wcl_fast
create_rc_corner -name rc_corner\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -post_route_clock_cap {1 1 1}\
   -post_route_clock_res {1 1 1}\
   -post_route_clock_cross_cap {1 1 1}\
   -qrc_tech ${::IMEX::libVar}/mmmc/rc_corner/gpdk045.tch
create_delay_corner -name delay_corner_wcl_slow\
   -early_timing_condition {timing_cond_wcl_slow}\
   -late_timing_condition {timing_cond_wcl_slow}\
   -rc_corner rc_corner
create_delay_corner -name delay_corner_wcl_fast\
   -early_timing_condition {timing_cond_wcl_fast}\
   -late_timing_condition {timing_cond_wcl_fast}\
   -rc_corner rc_corner
create_constraint_mode -name functional\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/functional/functional.sdc.gz]
create_analysis_view -name view_wcl_slow -constraint_mode functional -delay_corner delay_corner_wcl_slow -latency_file ${::IMEX::dataVar}/mmmc/views/view_wcl_slow/latency.sdc.gz
create_analysis_view -name view_wcl_fast -constraint_mode functional -delay_corner delay_corner_wcl_fast -latency_file ${::IMEX::dataVar}/mmmc/views/view_wcl_fast/latency.sdc.gz
set_analysis_view -setup [list view_wcl_slow view_wcl_fast] -hold [list view_wcl_slow view_wcl_fast]
catch {set_interactive_constraint_mode [list functional] } 
