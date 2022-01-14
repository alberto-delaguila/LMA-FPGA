library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity matrix_reducer_tb is
end entity;

architecture testbench of matrix_reducer_tb is
    component matrix_reducer 
    port(
        data_X : in std_logic_vector(31 downto 0);

        p0, p1, p2, p3, p4 : in std_logic_vector(31 downto 0);

        deltaA, deltaB, deltaC, deltaD, deltaE : out std_logic_vector(31 downto 0);

        d_trigger : in std_logic;
        p_trigger : in std_logic;
        end_of_data : in std_logic;
        acknowledge : out std_logic;
        ctr_reset : out std_logic
        );
    end component;

    signal data_X, p0, p1, p2, p3, p4 : std_logic_vector(31 downto 0);
    signal deltaA, deltaB, deltaC, deltaD, deltaE : std_logic_vector(31 downto 0);
    signal d_trigger, p_trigger, end_of_data, acknowledge, ctr_reset : std_logic := '0';


    begin
        UUT : matrix_reducer port map(
            data_X => data_X,
            p0 => p0,
            p1 => p1,
            p2 => p2,
            p3 => p3,
            p4 => p4,
            deltaA => deltaA,
            deltaB => deltaB,
            deltaC => deltaC,
            deltaD => deltaD,
            deltaE => deltaE,
            d_trigger => d_trigger,
            p_trigger => p_trigger,
            end_of_data => end_of_data,
            acknowledge => acknowledge,
            ctr_reset => ctr_reset
        );

        process begin
            ctr_reset <= '1';
            wait for 3 ns;
            ctr_reset <= '0';
            wait for 5 ns;
            d_trigger <= '0';
            p_trigger <= '0';
            wait for 2 ns;
            data_X <= std_logic_vector(to_signed(1,32));
            d_trigger <= '1';
            wait for 2 ns;
            d_trigger <= '0';
            wait for 2 ns;
            data_X <= std_logic_vector(to_signed(2,32));
            d_trigger <= '1';
            wait for 2 ns;
            d_trigger <= '0';
            wait for 2 ns;
            data_X <= std_logic_vector(to_signed(3,32));
            d_trigger <= '1';
            wait for 2 ns;
            d_trigger <= '0';
            wait for 2 ns;
            data_X <= std_logic_vector(to_signed(-2,32));
            d_trigger <= '1';
            wait for 2 ns;
            d_trigger <= '0';
            wait for 20 ns;
            p_trigger <= '1';
            p0 <= std_logic_vector(to_signed(23,32));
            p1 <= std_logic_vector(to_signed(64,32));
            p2 <= std_logic_vector(to_signed(184,32));
            p3 <= std_logic_vector(to_signed(538,32));
            p4 <= std_logic_vector(to_signed(1558,32));
            wait for 2 ns;
            p_trigger <= '0';
            end_of_data <= '1';
            wait;
        end process;
end architecture testbench;