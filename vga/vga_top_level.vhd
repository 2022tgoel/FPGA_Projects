library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_top_level is 
	PORT (X, CLK, RESET : in STD_LOGIC;
		  VGA_R, VGA_B, VGA_G : out STD_LOGIC_VECTOR (3 downto 0);
		  VGA_HSYNC, VGA_VSYNC : out STD_LOGIC;
		  DISPLAY_ANODE : out STD_LOGIC;
		  DISPLAY_CATHODE : out STD_LOGIC_VECTOR (6 downto 0));
end vga_top_level;

architecture Structural of vga_top_level is
	signal S : STD_LOGIC_VECTOR (1 downto 0) := "00";
	signal hcount, vcount : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal hc, vc : integer range 0 to 1000 := 0;
	signal VGA_CLK : STD_LOGIC; -- the 25 Mhz clock
begin 
	CLOCK_DIVIDER : entity work.clock_divider port map (BOARD_CLK => CLK, CLK => VGA_CLK);
	STATE : entity work.state_generator port map (X => X, CLK => VGA_CLK, RESET => RESET, S => S, LED => DISPLAY_CATHODE);
	CONTROLLER : entity work.vga_controller port map (CLK => VGA_CLK, RESET => RESET, hcount => hcount, vcount => vcount, 
										  HSYNC => VGA_HSYNC, VSYNC => VGA_VSYNC);
	hc <= conv_integer(hcount);
	vc <= conv_integer(vcount);
	
    VGA_R <=  "1111" when (hc < 640 and vc < 480) and (S = "00" or (S = "11" and (vc < 120 or vc >= 360))) else "0000";
	VGA_G <= "1111" when (hc < 640 and vc < 480) and (S = "01" or (S = "11" and ((vc >= 120 and vc < 240) or vc >= 360))) else "0000";
	VGA_B <= "1111" when (hc < 640 and vc < 480) and (S = "10" or (S = "11" and (vc >= 240))) else "0000";
	
	DISPLAY_ANODE <= '0';
end Structural;	