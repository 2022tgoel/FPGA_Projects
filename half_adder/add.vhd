library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity half_adder is
	PORT (a : in STD_LOGIC;
		  b : in STD_LOGIC;
		  sum : out STD_LOGIC;
		  carry : out STD_LOGIC); -- carry out
end half_adder;

architecture Behavioral of half_adder is
begin
	sum <= (a xor b);
	carry <= (a and b);
end Behavioral;