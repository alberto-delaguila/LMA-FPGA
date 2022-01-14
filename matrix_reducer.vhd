library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity matrix_reducer is
    port(
        data_X : in std_logic_vector(31 downto 0);

        p0, p1, p2, p3, p4 : in std_logic_vector(31 downto 0);

        deltaA, deltaB, deltaC, deltaD, deltaE : out std_logic_vector(31 downto 0);

        d_trigger : in std_logic; --leer datos
        p_trigger : in std_logic; --leer p-vector
        end_of_data : in std_logic; --no hay más datos que incluir

        acknowledge : out std_logic; --datos listos para enviar (pipeline del bloque siguiente)
        ctr_reset : in std_logic --resetear lógica de control
    );
end entity;

architecture behaviour of matrix_reducer is
    
    type MATRIX is array(1 to 5, 1 to 6) of integer;
    type PARRAY is array(1 to 5) of integer;
    signal system_matrix : MATRIX := ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0));
    signal reduced_matrix : MATRIX:= ((0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0),(0,0,0,0,0,0));
    signal reading, done : std_logic;

    procedure GJReduction (signal ini_matrix : in MATRIX; signal red_matrix : out MATRIX) is
        variable temp_matrix : MATRIX;
        variable factor_pivot : integer;
        variable factor_mult : integer;        
        
        begin
        temp_matrix := ini_matrix;
        for pivot in 1 to 5 loop
            factor_pivot := temp_matrix(pivot, pivot);
                for c in 1 to 6 loop
                temp_matrix(pivot,c) := temp_matrix(pivot,c)/factor_pivot;
            end loop;
            
            for r in 1 to 5 loop
                if r /= pivot then
                    factor_mult := temp_matrix(r, pivot);
                    for c in 1 to 6 loop
                        temp_matrix(r,c) := temp_matrix(r,c) - (factor_mult*temp_matrix(pivot,c));
                    end loop;
                end if;
            end loop;
        end loop;
        red_matrix <= temp_matrix;
    end GJReduction;
    
    begin
        reset: process(ctr_reset)
        begin
            if ctr_reset'event and ctr_reset = '0' then
                reading <= '0';
                done <= '0';
            end if;
        end process reset;


        h_build: process(d_trigger, p_trigger)
        variable p_array : PARRAY := (
            to_integer(signed(p0)),
            to_integer(signed(p1)),
            to_integer(signed(p2)),
            to_integer(signed(p3)),
            to_integer(signed(p4))
            );

        begin
            if d_trigger'event and d_trigger = '1' then
                reading <= '1';
                for i in 1 to 5 loop
                    for j in 1 to 5 loop
                        system_matrix(i,j) <= system_matrix(i,j) + to_integer(signed(data_X)) ** (i+j-2);
                    end loop;
                end loop;
            else
                reading <= '0';
            end if;
            
            if p_trigger'event and p_trigger = '1' then
                for i in 1 to 5 loop
                    system_matrix(i,6) <= p_array(i);
                end loop;
            end if;
        end process h_build;

        reduce: process(end_of_data, reading)
        begin
            if reading = '0' and end_of_data'event and end_of_data = '1' then
                GJReduction(system_matrix,reduced_matrix);
                done <= '1';
            else
                done <= '0';
            end if;
        end process reduce;

        output_data: process(done)
        variable p4_t, p3_t, p2_t, p1_t, p0_t : integer;
        begin
            if done'event and done = '1' then
                p4_t := reduced_matrix(5,6);
                p3_t := reduced_matrix(4,6);
                p2_t := reduced_matrix(3,6);
                p1_t := reduced_matrix(2,6);
                p0_t := reduced_matrix(1,6);

                acknowledge <= '1';
                deltaA <= std_logic_vector(to_signed(p4_t, 32));
                deltaB <= std_logic_vector(to_signed(p3_t, 32));
                deltaC <= std_logic_vector(to_signed(p2_t, 32));
                deltaD <= std_logic_vector(to_signed(p1_t, 32));
                deltaE <= std_logic_vector(to_signed(p0_t, 32));
            else
                acknowledge <= '0';
            end if;
        end process output_data;
end architecture behaviour;