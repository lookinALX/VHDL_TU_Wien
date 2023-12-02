library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture Behavioral of RAM is

    subtype word_t is std_logic_vector(11 downto 0);
    type memomry_t is array(0 to 10239) of word_t;
    signal ram_data: memomry_t := (others =>(others =>'0'));

    procedure memory_read(signal addr: in std_logic_vector; 
                            signal ram_d: in memomry_t;
                            signal ram_output: out std_logic_vector) is
    begin
        ram_output(11 downto 0) <= ram_d(to_integer(unsigned(addr)));
        ram_output(23 downto 12) <= ram_d(to_integer(unsigned(addr)+1));
    end memory_read; 

    procedure memory_write(signal addr: in std_logic_vector;
                           signal input: in std_logic_vector;
                           signal ram_write: out memomry_t) is
    begin
        ram_write(to_integer(unsigned(addr))) <= input;
    end memory_write;

begin

    clkpr: process(clk)
        begin
            -- wr1 wr2 rd
            if rising_edge(clk) then
                if (en_read = '0') then   --X X 0 (--0 0 0)
                    output <= (others => 'Z');
                    if(en_write1 ='1' and en_write2 ='0')then --1 0 0
                        memory_write(addr1, input1, ram_data);
                    elsif(en_write1 = '0' and en_write2 ='1') then --0 1 0
                        memory_write(addr2, input2, ram_data);
                    elsif(en_write1='1' and en_write2 ='1') then --1 1 0
                        if(addr1 /= addr2) then
                            memory_write(addr1,input1,ram_data);
                            memory_write(addr2,input2,ram_data);
                        end if;
                    end if;
                else -- X X 1
                    if (en_write1 ='1' and en_write2 ='0') then -- 1 0 1
                        output <= (others => 'Z');
                    elsif (en_write1 ='0' and en_write2 = '1') then --0 1 1
                        if(addr1 /= addr2 and 
                        to_integer(unsigned(addr2)) /= to_integer(unsigned(addr1)+1)) then
                            memory_read(addr1,ram_data,output);
                            memory_write(addr2,input2,ram_data);
                        else
                            output <= (others => 'Z');
                        end if;
                    elsif (en_write1 ='1' and en_write2 ='1') then --1 1 1
                        output <= (others => 'Z');
                    else --0 0 1
                        memory_read(addr1,ram_data,output);
                    end if;
                end if;
            end if;
        end process clkpr;

end Behavioral;