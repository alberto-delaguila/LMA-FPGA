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
end entity;

architecture behaviour of error_vector_computer is
begin
      
	process(data_X, data_Y, A, B, C, D, E, p4_prev, p3_prev, p2_prev, p1_prev, p0_prev) 
  
	variable error: sfixed(21 downto -10);
	variable prediction_X: sfixed(21 downto -10);
	
	begin	 
    
    acknowledge <= '0';
	
    if trigger = '1' then
      
		prediction_X := resize(
			arg => A*data_X*data_X*data_X*data_X + B*data_X*data_X*data_X + C*data_X*data_X + D*data_X + E,
			size_res => prediction_X
			);
				
		error := resize(
			arg => data_Y - prediction_X,
			size_res => error
			);
    
		p4 <= resize(
			arg => p4_prev + data_X*data_X*data_X*data_X * error,
			size_res => p4
			);
			
    	p3 <= resize(
			arg => p3_prev + data_X*data_X*data_X * error,
			size_res => p3
			);
		
    	p2 <= resize(
			arg => p2_prev + data_X*data_X * error,
			size_res => p2
			);
		
    	p1 <= resize(
			arg => p1_prev + data_X * error,
			size_res => p1
			);
		
		p0 <= resize(
			arg => p0_prev + error,
			size_res => p0
			);

      acknowledge <= '1';
    
  	end if;

end process;

end architecture behaviour;
