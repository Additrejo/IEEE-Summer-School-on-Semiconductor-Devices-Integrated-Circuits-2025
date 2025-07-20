set_units -time ns
create_clock -period 10 -name clk -waveform {0 5} -add [get_ports clk]
set_false_path -from [get_ports {rst select}]
set_output_delay -clock clk 2 [get_ports {count[*]}]