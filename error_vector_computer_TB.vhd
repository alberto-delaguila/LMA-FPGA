
library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
use ieee.math_real.all;

entity error_vector_computer_TB is				-- entity declaration
end error_vector_computer_TB;

architecture TB of error_vector_computer_TB is

    component error_vector_computer is
    port (
        data_X : in sfixed(21 downto -10); --
        data_Y : in sfixed(21 downto -10); --
        
        A : in sfixed(21 downto -10); --derivada del parámetro A
        B : in sfixed(21 downto -10); --derivada del parámetro B
        C : in sfixed(21 downto -10); --derivada del parámetro C
        D : in sfixed(21 downto -10); --derivada del parámetro D
        E : in sfixed(21 downto -10); --derivada del parámetro E

		p4_prev : in sfixed(21 downto -10); --componente x^4 previo
        p3_prev : in sfixed(21 downto -10); --componente x^3 previo
        p2_prev : in sfixed(21 downto -10); --componente x^2 previo
        p1_prev : in sfixed(21 downto -10); --componente x^1 previo
        p0_prev : in sfixed(21 downto -10); --componente x^0 previo 
		
		p4 : out sfixed(21 downto -10); --componente x^4
        p3 : out sfixed(21 downto -10); --componente x^3
        p2 : out sfixed(21 downto -10); --componente x^2
        p1 : out sfixed(21 downto -10); --componente x^1
        p0 : out sfixed(21 downto -10); --componente x^0    

        trigger : in std_logic; --iniciar proceso

        acknowledge : out std_logic --indicar fin del proceso
    );
    end component;

    signal TB_A, TB_B, TB_C, TB_D, TB_E: sfixed(21 downto -10);
	signal TB_p4_prev, TB_p3_prev, TB_p2_prev, TB_p1_prev, TB_p0_prev: sfixed(21 downto -10);
    signal TB_data_X, TB_data_Y: sfixed(21 downto -10);
	signal TB_trigger: std_logic;
	
	signal TB_p4: sfixed(21 downto -10);
	signal TB_p3: sfixed(21 downto -10);
	signal TB_p2: sfixed(21 downto -10);
	signal TB_p1: sfixed(21 downto -10);
	signal TB_p0: sfixed(21 downto -10);
	
	signal TB_acknowledge: std_logic;
	
    begin											   

	Error_TB: error_vector_computer port map (TB_data_X, TB_data_Y, TB_A, TB_B, TB_C, TB_D, TB_E, TB_p4_prev, TB_p3_prev, TB_p2_prev, TB_p1_prev, TB_p0_prev, TB_p4, TB_p3, TB_p2, TB_p1, TB_p0, TB_trigger, TB_acknowledge);
	
    process
    begin
	
	TB_p4_prev <= x"00000000";
	TB_p3_prev <= x"00000000";
	TB_p2_prev <= x"00000000";
	TB_p1_prev <= x"00000000";
	TB_p0_prev <= x"00000000";
		
	TB_trigger <= '1';
	TB_data_X <= x"00001234";
    TB_data_Y <= x"000095EB";
	TB_A <= x"000012AB";
    TB_B <= x"000087AF";
    TB_C <= x"00002AC9";
    TB_D <= x"000016AF";
    TB_E <= x"0000AC64";
		
	wait for 20 ns;
	
	TB_p4_prev <= x"00000010";
	TB_p3_prev <= x"000000DC";
	TB_p2_prev <= x"00000015";
	TB_p1_prev <= x"00000781";
	TB_p0_prev <= x"00000ACF";
	
	TB_trigger <= '1';
	TB_data_X <= x"00001234";
    TB_data_Y <= x"000095EB";
	TB_A <= x"000012AB";
    TB_B <= x"000087AF";
    TB_C <= x"00002AC9";
    TB_D <= x"000016AF";
    TB_E <= x"0000AC64";
	
	wait for 20 ns;
	
	wait;
		
    end process;

end TB;
