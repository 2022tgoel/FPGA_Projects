-- start of adder code

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity full_adder is
	PORT (a : in STD_LOGIC;
		  b : in STD_LOGIC;
		  c : in STD_LOGIC; -- carry in
		  sum : out STD_LOGIC;
		  carry : out STD_LOGIC); -- carry out
end full_adder;

architecture Behavioral of full_adder is
begin
	sum <= (a xor b) xor c;
	carry <= (a and b) or (c and (a xor b));
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity four_bit_adder is
	PORT (a : in STD_LOGIC_VECTOR (3 downto 0);
		  b : in STD_LOGIC_VECTOR (3 downto 0);
		  sum : out STD_LOGIC_VECTOR (3 downto 0);
		  Cin : in STD_LOGIC;
		  Cout : out STD_LOGIC);
end four_bit_adder;

architecture Structural of four_bit_adder is
	component full_adder is 
		PORT (a,b,c : in STD_LOGIC;
			  sum, carry: out STD_LOGIC);
	end component;
	signal c : STD_LOGIC_VECTOR (3 downto 0);
begin
	FAO : full_adder port map (a(0), b(0), Cin, sum(0), c(1));
	FA1 : full_adder port map (a(1), b(1), c(1), sum(1), c(2));
	FA2 : full_adder port map (a(2), b(2), c(2), sum(2), c(3));
	FA4 : full_adder port map (a(3), b(3), c(3), sum(3), Cout);
end Structural;

-- end of adder code

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity multiplier is -- 4 bit number (a) times 3 bit number (b) -> max output = 15*7 = 105 -> 7 bit output 
	PORT (A : in STD_LOGIC_VECTOR (3 downto 0);
		  B : in STD_LOGIC_VECTOR (2 downto 0);
		  prod : out STD_LOGIC_VECTOR (6 downto 0) ); -- product
end multiplier;

architecture Structural of multiplier is
	component four_bit_adder is
		PORT (a : in STD_LOGIC_VECTOR (3 downto 0);
			  b : in STD_LOGIC_VECTOR (3 downto 0);
			  sum : out STD_LOGIC_VECTOR (3 downto 0);
			  Cin : in STD_LOGIC;
			  Cout : out STD_LOGIC);
	end component;
	signal ADD0, ADD1, ADD2, ADD3: STD_LOGIC_VECTOR(3 downto 0); -- inputs into the adders 
	signal S0, S1 : STD_LOGIC_VECTOR(3 downto 0); -- outputs of the adders
begin
	prod(0) <= A(0) and B(0);
	ADD0 <= ('0', A(3) and B(0), A(2) and B(0), A(1) and B(0));
	ADD1 <= (A(3) and B(1), A(2) and B(1), A(1) and B(1), A(0) and B(1));
	ADDER0 : four_bit_adder port map (a => ADD0, b => ADD1, Cin => '0', Cout => ADD2(3), 
									  sum(3 downto 1) => ADD2(2 downto 0), sum(0) => prod(1));
	ADD3 <= (A(3) and B(2), A(2) and B(2), A(1) and B(2), A(0) and B(2));
	ADDER1 : four_bit_adder port map (a => ADD2, b => ADD3, Cin => '0', Cout => prod(6), sum => prod(5 downto 2));
end Structural;