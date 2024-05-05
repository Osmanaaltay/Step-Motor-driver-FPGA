# Basys 3 Pin Atama
# -------------------

# Clock
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# İkinci Clock (clk_2)
set_property PACKAGE_PIN Y9 [get_ports clk_2]
set_property IOSTANDARD LVCMOS33 [get_ports clk_2]
create_clock -add -name sys_clk_pin_2 -period 10.00 -waveform {0 5} [get_ports clk_2]

# Reset
set_property PACKAGE_PIN W3 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Adım Çıkışları
set_property PACKAGE_PIN U16 [get_ports {step[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {step[0]}]
set_property PACKAGE_PIN E19 [get_ports {step[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {step[1]}]
set_property PACKAGE_PIN U19 [get_ports {step[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {step[2]}]
set_property PACKAGE_PIN V19 [get_ports {step[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {step[3]}]

# Yön Girişi
set_property PACKAGE_PIN W19 [get_ports direction_input]
set_property IOSTANDARD LVCMOS33 [get_ports direction_input]
