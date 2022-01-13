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
    signal TB_data_X, TB_data_Y: sfixed(21 downto -10);
	
    begin											   

	Error_TB: error_vector_computer port map (TB_data_X, TB_data_Y, TB_A, TB_B, TB_C, TB_D, TB_E);
	
    process
    begin
		
	TB_data_X <= x"ABCD1234";
    TB_data_Y <= x"CD1295EB";
	TB_A <= x"00DD12AB";
    TB_B <= x"000087AF";
    TB_C <= x"EEE12AC9";
    TB_D <= x"84BD16AF";
    TB_E <= x"F002AC64";
		
	wait;
		
    end process;

end TB;
