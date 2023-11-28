library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache is
	port(
		addr     : in   std_logic_vector(9-1 downto 0);
		clk      : in   std_logic;
		en_read  : in   std_logic;
		data     : out  std_logic_vector(5-1 downto 0);
		ch_cm    : out  std_logic
	);
end cache;