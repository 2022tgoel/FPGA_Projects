library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity one_pulse_tb is
end one_pulse_tb;

architecture tb of one_pulse_tb is
    signal X, CLK, RESET : STD_LOGIC := '0';
    signal O : STD_LOGIC := '0';
begin
    ONEPULSE : entity work.one_pulse port map (X => X, CLK => CLK, RESET => RESET, O => O);

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

    -- RESET <= '0', '1' after 80 ns, '0' after 120 ns;     
end tb ;