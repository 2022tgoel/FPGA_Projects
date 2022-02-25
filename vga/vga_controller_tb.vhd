library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_controller_tb is
end vga_controller_tb;

architecture tb of vga_controller_tb is
    signal CLK : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal hcount, vcount : STD_LOGIC_VECTOR (9 downto 0);
    signal HSYNC, VSYNC : STD_LOGIC;
begin
    MODULE : entity work.vga_controller port map (CLK => CLK, RESET => RESET, hcount => hcount, vcount => vcount, 
                                                    HSYNC => HSYNC, VSYNC => VSYNC);

    process
    begin
        CLK <= not CLK;
        wait for 0.5 ns; 
    end process;

    --RESET <= '0', '1' after 80 ns, '0' after 120 ns, '1' after 600 ns, '0' after 650 ns;     
end tb ;