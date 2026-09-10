# Genus/Innovus Common UI MMMC configuration for the counter design.
# All paths are resolved from this file so it can be loaded from any directory.

set _PROJECT_PATH [file dirname [file normalize [info script]]]

###############################################################################
## Library sets
###############################################################################

create_library_set \
    -name wcl_slow \
    -timing [list \
        [file join $_PROJECT_PATH lib slow_vdd1v0_basicCells.lib] \
    ]

create_library_set \
    -name wcl_fast \
    -timing [list \
        [file join $_PROJECT_PATH lib fast_vdd1v0_basicCells.lib] \
    ]

###############################################################################
## Operating conditions
###############################################################################

create_opcond \
    -name op_cond_wcl_slow \
    -process 1 \
    -voltage 0.9 \
    -temperature 125

create_opcond \
    -name op_cond_wcl_fast \
    -process 1 \
    -voltage 1.1 \
    -temperature 0

###############################################################################
## Timing conditions
###############################################################################

create_timing_condition \
    -name timing_cond_wcl_slow \
    -library_sets [list wcl_slow] \
    -opcond op_cond_wcl_slow

create_timing_condition \
    -name timing_cond_wcl_fast \
    -library_sets [list wcl_fast] \
    -opcond op_cond_wcl_fast

###############################################################################
## RC corners
###############################################################################

# Use the GPDK045 extraction technology supplied with this project.
create_rc_corner \
    -name rc_corner \
    -qrc_tech [file join $_PROJECT_PATH QRC_Tech gpdk045.tch]

###############################################################################
## Delay corners
###############################################################################

create_delay_corner \
    -name delay_corner_wcl_slow \
    -early_timing_condition timing_cond_wcl_slow \
    -late_timing_condition timing_cond_wcl_slow \
    -early_rc_corner rc_corner \
    -late_rc_corner rc_corner

create_delay_corner \
    -name delay_corner_wcl_fast \
    -early_timing_condition timing_cond_wcl_fast \
    -late_timing_condition timing_cond_wcl_fast \
    -early_rc_corner rc_corner \
    -late_rc_corner rc_corner

###############################################################################
## Constraint modes
###############################################################################

# Both PVT corners use the same functional SDC constraints.
create_constraint_mode \
    -name functional \
    -sdc_files [list \
        [file join $_PROJECT_PATH constraints constraints_top.sdc] \
    ]

###############################################################################
## Analysis views
###############################################################################

create_analysis_view \
    -name view_wcl_slow \
    -constraint_mode functional \
    -delay_corner delay_corner_wcl_slow

create_analysis_view \
    -name view_wcl_fast \
    -constraint_mode functional \
    -delay_corner delay_corner_wcl_fast

###############################################################################
## Active views
###############################################################################

# Keep both available PVT views active for setup and hold analysis.
set_analysis_view \
    -setup [list view_wcl_slow view_wcl_fast] \
    -hold [list view_wcl_slow view_wcl_fast]
