library IEEE;
use IEEE.std_logic_1164.all;

entity p2s is
    port (
        ulaz : in std_logic_vector(3 downto 0);
        clk : in std_logic;
        izlaz : out std_logic
    );
end entity p2s;

architecture p2s_arch of p2s is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            for i in 3 downto 0 loop
                izlaz <= ulaz(i);
                wait for 2 ns;
            end loop;
        end if;
    end process;
end architecture p2s_arch;

library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
end entity tb;

architecture tb_arch of tb is
    signal ulaz : std_logic_vector(3 downto 0);
    signal izlaz : std_logic;
    signal clk : std_logic := '0';
begin
    dut : entity work.p2s(p2s_arch)
        port map(ulaz => ulaz, clk => clk, izlaz => izlaz);
        
    stimulus : process
    begin
        ulaz <= "0101";
        clk <= not clk after 5 ns;
        wait for 10 ns;
        
        ulaz <= "1100";
        wait for 10 ns;
    end process;
end architecture tb_arch;
