library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Registrador de instruções
entity inst_reg is 
	generic(width: integer);
	port(	clk: in STD_LOGIC;
			ld : in STD_LOGIC;
			data_in_IR: in STD_LOGIC_VECTOR(15 downto 0);
			data_out_IR : out STD_LOGIC_VECTOR(15 downto 0) 
		);
end;


architecture synth of inst_reg is
begin
	process(clk,ld) begin
		if clk'event and clk = '1' then
			if ld = '1' then
			data_out_IR <= data_in_IR;
		end if;
	end process;
end;