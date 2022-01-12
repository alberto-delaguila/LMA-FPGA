library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

-- Tamaño de los datos: 32bits de coma fija, 22bits de entero y 10 decimales (precisión de ~0.001)

entity parameter_buffer is
    port(
        deltaA : in sfixed(22 downto -10);
        deltaB : in sfixed(22 downto -10);
        deltaC : in sfixed(22 downto -10);
        deltaD : in sfixed(22 downto -10);
        deltaE : in sfixed(22 downto -10);

        A : out sfixed(22 downto -10);
        B : out sfixed(22 downto -10);
        C : out sfixed(22 downto -10);
        D : out sfixed(22 downto -10);
        E : out sfixed(22 downto -10);

        trigger : in std_logic --iniciar proceso
    );
end entity;

architecture behaviour of parameter_buffer is
    begin
-- Cada vez que se activa "trigger" con un flanco de subida, actualizar cada salida con su delta
end architecture behaviour;