library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux4u1 is
    port (a, b, c, d : in signed(0 downto 0);
          s : in std_logic_vector(1 downto 0);
          f : out signed(0 downto 0));
end mux4u1;

architecture mux4u1_arch of mux4u1 is
begin
    process(a, b, c, d, s)
    begin
        if s = "00" then
            f <= a;
        elsif s = "01" then
            f <= b;
        elsif s = "10" then
            f <= c;
        elsif s = "11" then
            f <= d;
        else
            f <= "X";
        end if;
    end process;
end architecture mux4u1_arch;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is
end tb;

architecture tb_arch of tb is
    signal a, b, c, d, f : signed(0 downto 0);
    signal s : std_logic_vector(1 downto 0);
    
begin
    dut1 : port map( a => a, b => b, c => c, d => d, s => s, f => f);
    
    stimuli: process is
    begin
        a <= '1';
        b <= '0';    
        c <= '1';
        d <= '1';

        s <= "00";
        wait for 2 ns;
        
        s <= "01";
        wait for 2 ns;
        
        s <= "10";
        wait for 2 ns;

        s <= "11";
        wait for 2 ns;
        
        d <= '0';
        wait for 2 ns;
        
        s <= "10";
        wait for 2 ns;
        
        s <= "XX";
        wait for 2 ns;

    end process stimuli;
end ARCHITECTURE tb_arch;
