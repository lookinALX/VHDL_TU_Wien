library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of stepper_motor is
    type State_Type is (S1,S2,S3,S4);
    signal Current_State, Next_State : State_Type;
    signal counter : integer := 0;
    signal PWM_counter : integer := 0;
    signal PWM_output :std_logic := '0';

    constant stepping_frequency : integer := 100; --Hz
    constant Clock_Frequency : integer := 100000000; -- 100MHz
    constant Divider : integer := Clock_Frequency / Stepping_Frequency;

    constant PWM_Period : integer := 25000; --Clock_Frequency / 4000
    constant PWM_Duty_Cycle : integer := 5000; --20% from PWM_divider
begin
    
    StateMachine_Process: process(CLK)
        begin
            if rising_edge(CLK) then
                if counter = 40 then
                    counter <= 0;
                    Current_State <= Next_State;
                end if;
                
                -- PWM generator
                if (PWM_counter < PWM_Duty_Cycle) then
                    PWM_output <= '1';
                    PWM_counter <= PWM_counter + 1;  
                elsif (PWM_counter = PWM_Period - 1) then
                    PWM_counter <= 0;
                    PWM_output <= '0';
                    counter <= counter + 1;
                else
                    PWM_output <= '0';
                    PWM_counter <= PWM_counter + 1;
                end if;

            end if;
        end process StateMachine_Process;

    Output_Process: process(clk, PWM_output, Current_State)
        begin
            case Current_State is
                when S1 =>
                    Next_State <= S2;
                    O(0) <= PWM_output;
                    O(1) <= '0';
                    O(2) <= PWM_output;
                    O(3) <= '0';
                when S2 =>
                    Next_State <= S3;
                    O(0) <= '0';
                    O(1) <= PWM_output;
                    O(2) <= PWM_output;
                    O(3) <= '0';
                when S3 =>
                    Next_State <= S4;
                    O(0) <= '0';
                    O(1) <= PWM_output;
                    O(2) <= '0';
                    O(3) <= PWM_output;
                when S4 =>
                    Next_State <= S1;
                    O(0) <= PWM_output;
                    O(1) <= '0';
                    O(2) <= '0';
                    O(3) <= PWM_output;
            end case;
        end process Output_Process;

end behavior;