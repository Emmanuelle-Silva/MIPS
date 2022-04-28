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
	constant rom: memory :=("0000000000000000",
                            "0000101000000011", -- MOV R10, 0x03
                            "0001101000000011", -- MOV 0x03, R10
                            "0011000100001010", -- MOV R1, #10
                            "0011001000001010", -- MOV R2, #10
                            "0010001100010010", -- ADD R0, R1, R2
                            "0011001000001010", -- MOV R2, #10
                            "0100000000010010", -- SUB R0, R1, R2
                            "0101101000000010", -- JMPZ R10, 0x02
                            "0101101000000010", -- JMPZ R10, 0x02
                            "0101101011111110", -- JMPZ R10, 0xfe ===> jump -2
                            others => (others => '0') );
begin

    with rd select data <=
        rom(conv_integer(addr)) when '1',
        (others => '0') when others;

end Behavioural;

