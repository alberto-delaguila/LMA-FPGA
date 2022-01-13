library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
use ieee.math_real.all;

entity error_vector_computer is
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
end entity;

architecture behaviour of error_vector_computer is
begin
      
  process(data_X, data_Y, A, B, C, D, E) 
  
  variable error: sfixed(21 downto -10);
  variable prediction_X: sfixed(21 downto -10);
	
  begin	 
    
    acknowledge <= '0';
	
    if trigger = '1' then
      
      prediction_X := A*data_X**4 + B*data_X**3 + C*data_X**2 + D*data_X + E;
      error := data_Y - prediction_X;
    
      p4 <= p4 + data_X**4 * error;
      p3 <= p3 + data_X**3 * error;
      p2 <= p2 + data_X**2 * error;
      p1 <= p1 + data_X * error;
      p0 <= p0 + error;

      acknowledge <= '1';
    
  	end if;

end process;

end architecture behaviour;
