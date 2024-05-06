library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd3 is
    port (clk : in std_logic;
          ce : in std_logic;
          wr: in std_logic;
          din : in std_logic_vector(11 downto 0);
          f : out std_logic_vector(11 downto 0));
end bcd3;

architecture bcd3_arch of bcd3 is
begin
    proc : process is
        variable f_int : integer := 0;
        variable a, b, c : integer;
    begin
        a := f_int / 100;
        b := (f_int / 10) mod 10;
        c := f_int mod 10;

        f <= std_logic_vector(to_unsigned(a, 4)) & std_logic_vector(to_unsigned(b, 4)) & std_logic_vector(to_unsigned(c,4));

        loop
            wait until (clk'event and clk = '1');
            if (wr = '1') then
                a := to_integer(unsigned(din(11 downto 8)));
                b := to_integer(unsigned(din(7 downto 4)));
                c := to_integer(unsigned(din(3 downto 0)));
                f_int := (a * 100) + (b * 10) + c;
                f <= std_logic_vector(to_unsigned(a, 4)) & std_logic_vector(to_unsigned(b, 4)) & std_logic_vector(to_unsigned(c,4));
            elsif (ce = '1') then
                f_int := (f_int + 1) mod 1000;
                a := f_int / 100;
                b := (f_int / 10) mod 10;
                c := f_int mod 10;
                f <= std_logic_vector(to_unsigned(a, 4)) & std_logic_vector(to_unsigned(b, 4)) & std_logic_vector(to_unsigned(c,4));
            end if;
        end loop;
    end process proc;
end architecture;
  
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end entity tb;

architecture tb_arch of tb is
    signal clk : std_logic;
    signal ce : std_logic;
    signal wr : std_logic;
    signal din : std_logic_vector(11 downto 0);
    signal f : std_logic_vector(11 downto 0);
   	
begin
    dut1 : entity work.bcd3(bcd3_arch)
        port map( clk => clk, ce => ce, wr => wr, din => din, f => f);
    
    clk <= not clk after 5 ns;
    
    stimulus: process is
    begin
        ce <= '1';
        wr <= '0';
        wait for 60 ns;
    
        din <= "011001100110";
        wr <= '1';
        wait for 5 ns;
    
        wr <= '0';
        wait for 100 ns;
    end process stimulus;
end architecture;
