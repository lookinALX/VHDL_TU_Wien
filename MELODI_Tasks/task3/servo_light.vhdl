library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity servo_light is
    port(
        CLK           : in   std_logic;
        LLS           : in   std_logic_vector(4-1 downto 0);
        BTN           : in   std_logic_vector(2-1 downto 0);
        VIRTUAL_FLAG  : out  std_logic_vector(4-1 downto 0);
        O             : out  std_logic_vector(5-1 downto 0)
    );
end servo_light;