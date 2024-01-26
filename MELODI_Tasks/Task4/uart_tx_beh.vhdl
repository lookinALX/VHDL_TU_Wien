library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of uart_tx is
    signal uart_data   : std_logic_vector(9 downto 0) := "1010000010"; -- Start bit (0) + ASCII 'A' (0(MSB) 100000 1(LSB)) + Stop bit (1)
    signal flag : std_logic := '0';
    constant PAUSE_DURATION_MIN : integer := 50000000; -- Minimum duration (500 ms at 100 MHz)
    constant PAUSE_DURATION_MAX : integer := 100000000; -- Maximum duration (1000 ms at 100 MHz)
    constant PAUSE_DURATION : integer := 75000000; -- 750 ms

begin
    process(CLK)
        variable baud_counter: integer := 0;
        variable uart_clk : integer := 0;
        variable pause_counter : integer := 0;
    begin
        if rising_edge(CLK) then
            if pause_counter < PAUSE_DURATION then
                -- Keep the output high during the initial pause
                O <= '1';
                pause_counter := pause_counter + 1;
            else
                -- After the pause uart clock is starting to tick

                baud_counter := baud_counter + 1;
                
                if uart_clk = 0 then
                    -- Transmitting the start bit
                    O <= '0';
                end if;

                if baud_counter = 10417 then --1 uart clock is 10417 main clks (9600 baund rate => 100e6/9600 = 10417)
                    uart_clk := uart_clk + 1;
                    baud_counter := 0;
                    if uart_clk < 10 then
                        if flag = '0' then -- depending on flag A or clear bits are being sent
                            O <= '1';
                        else
                            O <= uart_data(uart_clk);
                        end if;
                    else -- reset after sending all 10 bits
                        pause_counter := 0;
                        uart_clk := 0;
                        flag <= not flag; -- flag is to switch from clear bits to A-bits
                    end if;
                end if;
            end if;
        end if;
    end process;

end behavior;