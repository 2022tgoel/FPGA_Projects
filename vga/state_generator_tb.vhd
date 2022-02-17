library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity state_generator_tb is
end state_generator_tb;

architecture tb of state_generator_tb is
    signal X, CLK, RESET : STD_LOGIC := '0';
    signal S : STD_LOGIC_VECTOR (1 downto 0) := "00";
begin
    MODULE : entity work.state_generator port map (X => X, CLK => CLK, RESET => RESET, S => S);

    process
    begin
        CLK <= not CLK;
        wait for 10 ns; -- 20 ns for each clock cycle
    end process;

    process
    begin
        X <= not X;
        wait for 60 ns; -- 3 clock cycles
    end process;

    RESET <= '0', '1' after 80 ns, '0' after 120 ns, '1' after 600 ns, '0' after 650 ns;     
end tb ;