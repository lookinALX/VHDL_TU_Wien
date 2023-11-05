library IEEE;
use IEEE.std_logic_1164.all;
use work.fsm_pkg.all;

architecture behavior of fsm is

    --signal current_state:fsm_state := START;

begin

    clkpr: process (CLK)
     
        variable output_value:std_logic_vector(1 downto 0) := "00";
        variable current_state:fsm_state := START;
    begin
       
        if rising_edge(CLK) then

            if RST = '1' then
                current_state := START;
                output_value := "00";
            else
                if INPUT = "00" then
                    if current_state = START then
                        current_state := S2;
                        output_value := "01";
                    elsif current_state = S2 then
                        current_state := S2;
                        output_value := "10";
                    elsif current_state = S0 then
                        current_state := S2;
                        output_value := "10";
                    else 
                        output_value := "00";
                    end if;
                elsif INPUT = "11" then
                    if current_state = S2 then
                        current_state := S0;
                        output_value := "01";
                    elsif current_state = S0 then
                        current_state := S1;
                        output_value := "01";
                    elsif current_state = S1 then
                        current_state := S0;
                        output_value := "10";
                    else 
                        output_value := "00";
                    end if;
                elsif INPUT = "01" then
                    if current_state = S1 then
                        current_state := S1;
                        output_value := "00";
                    elsif current_state = S0 then
                        current_state := S0;
                        output_value := "10";
                    else
                        output_value := "00";
                    end if;
                else
                    output_value := "00";
                end if;
            end if;
        end if;

        OUTPUT <= output_value;
        STATE <= current_state;

    end process clkpr;

end behavior;
