library IEEE;
use IEEE.STD_LOGIC_1164.all;

architecture synth of memory is
begin
	process is
		file mem_file: text open read_mode is "memfile.dat";
		variable L: line;
		variable ch: character;
		variable index, result: integer;
		type ramtype is array (255 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
		variable mem: ramtype;
	begin
		-- initialize memory from file
		-- memory in little-endian format
		-- 80020044 means mem[3] = 80 and mem[0] = 44
		for i in 0 to 255 loop -- set all contents low
			mem(conv_integer(i)) := "00000000";
		end loop;
		index := 0;
		while not endfile(mem_file) loop
			readline(mem_file, L);
			for j in 0 to 3 loop
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
				mem(index*4+3-j) := conv_std_logic_vector(result, width);
			end loop;
			index := index + 1;
		end loop;
		-- read or write memory
		loop
			if clk'event and clk = '1' then
				if (memwrite = '1') then mem(conv_integer(adr)) := writedata;
				end if;
			end if;
			memdata <= mem(conv_integer(adr));
			wait on clk, adr;
		end loop;
	end process;
end;