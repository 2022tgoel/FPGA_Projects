library ieee;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;

entity multiplier_tb is
end multiplier_tb;

architecture tb of multiplier_tb is
    signal A : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal B : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal prod : STD_LOGIC_VECTOR (6 downto 0);
begin
    -- connecting testbench signals with half_adder.vhd
    UUT : entity work.multiplier port map (A => A, B => B, prod => prod);
   -- A <= ('0', '0', '0', '0');
   -- B <= ('0', '0', '0');
    
    tb1 : process
    constant period : time := 10 ns;
    begin
        for i in 0 to 15 loop
            for j in 0 to 7 loop
                wait for period;
                B <= B + '1'; -- all possible A B combinations
            end loop;
            A <= A + '1';
            B <= "000";
        end loop;
    end process;        
end tb ;