library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RAM is
    port( Clk : in std_logic;
     	  addr1 : in std_logic_vector(11 downto 0);
	  addr2 : in std_logic_vector(11 downto 0);
          en_read : in std_logic;
          en_write1 : in std_logic;
          en_write2 : in std_logic;
          input1 : in std_logic_vector(11 downto 0);
          input2 : in std_logic_vector(11 downto 0);
          output : out std_logic_vector(23 downto 0)
     		);
end RAM;