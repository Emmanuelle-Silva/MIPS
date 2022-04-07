library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity memory is -- external memory accessed by MIPS
	generic(width: integer := 16);
	port(	clk, D_wr, D_rd: in STD_LOGIC;
		D_addr, W_data: in STD_LOGIC_VECTOR(width-1 downto 0);
		R_data: out STD_LOGIC_VECTOR(width-1 downto 0));
end;

architecture synth of memory is
begin
	process is
		file mem_file: text open read_mode is "memfile.dat";
		variable L: line;
		variable ch: character;
		variable index, result: integer;
		type ramtype is array (255 downto 0) of STD_LOGIC_VECTOR(width-1 downto 0);
		variable mem: ramtype;
	begin
		-- initialize memory from file
		-- memory in little-endian format
		-- 80020044 means mem[3] = 80 and mem[0] = 44
		for i in 0 to 255 loop -- set all contents low
			mem(conv_integer(i)) := (others => '0');
		end loop;
		index := 0;
		while not endfile(mem_file) loop
			readline(mem_file, L);
			for j in 0 to 1 loop
				result := 0;
				for i in 1 to 2 loop
					read(L, ch);
					if '0' <= ch and ch <= '9' then
						result := result*16 + character'pos(ch)-character'pos('0');
					elsif 'a' <= ch and ch <= 'f' then
						result := result*16 + character'pos(ch)-character'pos('a')+10;
					else report "Format error on line " & integer'image(index) severity error;
					end if;
				end loop;
				mem(index*2+1-j) := conv_std_logic_vector(result, width);
			end loop;
			index := index + 1;
		end loop;
		-- read or write memory
		loop
			if clk'event and clk = '1' then
				if (D_wr = '1') then mem(conv_integer(D_addr)) := W_data;
				end if;
				if(D_rd = '1') then
				    R_data <= mem(conv_integer(D_addr));
				else
				    R_data <= (others => '0');
				end if;
			end if;
			
			
			wait on clk, D_addr;
		end loop;
	end process;
end;