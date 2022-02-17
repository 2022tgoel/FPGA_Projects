library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RGBGenerator is
    Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
           hcount : in  STD_LOGIC_VECTOR (9 downto 0);
           vcount : in  STD_LOGIC_VECTOR (9 downto 0);
           vga_r : out  STD_LOGIC_VECTOR (7 downto 0);
           vga_g : out  STD_LOGIC_VECTOR (7 downto 0);
           vga_b : out  STD_LOGIC_VECTOR (7 downto 0));
end RGBGenerator;

architecture Behavioral of RGBGenerator is

	signal hc : integer range 0 to 1000 := 0;
	signal vc : integer range 0 to 1000 := 0;

begin

	hc <= conv_integer(hcount);
	vc <= conv_integer(vcount);
	
	-- Draw vertical patter: [Red Green Blue White]
	vga_r <= "11111111" when (S = "00" or (S = "11" and (vc < 120 or vc >= 360))) else "00000000";
	vga_g <= "11111111" when (S = "01" or (S = "11" and ((vc >= 120 and vc < 240) or vc >= 360))) else "00000000";
	vga_b <= "11111111" when (S = "10" or (S = "11" and (vc >= 240))) else "00000000";
	
end Behavioral;
