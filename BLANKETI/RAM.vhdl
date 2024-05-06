library IEEE;
use IEEE.std_logic_1164.all;

entity ram is
    port (
        rd : in bit;
        wr : in bit;
        index : in integer range 0 to 63;
        d : in real;
        q : out real
    );
end ram;

architecture ram_arch of ram is
begin
    process
        type niz is array(integer range 0 to 63) of real;
        variable mem : niz;
    begin
        for i in 0 to 63 loop
            mem(i) := 0.0;
        end loop;

        loop
            wait on rd, wr, d, index;
            if rd = '1' then
                q <= mem(index);
            end if;
            if wr = '1' then
                mem(index) := d;
            end if;
        end loop;
    end process;
end architecture ram_arch;

entity tb is
end entity tb;

architecture tba of tb is
    signal rd : bit := '0';
    signal wr : bit := '0';
    signal index : integer range 0 to 63 := 0;
    signal d : real := 0.0;
    signal q : real;
begin
    dut : entity work.ram(ram_arch)
        port map(rd => rd, wr => wr, index => index, d => d, q => q);

    s : process is
    begin
        index <= 2;
        d <= 2.3;
        wr <= '1';
        wait for 100 ns;
        index <= 3;
        d <= 5.0;
        wait for 100 ns;
        index <= 2;
        wr <= '0';
        rd <= '1';
        wait for 100 ns;
        index <= 3;
        wait for 100 ns;
    end process s;
end tba;
