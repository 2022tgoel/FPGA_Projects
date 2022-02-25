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
	signal VGA_CLK : STD_LOGIC; -- the 25 Mhz clock
begin 
	CLOCK_DIVIDER : entity work.clock_divider port map (BOARD_CLK => CLK, CLK => VGA_CLK);
	STATE : entity work.state_generator port map (X => X, CLK => VGA_CLK, RESET => RESET, S => S, LED => DISPLAY_CATHODE);
	CONTROLLER : entity work.vga_controller port map (CLK => VGA_CLK, RESET => RESET, hcount => hcount, vcount => vcount, 
										  HSYNC => VGA_HSYNC, VSYNC => VGA_VSYNC);
	RGBGEN : entity work.RGBGenerator port map (S => S, hcount => hcount, vcount => vcount, vga_r => VGA_R, vga_b => VGA_B, 
									vga_g => VGA_G);
	DISPLAY_ANODE <= '0';
end Structural;	