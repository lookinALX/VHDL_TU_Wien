library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

architecture behavior of arithmetic is

begin
    process(I1, I2)
        variable result:std_logic_vector(14 downto 0);  
        variable a:integer:=0;
        variable b:integer:=0;
    begin
        a := to_integer(unsigned(I1));
        b := to_integer(unsigned(I2));
        if a < b then
            result := std_logic_vector(to_signed(a-b,15));
            if result(14) = '1' then
                C <= '1';
            else
                C <= '0';
            end if;
            O <= result;
            V <= '0';
            VALID <= '0';
        else
            result := std_logic_vector(to_signed(a-b,15));
            if result(14) = '0'then
                V <= '1';
            else
                V <= '0';
            end if;
            O <= result;
            C <= '0';
            VALID <= '1';
        end if;
    end process;


end behavior;
