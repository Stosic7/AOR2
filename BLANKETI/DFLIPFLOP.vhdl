library IEEE;
use IEEE.std_logic_1164.all;

entity dflipflop is
    port (
        clk : in  bit;
        rst : in  bit;
        d   : in  bit;
        q   : out bit
    );
end entity dflipflop;

architecture dflipflop_arch of dflipflop is
begin
    tick : process (clk, rst) is
    begin
        if rst = '1' then
            q <= '0' after 2 ns;
        elsif rising_edge(clk) then
            q <= d after 2 ns;
        end if;
    end process;
end architecture dflipflop_arch;

library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end entity tb;

architecture tb_arch of tb is
    signal clk : bit := '0';
    signal rst : bit := '0';
    signal d : bit := '0';
    signal q : bit;

begin
    dut : entity work.dflipflop(dflipflop_arch)
        port map( d => d, clk => clk, rst => rst, q => q);
    
    
    clk <= not clk after 5 ns;
    
    stimuli : process is
    begin
        d <= '1';
        wait for 2 ns;
        
        d <= '0';
        wait for 2 ns;
    end process;
end architecture tb_arch;
