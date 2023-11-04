library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench;

architecture tb of testbench is

    component demux is
        port ( IN1  : in  std_logic_vector((2 - 1) downto 0);
        SEL  : in  std_logic_vector((3 - 1) downto 0);
        OUT1 : out std_logic_vector((2 - 1) downto 0);
        OUT2 : out std_logic_vector((2 - 1) downto 0);
        OUT3 : out std_logic_vector((2 - 1) downto 0);
        OUT4 : out std_logic_vector((2 - 1) downto 0);
        OUT5 : out std_logic_vector((2 - 1) downto 0);
        OUT6 : out std_logic_vector((2 - 1) downto 0));
    end component;

signal sig_in1, sig_out1, sig_out2, sig_out3, sig_out4, sig_out5, sig_out6 : std_logic_vector(1 downto 0);
signal sig_sel : std_logic_vector(2 downto 0);

begin

    DUT: demux port map(
        IN1 => sig_in1,
        SEL => sig_sel,
        OUT1 => sig_out1,
        OUT2 => sig_out2,
        OUT3 => sig_out3,
        OUT4 => sig_out4,
        OUT5 => sig_out5,
        OUT6 => sig_out6
    );

    tester_gate : process 
        procedure check_port_1(val_in1, val_sel, val_check_out: in std_logic_vector) is
            begin
                sig_in1 <= val_in1;  
                sig_sel <= val_sel;

                wait for 10 ns;

                assert(sig_out1 = val_check_out) report "Error check port 1" severity failure;

                assert(sig_out2 = "00") report "Error check port 1" severity failure;

            end procedure check_port_1;
            
        procedure check_mult_ports(val_in1, val_sel: in std_logic_vector) is

            variable flag : std_logic_vector(2 downto 0);

            begin
                sig_in1 <= val_in1;  
                sig_sel <= val_sel;
                
                wait for 10 ns;

                flag := val_sel;

                if flag = "000" then
                    assert(sig_out1 = val_in1) report "Error check port 1" severity failure;
                elsif flag = "001" then
                    assert(sig_out2 = val_in1) report "Error check port 2" severity failure;
                elsif flag = "010" then
                    assert(sig_out3 = val_in1) report "Error check port 3" severity failure;
                elsif flag = "011" then
                    assert(sig_out4 = val_in1) report "Error check port 4" severity failure;
                elsif flag = "100" then
                    assert(sig_out5 = val_in1) report "Error check port 5" severity failure;
                elsif flag = "101" then
                    assert(sig_out6 = val_in1) report "Error check port 6" severity failure;
                else
                    assert(sig_out1 = "00") report "Error for all ports. Port 1" severity failure;
                    assert(sig_out2 = "00") report "Error for all ports. Port 2" severity failure;
                    assert(sig_out3 = "00") report "Error for all ports. Port 3" severity failure;
                    assert(sig_out4 = "00") report "Error for all ports. Port 4" severity failure;
                    assert(sig_out5 = "00") report "Error for all ports. Port 5" severity failure;
                    assert(sig_out6 = "00") report "Error for all ports. Port 6" severity failure;
                end if;
            end procedure check_mult_ports;


    begin
        
        check_port_1("01", "000", "01");
        check_port_1("10", "110", "00");
        check_port_1("10", "010", "00");

        check_mult_ports("10", "010");
        check_mult_ports("10", "011");
        check_mult_ports("10", "111");

    end process tester_gate;

end tb;