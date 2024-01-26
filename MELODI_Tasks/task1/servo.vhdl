library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity servo is
    port(
        CLK           : in   std_logic;
        BTN           : in   std_logic_vector(2-1 downto 0);
        O             : out  std_logic;
        Virtual_Flag  : out  std_logic_vector(2-1 downto 0)
    );
end servo;