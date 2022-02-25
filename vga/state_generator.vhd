library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity state_generator is 
	PORT (X, CLK, RESET : in STD_LOGIC;
		  S : out STD_LOGIC_VECTOR (1 downto 0);
		  LED : out STD_LOGIC_VECTOR (6 downto 0)); -- LED for the 7-segment display
end state_generator;

architecture Structural of state_generator is
	signal O : STD_LOGIC;
	signal INTER : STD_LOGIC_VECTOR (1 downto 0); -- intermediate output
begin 
	ONEPULSE : entity work.one_pulse port map (X => X, CLK => CLK, RESET => RESET, O => O);
	FSM : entity work.color_fsm port map (X => O, CLK => CLK, RESET => RESET, S => INTER);
	process (INTER)
	begin
		if (INTER = "00") then
			LED <= "0000001";
		elsif (INTER = "01") then
			LED <= "0011111";
		elsif (INTER = "10") then
			LED <= "0010010";
		elsif (INTER = "11") then
			LED <= "0000110";
		end if;
	end process;
	S <= INTER;
end Structural;