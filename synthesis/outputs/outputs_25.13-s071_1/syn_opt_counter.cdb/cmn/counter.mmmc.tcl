#################################################################################
#
# Created by Genus(TM) Synthesis Solution 25.13-s071_1 on Wed Sep 09 09:07:15 +07 2026
#
#################################################################################

## library_sets
create_library_set -name wcl_slow \
    -timing { /home/icd1/workspace/counter_design_45nm/synthesis/../lib/slow_vdd1v0_basicCells.lib }
create_library_set -name wcl_fast \
    -timing { /home/icd1/workspace/counter_design_45nm/synthesis/../lib/fast_vdd1v0_basicCells.lib }

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
    -cap_table /home/icd1/workspace/counter_design_45nm/synthesis/../captable/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl \
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
create_constraint_mode -name functional_wcl_slow \
    -sdc_files { outputs/outputs_25.13-s071_1/syn_opt_counter.cdb/cmn/counter.mmmc/modes/functional_wcl_slow/functional_wcl_slow.sdc.gz }
create_constraint_mode -name functional_wcl_fast \
    -sdc_files { outputs/outputs_25.13-s071_1/syn_opt_counter.cdb/cmn/counter.mmmc/modes/functional_wcl_fast/functional_wcl_fast.sdc.gz }

## analysis_view
create_analysis_view -name view_wcl_slow \
    -constraint_mode functional_wcl_slow \
    -delay_corner delay_corner_wcl_slow \
    -latency_file outputs/outputs_25.13-s071_1/syn_opt_counter.cdb/cmn/counter.mmmc/views/view_wcl_slow/latency.sdc.gz
create_analysis_view -name view_wcl_fast \
    -constraint_mode functional_wcl_fast \
    -delay_corner delay_corner_wcl_fast \
    -latency_file outputs/outputs_25.13-s071_1/syn_opt_counter.cdb/cmn/counter.mmmc/views/view_wcl_fast/latency.sdc.gz

## set_analysis_view
set_analysis_view -setup { view_wcl_slow view_wcl_fast } \
                  -hold { view_wcl_slow view_wcl_fast }
