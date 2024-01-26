library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of stepper_light is

    type State_Type is (S1,S2,S3,S4);
    signal Current_State, Next_State: State_Type;
    signal flag:std_logic := '0';
    --signal Switch_State : State_Type := S6;
    --signal counter : integer := 0;
    --signal PWM_counter : integer := 0;
    signal PWM_output :std_logic := '0';
    signal rotate_counter:integer := 0;

    constant stepping_frequency : integer := 100; --Hz
    constant Clock_Frequency : integer := 100000000; -- 100MHz
    constant Divider : integer := Clock_Frequency / Stepping_Frequency;

    constant PWM_Period : integer := Clock_Frequency/20000; --Clock_Frequency / 20000
    constant PWM_Duty_Cycle : integer := 2000; --40% from PWM_divider Clock_Frequency / 20000 * 0,4

begin

    Light_Process: process(DECODE(0))
        begin
            if DECODE(0) = '1' then
                rotate_counter <= rotate_counter + 1;
                if rotate_counter = 11 then
                    if flag = '0' then
                        flag <= '1';
                    else
                        flag <= '0';
                    end if;
                end if;

                if rotate_counter = 12 then
                    rotate_counter <= 0;
                end if;

            end if;
            --O(7 downto 4) <= std_logic_vector(to_unsigned(rotate_counter, 4));
            --VIRTUAL_FLAG <= std_logic_vector(to_unsigned(rotate_counter, 4));
        end process Light_Process;
    
    
    PWM_Process: process(CLK, rotate_counter)
        variable counter : integer := 0;
        variable PWM_counter : integer := 0;
        begin

            O(7 downto 4) <= std_logic_vector(to_unsigned(rotate_counter, 4));
            VIRTUAL_FLAG <= std_logic_vector(to_unsigned(rotate_counter, 4));

            if rising_edge(CLK) then 
                if counter = 200 then
                    counter := 0;
                    Current_State <= Next_State;
                end if;
                
                -- PWM generator
                if (PWM_counter < PWM_Duty_Cycle) then
                    PWM_output <= '1';
                    PWM_counter := PWM_counter + 1;  
                elsif (PWM_counter = PWM_Period - 1) then
                    PWM_counter := 0;
                    PWM_output <= '0';
                    counter := counter + 1;
                else
                    PWM_output <= '0';
                    PWM_counter := PWM_counter + 1;
                end if;

            end if;
        end process PWM_Process;

    Output_Process: process(PWM_output, Current_State, flag)
        begin
            case Current_State is
                when S1 =>
                    if flag = '0' then
                        Next_State <= S2;
                    else
                        Next_State <= S4;
                    end if;
                    O(0) <= PWM_output;
                    O(1) <= '0';
                    O(2) <= PWM_output;
                    O(3) <= '0';
                when S2 =>
                    if flag <= '0' then
                        Next_State <= S3;
                    else
                        Next_State <= S1;
                    end if;
                    O(0) <= '0';
                    O(1) <= PWM_output;
                    O(2) <= PWM_output;
                    O(3) <= '0';
                when S3 =>
                    if flag <= '0' then
                        Next_State <= S4;
                    else
                        Next_State <= S2;
                    end if;
                    O(0) <= '0';
                    O(1) <= PWM_output;
                    O(2) <= '0';
                    O(3) <= PWM_output;
                when S4 =>
                    if flag <= '0' then
                        Next_State <= S1;
                    else 
                        Next_State <= S3;
                    end if;
                    O(0) <= PWM_output;
                    O(1) <= '0';
                    O(2) <= '0';
                    O(3) <= PWM_output;
            end case;

        end process Output_Process;

end behavior;