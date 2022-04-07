library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inst_memory is
	port (
		rs : in std_logic;	
		addr : in std_logic_vector (15 downto 0);
		data : out std_logic_vector (15 downto 0)
	);
end inst_memory;

architecture memory1 of inst_memory is
	type memory is array (15 to 0); of bit_vector (15 downto 0);
	constant rom:memory:=(
			"100100010101001"
			"1111000010110101"
			"0011110110110011"
			"1011101110011110"
			"1101101100110001" );
begin
	data<=rom(addr);
end

