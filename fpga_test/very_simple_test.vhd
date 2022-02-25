library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- lights up O1

entity very_simple_test is
	PORT (O1 : out STD_LOGIC;
		  O2 : out STD_LOGIC);
end very_simple_test;

architecture Behavioral of very_simple_test is
begin 
	O1 <= '1';
	O2 <= '0';
end Behavioral;