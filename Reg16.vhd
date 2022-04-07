library IEEE; use IEEE.STD_LOGIC_1164.all;

entity reg16 is
    port(clk: in std_logic;
        reset: in std_logic;
        en: in STD_LOGIC;
        d: in STD_LOGIC_VECTOR(15 downto 0);
        q: out STD_LOGIC_VECTOR(15 downto 0));
end;

architecture Behavioral of reg16 is
-- synchronous reset
begin
    process(clk) begin
        if clk'event and clk = '1' then
            if reset = '1' then
               q <= (others => '0');
            elsif en = '1' then
                q <= d;
            end if;
        end if;
    end process;
end;