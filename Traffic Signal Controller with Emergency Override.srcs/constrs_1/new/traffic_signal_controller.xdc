## CLOCK - 100 MHz
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]


## RESET - Center Button
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports reset]


## EMERGENCY - Up Button
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports emergency]


## PEDESTRIAN REQUEST - Left Button
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports pedestrian_req]


## RED LIGHT - LED0
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports red]


## YELLOW LIGHT - LED1
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports yellow]


## GREEN LIGHT - LED2
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports green]


## PEDESTRIAN WALK - LED3
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports pedestrian_walk]