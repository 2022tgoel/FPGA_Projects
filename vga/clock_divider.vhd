library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is 
    PORT(BOARD_CLK : in STD_LOGIC; -- clock from the fpga board, 100 Mhz
        CLK : out STD_LOGIC); -- clock for VGA Resolution (640x480@60Hz), 25 Mhz
end clock_divider;

architecture Behavioral of clock_divider is
    signal CLK_ARR : STD_LOGIC_VECTOR (1 downto 0) := "00";
begin
    process (BOARD_CLK)
    begin
        if (rising_edge(BOARD_CLK)) then
            CLK_ARR <= CLK_ARR + '1';
        end if;
    end process;

    CLK <= CLK_ARR(1);
end Behavioral;