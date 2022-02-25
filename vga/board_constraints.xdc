# reference: https://github.com/Digilent/Nexys-4-DDR-OOB/blob/master/src/constraints/Nexys4DDR_C.xdc 

# input
set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports X]
set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports RESET]
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports CLK]

# VGA
set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS33 } [get_ports VGA_R[0]]
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS33 } [get_ports VGA_R[1]]
set_property -dict { PACKAGE_PIN C5 IOSTANDARD LVCMOS33 } [get_ports VGA_R[2]]
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS33 } [get_ports VGA_R[3]]
set_property -dict { PACKAGE_PIN C6 IOSTANDARD LVCMOS33 } [get_ports VGA_B[0]]
set_property -dict { PACKAGE_PIN A5 IOSTANDARD LVCMOS33 } [get_ports VGA_B[1]]
set_property -dict { PACKAGE_PIN B6 IOSTANDARD LVCMOS33 } [get_ports VGA_B[2]]
set_property -dict { PACKAGE_PIN A6 IOSTANDARD LVCMOS33 } [get_ports VGA_B[3]]
set_property -dict { PACKAGE_PIN B7 IOSTANDARD LVCMOS33 } [get_ports VGA_G[0]]
set_property -dict { PACKAGE_PIN C7 IOSTANDARD LVCMOS33 } [get_ports VGA_G[1]]
set_property -dict { PACKAGE_PIN D7 IOSTANDARD LVCMOS33 } [get_ports VGA_G[2]]
set_property -dict { PACKAGE_PIN D8 IOSTANDARD LVCMOS33 } [get_ports VGA_G[3]]
set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports VGA_HSYNC]
set_property -dict { PACKAGE_PIN B12 IOSTANDARD LVCMOS33 } [get_ports VGA_VSYNC]

# LEDs instead - just for debugging purposes
set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_CATHODE[6]]
set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_CATHODE[5]]
set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_CATHODE[4]]
set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_CATHODE[3]]
set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_CATHODE[2]]
set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_CATHODE[1]]
set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_CATHODE[0]]
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports DISPLAY_ANODE]

