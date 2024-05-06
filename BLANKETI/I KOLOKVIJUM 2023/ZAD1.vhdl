library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd is
    port (clk : in std_logic;
          clr : in std_logic;
          we : in std_logic;
          d_in : in std_logic_vector(3 downto 0);
          f : out std_logic_vector(3 downto 0));
end entity;

architecture bcd_arch of bcd is
begin
    process (clk, clr)
        variable f_int : std_logic_vector(3 downto 0);
    begin
        if clr = '1' then
            f_int := "0000";
        elsif clk'event and clk = '1' then
            if (we = '1') then
                f_int <= d_in;
                case f_int is
                    when "0000" => f_int := "0001";
                    when "0001" => f_int := "0010";
                    when "0010" => f_int := "0011";
                    when "0011" => f_int := "0100";
                    when "0100" => f_int := "0101";
                    when "0101" => f_int := "0110";
                    when "0110" => f_int := "0111";
                    when "0111" => f_int := "1000";
                    when "1000" => f_int := "1001";
                    when others => f_int := "0000";
                end case;
            end if;
        end if;
        f <= f_int;
    end process;
end bcd_arch;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity kolo is
    port (clk : in std_logic;
          rst : in std_logic;
          f : out std_logic_vector(3 downto 0));
end entity;

architecture kolo_arch of kolo is
    signal q : std_logic;
    signal we : std_logic;
    signal d_in : std_logic_vector(3 downto 0);
    signal y : std_logic_vector(3 downto 0);
    
    component bcd is
        port (clk : in std_logic;
              clr : in std_logic;
              we : in std_logic;
              d_in : in std_logic_vector(3 downto 0);
              f : out std_logic_vector(3 downto 0)); 
    end component;
    
begin
    dut1: bcd port map(q, we, d_in, y);
    
    proces : process(clk) is
    begin
        if (clk = '1') then
            q <= not q;
            
            if (rst = '1') then
                d_in <= "0000";
                we <= '1';
            else
                we <= '0';
            end if;
        end if;
    end process proces;
end architecture kolo_arch;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is
end entity;

architecture tb_arch of tb is
    signal clk : std_logic;
    signal rst : std_logic;
    signal f: std_logic_vector(3 downto 0);

    component kolo is
        port (clk : in std_logic;
              rst : in std_logic;
              f : out std_logic_vector(3 downto 0));
    end component;

begin
    dut1: kolo port map(clk, rst, f);
    
    clk <= not clk after 5ns;
    
    stim: PROCESS IS
    begin
        rst <= '1';
        wait for 10ns;
    
        rst <= '0';
        wait for 20ns;
        
        rst <= '1';
        wait for 30ns;
        
        rst <= '0';
        wait for 60ns;
    END PROCESS stim;
    
    clk <= not clk after 5ns;
    
    stimulus: PROCESS IS
    begin
        rst <= '1';
        wait for 10ns;
    
        rst <= '0';
        wait for 20ns;
        
        rst <= '1';
        wait for 30ns;
        
        rst <= '0';
        wait for 60ns;
    END PROCESS stimulus;

end architecture;
