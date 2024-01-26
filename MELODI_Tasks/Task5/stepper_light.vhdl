library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity stepper_light is
    port(
        CLK           : in   std_logic;
        DECODE        : in   std_logic_vector(1 downto 0);
        O             : out  std_logic_vector(7 downto 0);
        VIRTUAL_FLAG  : out  std_logic_vector(3 downto 0)
    );
end stepper_light;
