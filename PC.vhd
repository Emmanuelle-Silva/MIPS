library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity PC is
	port (
		ld,clr,clk,up : in std_logic;
		PC_sum : in std_logic_vector (0 downto 15);
		PC_out : in std_logic_vector (0 downto 15)
	);
end;

architecture comportamental of PC is
signal temp_PC_out : std_logic_vector (0 downto 15);
begin
		process(clk)
			if (clr = '1') then
				PC_out<=(OTHERS => '0')
			elsif rising_edge(clk) and clk='1' then
				temp_PC_out<= std_logic_vector(unsigned(PC_sum));
		end process;
		PC_out<=temp_PC_out;
end comportamental;
