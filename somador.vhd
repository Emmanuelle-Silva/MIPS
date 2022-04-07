library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity somador is
	port (
		sum_in,IR_in_sum : in std_logic_vector (0 downto 15);
		sum_out : out std_logic_vector (0 downto 15)
	);
end somador;

architecture comportamental of somador is
signal aux_out : std_logic_vector (0 downto 15);
begin
		process(sum_in,IR_in_sum )
			begin
				aux_out<=std_logic_vector(signed(sm_in)+signed(IR_in_sum));
		end process;
		sum_out<=aux_out;
end somador;
