-- source lab: https://www.seas.upenn.edu/~ese171/labs12/Lab6_VGA.pdf
-- reading for understanding how to achieve sequential, as opposed to concurrent, execution using processes: https://cse.usf.edu/~haozheng/teach/cda4253/doc/vhdl-stmt.pdf

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity modulo_800_counter is -- for the hsync (row) cycles
	PORT (CE : in STD_LOGIC; -- component enabled
		  CLK : in STD_LOGIC;
		  RESET : in STD_LOGIC;
		  Q : out STD_LOGIC_VECTOR (9 downto 0));
end modulo_800_counter;

architecture Behavioral of modulo_800_counter is
	signal COUNT : integer range 0 to 1000 := 0;
begin
    process (CLK, RESET, CE)
    begin
    	if (RESET = '0') then
    		COUNT <= 0;
        elsif (rising_edge(CLK) and CE='1') then
            COUNT <= COUNT + 1;
        end if;
        if (COUNT>=800) then
        	COUNT <= 0;
        end if;
    end process;
    Q <= conv_std_logic_vector(COUNT, 10);
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity modulo_520_counter is -- for the hsync (row) cycles
	PORT (CE : in STD_LOGIC; -- component enabled
		  CLK : in STD_LOGIC;
		  RESET : in STD_LOGIC;
		  Q : out STD_LOGIC_VECTOR (9 downto 0));
end modulo_520_counter;

architecture Behavioral of modulo_520_counter is
	signal COUNT : integer range 0 to 1000 := 0;
begin
    process (CLK, RESET, CE)
    begin
    	if (RESET = '0') then
    		COUNT <= 0;
        elsif (rising_edge(CLK) and CE='1') then
            COUNT <= COUNT + 1;
        end if;
        if (COUNT>=520) then
        	COUNT <= 0;
        end if;
    end process;
    Q <= conv_std_logic_vector(COUNT, 10);
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_controller is
  	PORT (CLK : in STD_LOGIC;
		  RESET : in STD_LOGIC;
		  hcount, vcount : out STD_LOGIC_VECTOR (9 downto 0);
		  HSYNC, VSYNC, BLANK_Z : out STD_LOGIC);
end vga_controller;

architecture Structural of vga_controller is
	signal v_enabled : STD_LOGIC;
	signal hc_signal : STD_LOGIC_VECTOR (9 downto 0);
	signal vc_signal : STD_LOGIC_VECTOR (9 downto 0);
	signal hc : integer range 0 to 1000 := 0;
	signal vc : integer range 0 to 1000 := 0;
    
begin
	HCOUNTER : entity work.modulo_800_counter port map (CE => '1', CLK => CLK, RESET => RESET, Q => hc_signal);
	hc <= conv_integer(hc_signal);
	v_enabled <= '1' when (hc = 799) else '0';
	VCOUNTER : entity work.modulo_520_counter port map (CE => v_enabled, CLK => CLK, RESET => RESET, Q => vc_signal);
	vc <= conv_integer(vc_signal);
	hcount <= hc_signal;
	vcount <= vc_signal;
	HSYNC <= '1' when (hc >= 656 and hc < 752) else '0';
	VSYNC <= '1' when (vc >= 489 and vc < 491) else '0';
	BLANK_Z <= '1' when (hc < 640 and vc < 480) else '0';
end Structural;