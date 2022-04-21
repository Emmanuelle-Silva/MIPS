library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;

entity somador is
	port (
		sum_in,IR_in_sum : in std_logic_vector (15 downto 0);
		sum_out : out std_logic_vector (15 downto 0)
	);
end somador;

architecture Behavioural of somador is

begin

    sum_out <= sum_in + IR_in_sum -1;

end Behavioural;
