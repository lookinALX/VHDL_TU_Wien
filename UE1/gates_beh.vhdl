library IEEE;
use IEEE.std_logic_1164.all;
use work.IEEE_1164_Gates_pkg.all;

architecture behavior of gates is

signal sig_and1, sig_and2, sig_xor1, sig_or1, sig_or2 : std_logic;

begin

    AND_1: AND3 port map(
       I1 => "not"(B),
       I2 => "not"(C),
       I3 => D,
       O => sig_and1     
    );

    AND_2: AND2 port map(
        I1 => "not"(B),
        I2 => C,
        O => sig_and2 
    );

    XOR_1: XOR3 port map(
        I1 => A,
        I2 => "not"(B),
        I3 => C,
        O => sig_xor1    
    );

    OR_1: OR3 port map(
        I1 => A,
        I2 => "not"(B),
        I3 => "not"(C),
        O => sig_or1     
    );

    OR_2: OR4 port map(
        I1 => "not"(sig_and1),
        I2 => "not"(sig_and2),
        I3 => "not"(sig_xor1),
        I4 => "not"(sig_or1), 
        O => sig_or2     
    );

    O <= sig_or2;

end behavior;
