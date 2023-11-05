library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of counter is

begin

    COUNT:process(CLK,RST,SyncLoadInput,AsyncLoadConstant)

        variable counter_output_value : integer := 0;
        variable overflow_value : std_logic := '0';

    begin

        if rising_edge(CLK) then
            if RST = '0' AND SyncLoadInput = '0' then
                if counter_output_value = 31 then
                    counter_output_value := 0;
                    overflow_value := '1';
                else
                    counter_output_value := counter_output_value + 1;
                    overflow_value := '0';
                end if;
            elsif RST = '1' then
                counter_output_value := 0;
                overflow_value := '0';
            elsif SyncLoadInput = '1' then 
                counter_output_value := To_integer(unsigned(Input));
            end if;
        end if;

        if rising_edge(AsyncLoadConstant) then
            counter_output_value := 13;
        end if;

        Output <= Std_logic_vector(To_unsigned(counter_output_value,5));
        Overflow <= overflow_value;

    end process COUNT;

end behavior;