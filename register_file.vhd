library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity regfile is -- three-port register file of 2**regbits words x width bits
	generic(width: integer := 16;
	        regbits: integer := 4);
	port(	clk: in STD_LOGIC;
		W_wr, Rp_rd, Rq_rd: in STD_LOGIC;
		Rp_addr, Rq_addr, W_addr: in STD_LOGIC_VECTOR(regbits-1 downto 0);
		W_data: in STD_LOGIC_VECTOR(width-1 downto 0);
		Rp_data, Rq_data: out STD_LOGIC_VECTOR(width-1 downto 0));
end;

architecture synth of regfile is
	type ramtype is array (2**regbits-1 downto 0) of STD_LOGIC_VECTOR(width-1 downto 0);
	signal mem: ramtype;
begin
	-- three-ported register file
	-- read two ports combinationally
	-- W_wr third port on rising edge of clock
	process(clk) begin
		if clk'event and clk = '1' then
			if W_wr = '1' then 
				mem(conv_integer(W_addr)) <= W_data;
			end if;
		end if;
	end process;

	process(Rp_addr, Rq_addr, Rp_rd, Rq_rd) begin
		if (conv_integer(Rp_addr) = 0 or Rp_rd = '0') then
			Rp_data <= conv_std_logic_vector(0, width); -- register 0 holds 0
		else
			Rp_data <= mem(conv_integer(Rp_addr));
		end if;
		if (conv_integer(Rq_addr) = 0 or Rq_rd = '0') then
			Rq_data <= conv_std_logic_vector(0, width);
		else
			Rq_data <= mem(conv_integer(Rq_addr));
		end if;
	end process;
end;