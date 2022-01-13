library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
-- Tamaño de los datos: 32bits de coma fija, 22bits de entero y 10 decimales (precisión de ~0.001)
-- NOTE: NOT TESTED YET, FIXED_PKG REFERENCING ERRORS NEED TO BE SOLVED
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
   
    type fixed_vector is array (0 to 4) of integer; -- To change to 'sfixed', left as integer for now
    
    -- Module internal signals
    signal deltas: fixed_vector;    
    signal params: fixed_vector := (others => 0); --Params to be stored in buffer
         
    begin
    
    --Input tracking
    deltas(0) <= deltaA;
    deltas(1) <= deltaB;
    deltas(2) <= deltaC;
    deltas(3) <= deltaD;
    deltas(4) <= deltaE;
    
    --Output tracking
    A <= params(0);
    B <= params(1);
    C <= params(2);
    D <= params(3);
    E <= params(4);
      
    -- Cada vez que se activa "trigger" con un flanco de subida, actualizar cada salida con su delta  
    buffering: process(trigger)
    begin
    --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
        params(0) <= params(0) + deltas(0);
        params(1) <= params(1) + deltas(1);
        params(2) <= params(2) + deltas(2);
        params(3) <= params(3) + deltas(3);
        params(4) <= params(4) + deltas(4);
    
    end process;
    

end architecture behaviour;