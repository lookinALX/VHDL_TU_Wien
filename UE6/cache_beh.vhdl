library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of cache is
    subtype cache_word_t is std_logic_vector(8 downto 0);
    type cache_data_t is array(0 to 16) of cache_word_t;

    constant cache_data: cache_data_t := ("101011100",
                                        "111111010",
                                        "110110000",
                                        "101010011",
                                        "100011111",
                                        "110111101",
                                        "101110011",
                                        "101111101",
                                        "100010111",
                                        "101110101",
                                        "111011001",
                                        "100110110",
                                        "100111110",
                                        "100011100",
                                        "110110001",
                                        "100111101",
                                        "110110111");

begin

    clkpr: process(clk)
        begin
            if rising_edge(clk) then
                if en_read = '1' then
                    if to_integer(unsigned(addr(4 downto 0))) > 16 then
                        data <= (others => 'Z');
                        ch_cm <= '0';
                    elsif addr(8 downto 5) = cache_data(to_integer(unsigned(addr(4 downto 0))))(8 downto 5) then
                        data <= cache_data(to_integer(unsigned(addr(4 downto 0))))(4 downto 0);
                        ch_cm <= '1';
                    else
                        data <= (others => 'Z');
                        ch_cm <= '0';
                    end if;    
                else
                    data <= (others => 'Z');
                    ch_cm <= '0';
                end if;
            end if;
        end process clkpr;

end behavior;