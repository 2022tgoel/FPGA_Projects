library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_top_tb is
end vga_top_tb;

architecture tb of vga_top_tb is
    signal X, CLK, RESET : STD_LOGIC := '0';
    signal VGA_HSYNC, VGA_VSYNC : STD_LOGIC;
    signal DISPLAY_ANODE : STD_LOGIC;
    signal DISPLAY_CATHODE : STD_LOGIC_VECTOR (6 downto 0);
begin
    MODULE : entity work.vga_top_level port map (X => X, CLK => CLK, RESET => RESET, VGA_HSYNC => VGA_HSYNC, VGA_VSYNC => VGA_VSYNC,
                                                DISPLAY_CATHODE => DISPLAY_CATHODE, DISPLAY_ANODE => DISPLAY_ANODE);

    process
    begin
        CLK <= not CLK;
        wait for 0.5 ns; 
    end process;

    process
    begin
        X <= not X;
        wait for 60 ns; 
    end process;

    --RESET <= '0', '1' after 80 ns, '0' after 120 ns, '1' after 600 ns, '0' after 650 ns;     
end tb ;