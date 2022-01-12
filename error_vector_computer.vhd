library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

-- Tamaño de los datos: 32bits de coma fija, 22bits de entero y 10 decimales (precisión de ~0.001)

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
--Cada vez que se recibe un flanco de subida de trigger:
 -- Se leen data_X y data_Y
 -- Con data_X se calcula A*x^4 + B*x^3 + C*x^2 + D*x + E
 -- Se calcula el error de data_Y con el polinomio anterior
 -- Se acumulan las siguientes cantidades en 5 buffers (las salidas p de la entidad)
   -- p_k += data_X^k * error
end architecture behaviour;