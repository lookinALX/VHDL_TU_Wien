library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uart_tx is
    port(
        CLK           : in   std_logic;
        O             : out  std_logic
    );
end uart_tx;