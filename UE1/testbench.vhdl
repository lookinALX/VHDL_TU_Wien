library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is

    component gates is
        port(   A,B,C,D : in    std_logic;
            O       : out   std_logic);
    end component;

    signal sig_A, sig_B, sig_C, sig_D, sig_O: std_logic;

begin

        DUT: gates port map(
            A => sig_A,
            B => sig_B,
            C => sig_C,
            D => sig_D,
            O => sig_O
        );

        gate_tester : process
            procedure chech_sample(val_A, val_B, val_C, val_D, val_O : in std_logic) is
                begin

                    sig_A <= val_A;
                    sig_B <= val_B;
                    sig_c <= val_C;
                    sig_D <= val_D;

                    wait for 10 ns;
                
                    assert (sig_O = val_O) report "Error for A ="
                    & std_logic'image(val_A) & "B= "
                    & std_logic'image(val_B) & "C= "
                    & std_logic'image(val_C) & "D= "
                    & std_logic'image(val_D) & ". Output is "
                    & std_logic'image(sig_O) & " but should be "
                    & std_logic'image(val_O) & "." 
                    severity failure;

            end procedure chech_sample;

            begin

                chech_sample('0','0','0','0','1');
                chech_sample('1','1','1','0','1');
        
            wait;

        end process gate_tester;

end tb;