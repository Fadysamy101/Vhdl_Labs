create_clock -name clk50mhz -period 20.0ns [get_ports clk]

	
derive_pll_clocks

derive_clock_uncertainty

set_false_path -from [get_ports rst_button] -to [get_registers *Reset_Sync*]
set_false_path -from [get_ports enable_button] -to [get_registers *Enb_Sync*]




set_false_path -to [get_ports seg_display_2[*]]
set_false_path -to [get_ports seg_display_3[*]]
set_false_path -to [get_ports seg_display_4[*]]

