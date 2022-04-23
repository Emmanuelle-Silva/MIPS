library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.std_logic_unsigned.all;

entity datapath is
  Port ( RF_W_addr, RF_Rp_addr, RF_Rq_addr: in std_logic_vector(3 downto 0);
         RF_W_data: in std_logic_vector(7 downto 0);
         RF_W_wr, RF_Rp_rd, RF_Rq_rd: in std_logic;
         RF_Rp_zero: out std_logic;
         alu_s, RF_s: in std_logic_vector(1 downto 0);
         R_data: in std_logic_vector(15 downto 0);
         W_data: out std_logic_vector(15 downto 0);
         clk: in std_logic
         );
end datapath;

architecture Behavioral of datapath is
    component mux_3x1 is
      Port ( A0: in std_logic_vector(15 downto 0);
             A1: in std_logic_vector(15 downto 0);
             A2: in std_logic_vector(15 downto 0);
             Y: out std_logic_vector(15 downto 0);
             s : in std_logic_vector(1 downto 0) );
    end component;
    
    component ALU_16bit is
      Port ( A : in std_logic_vector(15 downto 0);
             B : in std_logic_vector(15 downto 0);
             Y : out std_logic_vector(15 downto 0);
             s : in std_logic_vector(1 downto 0) );
    end component;
    
    component regfile is -- three-port register file of 2**regbits words x width bits
        generic(width: integer := 16;
                regbits: integer := 4);
        port(	clk: in STD_LOGIC;
            W_wr, Rp_rd, Rq_rd: in STD_LOGIC;
            Rp_addr, Rq_addr, W_addr: in STD_LOGIC_VECTOR(regbits-1 downto 0);
            W_data: in STD_LOGIC_VECTOR(width-1 downto 0);
            Rp_data, Rq_data: out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;
    
    component zero_detect is
      Port ( A : in std_logic_vector(15 downto 0);
             Y : out std_logic );
    end component;
    
    signal s_alu_out, s_mux_out, s_alu_A, s_alu_B: std_logic_vector(15 downto 0);
    signal s_a2: std_logic_vector(15 downto 0);
begin

    mux: mux_3x1 port map(A0 => s_alu_out,
                          A1 => R_data,
                          A2 => s_a2,
                          s => RF_s,
                          Y => s_mux_out);
                          
    RF: regfile port map(W_data => s_mux_out,
                         W_addr => RF_W_addr,
                         clk => clk,
                         W_wr => RF_W_wr,
                         Rp_addr => RF_Rp_addr,
                         Rp_rd => RF_Rp_rd,
                         Rq_addr => RF_Rq_addr,
                         Rq_rd => RF_Rq_rd,
                         Rp_data => s_alu_A,
                         Rq_data => s_alu_B);
   alu: ALU_16bit port map(A => s_alu_A,
                           B => s_alu_B,
                           Y => s_alu_out,
                           s => alu_s);
   zero_detector: zero_detect port map(A => s_alu_A,
                                       Y => RF_Rp_zero); 
    
    
    W_data <= s_alu_A;
    s_a2 <= "00000000" & RF_W_data;

end Behavioral;
