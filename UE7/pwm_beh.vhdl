library IEEE;
use IEEE.std_logic_1164.all;

architecture behavior of pwm is

    -- 20e-9/40e-6 = 0.05 --> 1/0.05 = 20 !!!

begin
    process(clk)
        variable clk_counter : integer :=0;
        variable percent_counter : integer :=0;
        begin
            if rising_edge(clk) then

                clk_counter := clk_counter + 1;
                if (clk_counter = 20) then 
                    clk_counter := 0;
                    percent_counter := 1;
                end if;

                if percent_counter = 0 then
                    O <= '1';
                elsif percent_counter = 44 then
                    O <= '0';
                elsif percent_counter = 100 then
                    percent_counter := 0;
                end if;

            end if;
        end process; 

end behavior;
