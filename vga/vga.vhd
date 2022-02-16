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
    process (CLK)
    begin
        if (rising_edge(CLK) and CE='1') then
            COUNT <= COUNT + 1;
        end if;
    end process;
    COUNT <= 0 when (COUNT=800);
    Q <= conv_std_logic_vector(COUNT, 9);
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
    process (CLK)
    begin
        if (rising_edge(CLK) and CE='1') then
            COUNT <= COUNT + 1;
        end if;
    end process;
    COUNT <= 0 when (COUNT=520);
    Q <= conv_std_logic_vector(COUNT, 9);
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
	component modulo_800_counter is -- for the hsync (row) cycles
		PORT (CE : in STD_LOGIC; -- component enabled
			  CLK : in STD_LOGIC;
			  RESET : in STD_LOGIC;
			  Q : out STD_LOGIC_VECTOR (9 downto 0));
	end component;
	component modulo_520_counter is -- for the vsync cycles
		PORT (CE : in STD_LOGIC; -- component enabled
			  CLK : in STD_LOGIC;
			  RESET : in STD_LOGIC;
			  Q : out STD_LOGIC_VECTOR (9 downto 0));
	end component;
	signal v_enabled : STD_LOGIC;
	signal hc_signal : STD_LOGIC_VECTOR (9 downto 0);
	signal vc_signal : STD_LOGIC_VECTOR (9 downto 0);
	signal hc : integer range 0 to 1000 := 0;
	signal vc : integer range 0 to 1000 := 0;
    
begin
	HCOUNTER : modulo_800_counter port map (CE => '1', CLK => CLK, RESET => RESET, Q => hc_signal);
	hc <= conv_integer(hc_signal);
	v_enabled <= '1' when (hc = 799) else '0';
	VCOUNTER : modulo_520_counter port map (CE => v_enabled, CLK => CLK, RESET => RESET, Q => vc_signal);
	vc <= conv_integer(vc_signal);
	hcount <= hc_signal;
	vcount <= vc_signal;
	HSYNC <= '1' when (hc >= 656 and hc < 752) else '0';
	VSYNC <= '1' when (vc >= 489 and vc < 491) else '0';
	BLANK_Z <= '1' when (hc <= 640 and vc < 480) else '0';
end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity one_pulse is -- makes the button press last exactly one clock cycle -> ensures it lasts long enough without lasting too long
	PORT (X, CLK, RESET : in STD_LOGIC;
		  O : out STD_LOGIC);
end one_pulse;

architecture Behavioral of one_pulse is
	signal idle : STD_LOGIC := '0';
begin
	process(CLK, RESET, X, idle)
	begin
		if (RESET = '1') then
			idle <= '1';
		elsif (rising_edge(CLK)) then
			if (X = '1' and idle = '1') then
				O <= '1';
				idle <= '0';
			elsif (X = '0') then
				O <= '0';
				idle <= '1';
			else 
				O <= '0';
			end if;
		end if;
	end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity color_fsm is
	PORT (X, CLK, RESET : in STD_LOGIC;
		  S : out STD_LOGIC_VECTOR (1 downto 0));
end color_fsm;

architecture Behavioral of color_fsm is
	signal state : STD_LOGIC_VECTOR (1 downto 0);
begin
	process(CLK, RESET, X)
	begin
		if (RESET = '1') then
			state <= "00";
		elsif (rising_edge(CLK) and X = '1') then
			state <= state + '1';
		end if;
	end process;
	S <= state;
end Behavioral;

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