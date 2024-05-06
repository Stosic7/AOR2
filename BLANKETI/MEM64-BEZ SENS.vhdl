library IEEE;
use IEEE.std_logic_1164.all;

entity mem64 is
    port (
        d : in real;
        da : in integer range 0 to 63;
        wr : in bit;
        rd : in bit;
        f : out real
    );
end entity mem64;

architecture mem64_arch of mem64 is
begin
    proc : process is
        type niz is array (integer range 0 to 63) of real;
        variable mem : niz;
    begin
        wait on wr, rd, da;
        if wr = '1' then
            mem(da) := d;
        elsif rd = '1' then
            f <= mem(da);
        end if;
    end process;
end architecture mem64_arch;

library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end entity tb;

architecture tbArch of tb is
    signal d_in : real;
    signal d_adr : integer range 0 to 63;
    signal wr, rd : bit;
    signal f : real;
    
    component mem64
        port (
            d : in real;
            da : in integer range 0 to 63;
            wr : in bit;
            rd : in bit;
            f : out real
        );
    end component mem64;
    
begin
    dut1 : mem64 port map(
        d => d_in,
        da => d_adr,
        wr => wr,
        rd => rd,
        f => f
    );
    
    proc : process is
    begin
        wr <= '1';
        rd <= '0';
        d_in <= 0.0;
        
        for i in 0 to 63 loop
            d_adr <= i;
            wait for 5ns;
        end loop;
        
        d_in <= 12.5;
        d_adr <= 5;
        wait for 50ns;
        
        d_in <= 6.6;
        d_adr <= 10;
        wait for 50ns;
        
        wr <= '0';
        rd <= '1';
        
        for i in 0 to 63 loop
            d_adr <= i;
            wait for 5ns;
        end loop;
        
        wait;
    end process;
end ARCHITECTURE tbArch;
