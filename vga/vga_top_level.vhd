library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_top_level is 
	PORT (X, CLK, RESET : in STD_LOGIC;
		  VGA_R, VGA_B, VGA_G : out STD_LOGIC_VECTOR (7 downto 0);
		  VGA_HSYNC, VGA_VSYNC, VGA_BLANKZ, VGA_CLOCK : out STD_LOGIC);
end vga_top_level;

architecture Structural of vga_top_level is
	signal S : STD_LOGIC_VECTOR (1 downto 0);
	signal hcount, vcount : STD_LOGIC_VECTOR (9 downto 0);
begin 
	STATE : entity work.state_generator port map (X => X, CLK => CLK, RESET => RESET, S => S);
	CONTROLLER : entity work.vga_controller port map (CLK => CLK, RESET => RESET, hcount => hcount, vcount => vcount, 
										  HSYNC => VGA_HSYNC, VSYNC => VGA_VSYNC, BLANK_Z => VGA_BLANKZ);
	RGBGEN : entity work.RGBGenerator port map (S => S, hcount => hcount, vcount => vcount, vga_r => VGA_R, vga_b => VGA_B, 
									vga_g => VGA_G);
	VGA_CLOCK <= CLK;
end Structural;