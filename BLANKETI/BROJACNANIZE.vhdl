library IEEE;
use IEEE.std_logic_1164.all;

ENTITY brojac IS
    GENERIC(n: integer := 4);
    PORT(rst: IN bit; clk: IN bit;
         f: out integer);
END ENTITY brojac;

ARCHITECTURE broji OF brojac IS
BEGIN
    proc:PROCESS(clk, rst) IS
        VARIABLE f_int: integer := n-1;
    begin
        f <= f_int;
        
        if(clk'event and clk = '1') then
            if(rst = '1') then
                f_int := n - 1;
                f <= f_int;
            ELSE
                f_int := (f_int - 1) mod n;
                f <= f_int;
            END IF;
        END if;
    END PROCESS proc;
END ARCHITECTURE broji;

library IEEE;
use IEEE.std_logic_1164.all;

ENTITY tb IS
    GENERIC(n: integer := 5);
END ENTITY tb;

ARCHITECTURE tba OF tb IS
    SIGNAL rst: bit;
    SIGNAL clk: bit := '0';
    SIGNAL f: integer;

BEGIN
    dut: ENTITY work.brojac(broji)
        GENERIC MAP( n => n)
        PORT MAP(
            clk => clk,
            rst => rst,
            f => f
        );
        
    clk <= not clk after 5 ns;
    
    stimulus: PROCESS is
    BEGIN
        rst <= '0';
        WAIT FOR 100ns;
        
        rst <= '1';
        WAIT FOR 30ns;
        
        rst <= '0';
        WAIT FOR 100ns;
        
    END PROCESS stimulus;
END ARCHITECTURE tba;
