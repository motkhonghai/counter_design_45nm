###############################################################################
# Stage 7: Export final database, netlist, DEF, SDC and GDSII
# Run: innovus -stylus -files 7_export.tcl
###############################################################################

###############################
# Setup - global variables
###############################
set STAGE  7_export
set DESIGN counter

set INPUT_DB    /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_finish
set OUTPUT_PATH /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc
set REPORT_PATH /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/reports/mmmc/7_export
set OUTPUT_DB   /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_final
set NETLIST     /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_post_pnr.v
set DEF_FILE    /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_post_pnr.def
set SLOW_SDC    /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_post_pnr_view_wcl_slow.sdc
set FAST_SDC    /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_post_pnr_view_wcl_fast.sdc
set STREAM_MAP  /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/streamOut.map
set GDS_FILE    /home/tienpnh/workspace/cadence/counter_design_45nm/physical_design/outputs/mmmc/counter_final.gds

file mkdir $OUTPUT_PATH
file mkdir $REPORT_PATH

###############################
# Check and read input database
###############################
if {![file exists $INPUT_DB]} {
    error "Stage 6 database not found: $INPUT_DB"
}

if {![file exists $STREAM_MAP]} {
    error "GDSII stream-out map not found: $STREAM_MAP"
}

read_db $INPUT_DB

###############################
# Save final database
###############################
write_db $OUTPUT_DB

###############################
# Export netlist and DEF
###############################
write_netlist $NETLIST
write_def $DEF_FILE

###############################
# Export SDC for both MMMC views
###############################
write_sdc -view view_wcl_slow > $SLOW_SDC
write_sdc -view view_wcl_fast > $FAST_SDC

###############################
# Export GDSII
###############################
# streamOut.map converts Innovus layer/purpose names into GDS layer/datatype.
# A tapeout GDS must also merge the standard-cell GDS delivered by the PDK.
write_stream -map_file $STREAM_MAP $GDS_FILE

puts "Final runtime and memory:"
time_info FINAL
puts "Done $STAGE"
puts "Saved database: $OUTPUT_DB"
puts "Netlist: $NETLIST"
puts "DEF: $DEF_FILE"
puts "GDSII: $GDS_FILE"
