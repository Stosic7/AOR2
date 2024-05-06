library IEEE;
use IEEE.std_logic_1164.all;

entity tflipflop is
    port (
        d : in bit;
        clk : in bit;
        rst : in bit;
        f : out bit
    );
end entity tflipflop;

architecture tflipflop_arch of tflipflop is
    signal rct : std_logic_vector(2 downto 0);
    signal nf : bit;
begin
    RCT <= rst & clk & d;
    nf <= not f when clk'event and clk = '1';

    with RCT select
        f <= '0' when "100",
             '0' when "101",
             '0' when "110",
             '0' when "111",
             nf when "011",
             f when others;
end architecture tflipflop_arch;

library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end entity tb;

architecture tb_arch of tb is
    signal d : bit;
    signal rst : bit;
    signal f : bit;
    signal clk : bit := '0';
begin
    dut : entity work.tflipflop(tflipflop_arch)
        port map(d => d, rst => rst, f => f, clk => clk);

    clk <= not clk after 5 ns;

    stim : process
    begin
        d <= '1';
        wait for 6 ns;

        d <= '0';
        wait for 15 ns;

        rst <= '1';
        wait for 6 ns;

        rst <= '0';
        wait for 10 ns;

        d <= '1';
        wait for 10 ns;

        d <= '0';
        wait for 20 ns;
    end process stim;
end architecture tb_arch;
