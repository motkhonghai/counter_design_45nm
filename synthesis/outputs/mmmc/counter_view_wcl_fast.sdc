# ####################################################################

#  Created by Genus(TM) Synthesis Solution 25.13-s071_1 on Thu Sep 10 11:33:19 +07 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design counter

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports rst]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {count[0]}]
set_clock_uncertainty -setup 0.01 [get_ports clk]
set_clock_uncertainty -hold 0.01 [get_ports clk]
