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
		if (rising_edge(CLK)) then
			if (RESET = '1') then
				O <= '0';
				idle <= '1';
			elsif (X = '1' and idle = '1') then
				O <= '1';
				idle <= '0';
			elsif (X = '0') then	
				idle <= '1';
			else 
				O <= '0';
			end if;
		end if;
	end process;
end Behavioral;