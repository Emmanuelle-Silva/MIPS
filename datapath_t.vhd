----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2022 03:43:28 PM
-- Design Name: 
-- Module Name: datapath_t - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath_t is
--  Port ( );
end datapath_t;

architecture Behavioral of datapath_t is
    component datapath is
      Port ( RF_W_addr, RF_Rp_addr, RF_Rq_addr: in std_logic_vector(3 downto 0);
             RF_W_data: in std_logic_vector(7 downto 0);
             RF_W_wr, RF_Rp_rd, RF_Rq_rd: in std_logic;
             RF_Rp_zero: out std_logic;
             alu_s, RF_s: in std_logic_vector(1 downto 0);
             R_data: in std_logic_vector(15 downto 0);
             W_data: out std_logic_vector(15 downto 0);
             clk: in std_logic
             );
    end component;
    
     signal s_RF_W_addr, s_RF_Rp_addr, s_RF_Rq_addr: std_logic_vector(3 downto 0);
     signal s_RF_W_data: std_logic_vector(7 downto 0);
     signal s_RF_W_wr, s_RF_Rp_rd, s_RF_Rq_rd: std_logic;
     signal s_RF_Rp_zero: std_logic;
     signal s_alu_s, s_RF_s: std_logic_vector(1 downto 0);
     signal s_R_data: std_logic_vector(15 downto 0);
     signal s_W_data: std_logic_vector(15 downto 0);
     signal s_clk: std_logic;
begin

    uut: datapath port map(RF_W_addr      => s_RF_W_addr,
                           RF_Rp_addr     => s_RF_Rp_addr, 
                           RF_Rq_addr     => s_RF_Rq_addr ,
                           RF_W_data      => s_RF_W_data  ,
                           RF_W_wr        => s_RF_W_wr    ,
                           RF_Rp_rd       => s_RF_Rp_rd   ,
                           RF_Rq_rd       => s_RF_Rq_rd   ,
                           RF_Rp_zero     => s_RF_Rp_zero ,
                           alu_s          => s_alu_s,
                           RF_s           => s_RF_s,
                           R_data         => s_R_data     ,
                           W_data         => s_W_data     ,
                           clk            => s_clk        
                     );

    clk_gen: process
    begin
        s_clk <= '0';
        wait for 5 ns;
        s_clk <= '1';
        wait for 5 ns;
    end process;

    test: process
    begin
        -- Initialize
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "0000"; s_RF_W_wr <= '0'; 
        s_RF_Rp_addr <= "0000"; s_RF_Rp_rd <= '0'; 
        s_RF_Rq_addr <= "0000"; s_RF_Rq_rd <= '0';
        s_alu_s <= "00"; s_RF_s <= "00";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
        -- Load operation: addr(1010) <= 0xA
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "1010"; s_RF_W_wr <= '1'; 
        s_RF_Rp_addr <= "0000"; s_RF_Rp_rd <= '0'; 
        s_RF_Rq_addr <= "0000"; s_RF_Rq_rd <= '0';
        s_alu_s <= "00"; s_RF_s <= "01";
        s_R_data <= "0000000000001010";
        wait for 10 ns;
        -- Store operation: addr(1010) to memory ==== 0xA
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "0000"; s_RF_W_wr <= '0'; 
        s_RF_Rp_addr <= "1010"; s_RF_Rp_rd <= '1'; 
        s_RF_Rq_addr <= "1000"; s_RF_Rq_rd <= '0';
        s_alu_s <= "00"; s_RF_s <= "00";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
        -- Add operation: addr(1010) <= addr(1010) + addr(1010) ====== addr[0xa] = 0xA + 0xA = 0x14
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "1010"; s_RF_W_wr <= '1'; 
        s_RF_Rp_addr <= "1010"; s_RF_Rp_rd <= '1'; 
        s_RF_Rq_addr <= "1010"; s_RF_Rq_rd <= '1';
        s_alu_s <= "01"; s_RF_s <= "00";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
        -- Store operation: addr(1010) to memory === 0x14
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "0000"; s_RF_W_wr <= '0'; 
        s_RF_Rp_addr <= "1010"; s_RF_Rp_rd <= '1'; 
        s_RF_Rq_addr <= "1000"; s_RF_Rq_rd <= '0';
        s_alu_s <= "00"; s_RF_s <= "00";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
        -- Load Constant: addr(1011) <= 1111 ===== addr[0xB] = 0xF
        s_RF_W_data <= "00001111"; s_RF_W_addr <= "1011"; s_RF_W_wr <= '1'; 
        s_RF_Rp_addr <= "0000"; s_RF_Rp_rd <= '0'; 
        s_RF_Rq_addr <= "0000"; s_RF_Rq_rd <= '0';
        s_alu_s <= "00"; s_RF_s <= "10";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
        -- Store operation: addr(1011) to memory === 0xF
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "0000"; s_RF_W_wr <= '0'; 
        s_RF_Rp_addr <= "1011"; s_RF_Rp_rd <= '1'; 
        s_RF_Rq_addr <= "1000"; s_RF_Rq_rd <= '0';
        s_alu_s <= "00"; s_RF_s <= "00";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
        -- Subtract: addr(1110) <= addr(1010) - addr(1010) === addr[0xE] = 14 - 14 = 0
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "1110"; s_RF_W_wr <= '1'; 
        s_RF_Rp_addr <= "1010"; s_RF_Rp_rd <= '1'; 
        s_RF_Rq_addr <= "1010"; s_RF_Rq_rd <= '1';
        s_alu_s <= "10"; s_RF_s <= "00";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
        -- Jump-if-zero: addr(1110) == 0, so zero detect should equals 1
        s_RF_W_data <= "00000000"; s_RF_W_addr <= "0000"; s_RF_W_wr <= '0'; 
        s_RF_Rp_addr <= "1110"; s_RF_Rp_rd <= '1'; 
        s_RF_Rq_addr <= "0000"; s_RF_Rq_rd <= '0';
        s_alu_s <= "00"; s_RF_s <= "00";
        s_R_data <= "0000000000000000";
        wait for 10 ns;
    
        wait;
    end process;

end Behavioral;
