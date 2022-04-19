library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;

entity PC is
	port (
		ld,clr,clk,up : in std_logic;
		PC_sum : in std_logic_vector (15 downto 0);
		PC_out : out std_logic_vector (15 downto 0)
	);
end;

architecture comportamental of PC is
signal temp_PC_out : std_logic_vector (15 downto 0);
begin
    process(clk, clr)
    begin
        if (clr = '1') then
            temp_PC_out<=(OTHERS => '0');
        elsif rising_edge(clk) and clk='1' then
            if(up = '1' and ld = '0') then
                temp_PC_out <= temp_PC_out + 1;
            elsif(up = '0' and ld = '1') then
                temp_PC_out <= PC_sum;
            else
                temp_PC_out <= temp_PC_out;
            end if;
        end if;
    end process;
    
    PC_out<=temp_PC_out;
end comportamental;
