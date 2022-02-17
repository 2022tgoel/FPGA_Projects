library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity state_generator is 
	PORT (X, CLK, RESET : in STD_LOGIC;
		  S : out STD_LOGIC_VECTOR (1 downto 0));
end state_generator;

architecture Behavioral of state_generator is
	signal O : STD_LOGIC;
begin 
	ONEPULSE : entity work.one_pulse port map (X => X, CLK => CLK, RESET => RESET, O => O);
	FSM : entity work.color_fsm port map (X => O, CLK => CLK, RESET => RESET, S => S);
end Behavioral;