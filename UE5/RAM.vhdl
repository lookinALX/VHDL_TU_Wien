library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RAM is
    port( Clk : in std_logic;
     	  addr1 : in std_logic_vector(5 downto 0);
	      addr2 : in std_logic_vector(5 downto 0);
          en_read1 : in std_logic;
          en_read2 : in std_logic;
          en_write : in std_logic;
          input : in std_logic_vector(27 downto 0);
          output1 : out std_logic_vector(27 downto 0);
          output2 : out std_logic_vector(27 downto 0)
        );
end RAM;
