library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture behavior of demux is

    signal sig_out1, sig_out2, sig_out3, sig_out4, sig_out5, sig_out6 : std_logic_vector((2-1) downto 0);

begin

    with SEL select
        sig_out1 <= IN1 when "000",
                    "00" when others;
    with SEL select
        sig_out2 <= IN1 when "001",
                    "00" when others;
    with SEL select
        sig_out3 <= IN1 when "010",
                    "00" when others;
    with SEL select
        sig_out4 <= IN1 when "011",
                    "00" when others;
    with SEL select
        sig_out5 <= IN1 when "100",
                    "00" when others;
    with SEL select
        sig_out6 <= IN1 when "101",
                    "00" when others;
    OUT1 <= sig_out1;
    OUT2 <= sig_out2;
    OUT3 <= sig_out3;
    OUT4 <= sig_out4;
    OUT5 <= sig_out5;
    OUT6 <= sig_out6;
end behavior;