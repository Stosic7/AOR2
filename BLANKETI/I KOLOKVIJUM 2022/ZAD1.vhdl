library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity orGate is
    port (A : in std_logic;
          B : in std_logic;
          Y : out std_logic);
end orGate;

architecture orGate_arch of orGate is
begin
    Y <= A or B;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity xorGate is
    port (A : in std_logic;
          B : in std_logic;
          Y : out std_logic);
end xorGate;

architecture xorGate_arch of xorGate is
begin
    Y <= A xor B;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity kolo is
    generic ( n : natural := 4);
    port (a, b : std_logic_vector(n-1 downto 0);
          c : in std_logic;
          d_out: out std_logic_vector (n-1 downto 0));
end entity kolo;

architecture kolo_arch of kolo is
    signal sledeci: std_logic_vector(n-1 downto 0);

begin
    petlja: for i in 0 to n-1 generate
        signal veza: std_logic;

        begin
            cell: if i = d_out'right generate
            begin

                kom1: entity work.xorGate(xorGate_arch)
                port map(A => a(i), B => b(i), Y=> veza);

                kom2: entity work.orGate(orGate_arch)
                port map(A => veza, B => c, Y=>sledeci(i));

            end generate cell;

            cell2: if i/= d_out'right generate
            begin

                kom1: entity work.xorGate(xorGate_arch)
                port map(A => a(i), B => b(i), Y=> veza);

                kom2: entity work.orGate(orGate_arch)
                port map(A => veza, B => sledeci(i-1), Y=>sledeci(i));

            end generate cell2;

        end generate petlja;

        d_out <= sledeci;

    end architecture kolo_arch;

library IEEE;
use IEEE.std_logic_1164.all;

entity tb is
    generic(n : natural := 4);
end entity tb;

architecture tba of tb is
    signal a: std_logic_vector (n-1 downto 0);
    signal b: std_logic_vector (n-1 downto 0);
    signal c: std_logic;
    signal d_out: std_logic_vector (n-1 downto 0);

begin

    kom:entity work.kolo(kolo_arch)
        generic map(n)
        port map(a,b,c,d_out);

    stimulus: process is
    begin
        a <= "1010";
        b <= "0000";
        c <= '0';
        wait for 100ns;

    end process;
end architecture;
