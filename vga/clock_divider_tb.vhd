library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider_tb is
end clock_divider_tb;

architecture tb of clock_divider_tb is
    signal INPUT_CLK, VGA_CLK : STD_LOGIC := '0';
begin
    DIVIDER : entity work.clock_divider port map (BOARD_CLK => INPUT_CLK, CLK => VGA_CLK);

    process
    begin
        INPUT_CLK <= not INPUT_CLK;
        wait for 10 ns; -- 20 ns for each clock cycle
    end process;  
end tb ;