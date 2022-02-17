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
		if (rising_edge(CLK)) then
			if (RESET = '1') then
				state <= "00";
			elsif (X = '1') then
				state <= state + '1';
			end if;
		end if;
	end process;
	S <= state;
end Behavioral;
