library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of servo_light is
 -- CLK Frequenz = 100 Mhz
 -- PWM Frequenz = 50 Hz
 -- Clk's in 1 Tpwm = 2000000
 -- 1% = 2e6/100 = 20000

signal virtual_flag_internal:std_logic_vector(3 downto 0) := (others => '0');

begin

    process(clk)
        variable pwm_counter:integer := 0;
        variable clk_counter:integer := 0;
        begin

            if LLS(0) = '1' then
                O(1) <= '1';
            else
                O(1) <= '0';
            end if;

            if LLS(1) = '1' then
                O(2) <= '1';
            else
                O(2) <= '0';
            end if;
            
            if LLS(2) = '1' then
                O(3) <= '1';
            else
                O(3) <= '0';
            end if;

            if LLS(3) = '1' then
                O(4) <= '1';
            else
                O(4) <= '0';
            end if;

            VIRTUAL_FLAG <= LLS;

            if rising_edge(clk) then
                if BTN = "00" then  
                    if pwm_counter = 10 then
                        O(0) <= '0';
                    else
                        clk_counter := clk_counter + 1;
                        if (clk_counter < 100000) then
                            O(0) <= '1';
                        elsif (clk_counter >= 100000 AND clk_counter < 2000000) then
                            O(0) <= '0';
                        else
                            clk_counter := 0;
                            pwm_counter := pwm_counter + 1;
                            O(0) <= '1';
                        end if;
                    end if;   
                end if; 

                if BTN = "10" then  
                    if pwm_counter = 10 then
                        O(0) <= '0';
                    else
                        clk_counter := clk_counter + 1;
                        if (clk_counter < 220000) then
                            O(0) <= '1';
                        elsif (clk_counter >= 220000 AND clk_counter < 2000000) then
                            O(0) <= '0';
                        else
                            clk_counter := 0;
                            pwm_counter := pwm_counter + 1;
                            O(0) <= '1';
                        end if;
                    end if;   
                end if; 

                if BTN = "01" then  
                    if pwm_counter = 10 then
                        O(0) <= '0';
                    else
                        clk_counter := clk_counter + 1;
                        if (clk_counter < 170000) then
                            O(0) <= '1';
                        elsif (clk_counter >= 170000 AND clk_counter < 2000000) then
                            O(0) <= '0';
                        else
                            clk_counter := 0;
                            pwm_counter := pwm_counter + 1;
                            O(0) <= '1';
                        end if;
                    end if;   
                end if; 

                if BTN = "11" then  
                    if pwm_counter = 10 then
                        O(0) <= '0';
                    else
                        clk_counter := clk_counter + 1;
                        if (clk_counter < 260000) then
                            O(0) <= '1';
                        elsif (clk_counter >= 260000 AND clk_counter < 2000000) then
                            O(0) <= '0';
                        else
                            clk_counter := 0;
                            pwm_counter := pwm_counter + 1;
                            O(0) <= '1';
                        end if;
                    end if;   
                end if; 
                
            end if;
        end process;

end behavior;