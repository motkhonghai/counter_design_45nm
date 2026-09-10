#################################################################################
#
# Created by Genus(TM) Synthesis Solution 25.13-s071_1 on Thu Sep 10 11:32:48 +07 2026
#
#################################################################################

## library_sets
create_library_set -name wcl_slow \
    -timing { /home/icd1/workspace/counter_design_45nm/lib/slow_vdd1v0_basicCells.lib }
create_library_set -name wcl_fast \
    -timing { /home/icd1/workspace/counter_design_45nm/lib/fast_vdd1v0_basicCells.lib }

## opcond
create_opcond -name op_cond_wcl_slow \
    -process 1.0 \
    -voltage 0.9 \
    -temperature 125.0
create_opcond -name op_cond_wcl_fast \
    -process 1.0 \
    -voltage 1.1 \
    -temperature 0.0

## timing_condition
create_timing_condition -name timing_cond_wcl_slow \
    -opcond op_cond_wcl_slow \
    -library_sets { wcl_slow }
create_timing_condition -name timing_cond_wcl_fast \
    -opcond op_cond_wcl_fast \
    -library_sets { wcl_fast }

## rc_corner
create_rc_corner -name rc_corner \
    -qrc_tech /home/icd1/workspace/counter_design_45nm/QRC_Tech/gpdk045.tch \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0} \
    -post_route_clock_cross_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name delay_corner_wcl_slow \
    -early_timing_condition { timing_cond_wcl_slow } \
    -late_timing_condition { timing_cond_wcl_slow } \
    -early_rc_corner rc_corner \
    -late_rc_corner rc_corner
create_delay_corner -name delay_corner_wcl_fast \
    -early_timing_condition { timing_cond_wcl_fast } \
    -late_timing_condition { timing_cond_wcl_fast } \
    -early_rc_corner rc_corner \
    -late_rc_corner rc_corner

## constraint_mode
create_constraint_mode -name functional \
    -sdc_files { /home/icd1/workspace/counter_design_45nm/synthesis/outputs/mmmc/syn_opt_counter.cdb/cmn/counter.mmmc/modes/functional/functional.sdc.gz }

## analysis_view
create_analysis_view -name view_wcl_slow \
    -constraint_mode functional \
    -delay_corner delay_corner_wcl_slow \
    -latency_file /home/icd1/workspace/counter_design_45nm/synthesis/outputs/mmmc/syn_opt_counter.cdb/cmn/counter.mmmc/views/view_wcl_slow/latency.sdc.gz
create_analysis_view -name view_wcl_fast \
    -constraint_mode functional \
    -delay_corner delay_corner_wcl_fast \
    -latency_file /home/icd1/workspace/counter_design_45nm/synthesis/outputs/mmmc/syn_opt_counter.cdb/cmn/counter.mmmc/views/view_wcl_fast/latency.sdc.gz

## set_analysis_view
set_analysis_view -setup { view_wcl_slow view_wcl_fast } \
                  -hold { view_wcl_slow view_wcl_fast }
