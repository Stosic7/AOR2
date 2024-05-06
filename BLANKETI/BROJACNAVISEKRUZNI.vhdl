library IEEE;
use IEEE.std_logic_1164.all;

ENTITY brojac IS
    GENERIC(n: integer := 4);
    PORT(rst: IN bit; clk: IN bit;
         f: out integer);
END ENTITY brojac;

ARCHITECTURE broji OF brojac IS
BEGIN
    proc:PROCESS IS
        VARIABLE f_int: integer := n-1;
    BEGIN
        f <= f_int;
        LOOP
            LOOP
                WAIT UNTIL clk = '1' and clk'event;
                EXIT WHEN rst = '1';
                f_int := (f_int - 1) mod n;
                f <= f_int;
            END LOOP;
            f_int := n-1;
            f <= f_int;
            WAIT UNTIL rst = '0';
        END LOOP;
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
        
        rst <= '0';
        WAIT FOR 100ns;
    END PROCESS stimulus;
END ARCHITECTURE tba;
