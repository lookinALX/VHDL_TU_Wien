library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
	port(
		CLK         : in   std_logic;
		RST         : in   std_logic;
		SyncLoadInput   : in   std_logic;
		AsyncLoadConstant   : in   std_logic;
		Input       : in   std_logic_vector((5-1) downto 0);	
		Overflow    : out  std_logic;
		Output      : out  std_logic_vector((5-1) downto 0)
	);
end counter;