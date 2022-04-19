library IEEE;
use IEEE.STD_LOGIC_1164.all;
--use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
--use IEEE.STD_LOGIC_ARITH.all;

entity inst_memory is
	port (
		rd : in std_logic;	
		addr : in std_logic_vector (15 downto 0);
		data : out std_logic_vector (15 downto 0)
	);
end inst_memory;

architecture Behavioural of inst_memory is
	type memory is array (0 to 65535) of std_logic_vector (15 downto 0);
	constant rom: memory :=("1001000101010010",
                            "1111000010110101",
                            "0011110110110011",
                            "1011101110011110",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            "1101101100110001",
                            others => (others => '0') );
begin

    with rd select data <=
        rom(conv_integer(addr)) when '1',
        (others => '0') when others;

end Behavioural;

