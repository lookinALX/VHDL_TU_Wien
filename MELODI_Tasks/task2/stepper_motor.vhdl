library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity stepper_motor is
    port(
        CLK  : in   std_logic;
        O    : out  std_logic_vector(4-1 downto 0)
    );
end stepper_motor;