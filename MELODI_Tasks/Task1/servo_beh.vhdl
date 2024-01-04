library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of servo is
-- CLK Frequenz = 100 Mhz --> Tclk = 1e-8 s
-- PWM Frequenz = 50 Hz --> Tpwm = 0.02
-- Clk's in 1 Tpwm = 2000000.0
-- 1% = 2e6/100% = 20000
signal virtual_flag_internal:std_logic_vector(2-1 downto 0) := (others => '0');

begin
    process(Clk)
        variable clk_counter : integer := 0;
        variable pwm_counter : integer := 0;    

    begin
        if rising_edge(Clk) then
            if BTN = "00" OR BTN = "11" then -- 00 OR 11
                if pwm_counter = 10 then
                    O <= '0';
                else
                    clk_counter := clk_counter + 1;
                    if (clk_counter < 50000) then 
                        O <= '1';
                    elsif (clk_counter >= 50000 AND clk_counter < 2000000) then
                        O <= '0';
                    else
                        clk_counter := 0;
                        pwm_counter := pwm_counter + 1;
                        O <= '1';
                    end if;
                end if;
                if BTN = "00" then
                    if virtual_flag_internal /= "00" then
                        Virtual_Flag <= BTN;
                        virtual_flag_internal <= BTN;
                        pwm_counter := 0;
                    end if;
                else 
                    if virtual_flag_internal /= "11" then
                        Virtual_Flag <= BTN;
                        virtual_flag_internal <= BTN;
                        pwm_counter := 0;
                    end if;
                end if;
            end if;

            if BTN = "01" then -- 01
                if pwm_counter = 10 then
                    O <= '0';
                else
                    clk_counter := clk_counter + 1;
                    if (clk_counter < 150000) then 
                        O <= '1';
                    elsif (clk_counter >= 150000 AND clk_counter < 2000000) then
                        O <= '0';
                    else
                        clk_counter := 0;
                        pwm_counter := pwm_counter + 1;
                        O <= '1';
                    end if;
                end if;
                if virtual_flag_internal /= "01" then
                    Virtual_Flag <= BTN;
                    virtual_flag_internal <= BTN;
                    pwm_counter := 0;
                end if;
            end if;

            if BTN = "10" then -- 01
                if pwm_counter = 10 then
                    O <= '0';
                else
                    clk_counter := clk_counter + 1;
                    if (clk_counter < 250000) then 
                        O <= '1';
                    elsif (clk_counter >= 250000 AND clk_counter < 2000000) then
                        O <= '0';
                    else
                        clk_counter := 0;
                        pwm_counter := pwm_counter + 1;
                        O <= '1';
                    end if;
                end if;
                if virtual_flag_internal /= "10" then
                    Virtual_Flag <= BTN;
                    virtual_flag_internal <= BTN;
                    pwm_counter := 0;
                end if;
            end if;

        end if;
    end process;

end behavior;