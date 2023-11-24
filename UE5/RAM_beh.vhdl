library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

architecture Behavioral of RAM is

    subtype word_t is std_logic_vector(0 downto 13);
    type memory_t is array(0 to 255) of word_t;
    signal ram_data : memory_t := (others => (others => '0'));

--procedure write_into_memory(addr: in std_logic_vector; input: in std_logic_vector; memory_to_write: out memory_t) is
  --  begin
    --    memory_to_write(to_integer(unsigned(addr))) <= input(0 downto 13);
    --    memory_to_write(to_integer(unsigned(addr))+1) <= input(14 downto 27);
   -- end write_into_memory;

begin

    clkpr: process(clk)
        begin

            if rising_edge(Clk)then
                if(en_read1 = '0' and en_read2 = '0') then                                     --0 0 1 --0 0 0
                    output1 <= (others => 'Z');
                    output2 <= (others => 'Z');
                
                    if(en_write = '1') then
                        ram_data(to_integer(unsigned(addr1))) <= input(0 downto 13);
                        ram_data(to_integer(unsigned(addr1))+1) <= input(14 downto 27);
                    end if;

                elsif(en_read1 = '0' and en_read2 = '1') then
                    output1 <= (others => 'Z');
                    if(en_write = '0') then                                                    --0 1 0
                        output2(0 downto 13) <= ram_data(to_integer(unsigned(addr2)));
                        output2(14 downto 27) <= ram_data(to_integer(unsigned(addr2))+1);
                    else                                                                       --0 1 1
                        if((addr1 /= addr2) and 
                        (to_integer(unsigned((addr2))) /= to_integer(unsigned((addr1))+1)) and 
                        (to_integer(unsigned((addr1))) /= to_integer(unsigned((addr2))+1))) then
                            output2(0 downto 13) <= ram_data(to_integer(unsigned(addr2)));
                            output2(14 downto 27) <= ram_data(to_integer(unsigned(addr2))+1);
                            ram_data(to_integer(unsigned(addr1))) <= input(0 downto 13);
                            ram_data(to_integer(unsigned(addr1))+1) <= input(14 downto 27);
                        else
                            output2 <= (others => 'Z');
                        end if;   
                    end if;

                elsif(en_read1 = '1' and en_read2 = '0') then
                    output2 <= (others => 'Z');
                    if(en_write = '0') then                                                    --1 0 0
                        output1(0 downto 13) <= ram_data(to_integer(unsigned(addr1)));
                        output1(14 downto 27) <= ram_data(to_integer(unsigned(addr1))+1);
                    else                                                                       --1 0 1
                        output1 <= (others => 'Z');
                    end if;

                elsif(en_read1 = '1' and en_read2 = '0') then 
                    if(en_write = '0' and (addr1 /= addr2)) then                                                    -- 1 1 0
                        output1(0 downto 13) <= ram_data(to_integer(unsigned(addr1)));
                        output1(14 downto 27) <= ram_data(to_integer(unsigned(addr1))+1);
                        output2(0 downto 13) <= ram_data(to_integer(unsigned(addr2)));
                        output2(14 downto 27) <= ram_data(to_integer(unsigned(addr2))+1);
                    else                                                                       -- 1 1 1
                        output1 <= (others => 'Z');
                        output2 <= (others => 'Z');
                    end if;    
                end if;
            end if;
        end process clkpr;    
    

end Behavioral;