library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    Port (  
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            --I memory
            data : in STD_LOGIC_VECTOR (15 downto 0);
            rd : out STD_LOGIC;
            addr: out STD_LOGIC_VECTOR (15 downto 0);
            
            --D memory
            D_addr : out STD_LOGIC_VECTOR (7 downto 0);
            D_rd :  out STD_LOGIC;
            D_wr :  out STD_LOGIC;
            
            --Datapah
            --Mux16Bits
            RF_W_data : out STD_LOGIC_VECTOR (7 downto 0);
            RF_s1 :     out STD_LOGIC;
            RF_s0 :     out STD_LOGIC;
            
            --RF
            RF_W_addr: out STD_LOGIC_VECTOR (3 downto 0);
            RF_W_wr: out STD_LOGIC;
            RF_Rp_addr: out STD_LOGIC_VECTOR (3 downto 0);
            RF_Rp_rd: out STD_LOGIC;
            RF_Rq_addr: out STD_LOGIC_VECTOR (3 downto 0);
            RF_Rq_rd: out STD_LOGIC;
            RF_Rp_zero: in STD_LOGIC;
            
            --ALU
            alu_s1: out STD_LOGIC;
            alu_s0: out STD_LOGIC            
           );
end control_unit;

architecture Behavioral of control_unit is
    component PC is
        port (
                ld,clr,clk,up : in std_logic;
                PC_sum : in std_logic_vector (15 downto 0);
                PC_out : out std_logic_vector (15 downto 0)
               );
    end component;
    
    component somador is
        port (
            sum_in,IR_in_sum : in std_logic_vector (15 downto 0);
            sum_out : out std_logic_vector (15 downto 0)
        );
    end component;
    
    component inst_reg is 
        port(	clk: in STD_LOGIC;
                ld : in STD_LOGIC;
                data_in_IR: in STD_LOGIC_VECTOR(15 downto 0);
                data_out_IR : out STD_LOGIC_VECTOR(15 downto 0) 
            );
    end component;
    
    component  FSM is
        Port ( 
            clk: in std_logic;
            rst: in std_logic;
            ir: in std_logic_vector (15 downto 0);
            rp_zero:in std_logic;
            --Dados de sa�das para se comunicar com o bloco operacional
            -- o que tiver o pre-lebal "d_" se comunica fora do bloco operacional
            w_addr, rp_addr, rq_addr: out std_logic_vector (3 downto 0);
            w_wr, rp_rd, rq_rd, d_rd, d_wr: out std_logic;
            d_addr, w_data: out std_logic_vector (7 downto 0);
            rf_s1,rf_s0, ula_s1, ula_s0: out std_logic;
            --Dados de sa�das para se comunicar com  a parte internda da unidade de controle 
            ir_ld, i_ld: out std_logic;
            PC_clr, PC_inc, PC_ld: out std_logic
        );
    end component;
    
    signal pc_out_addr, out_IR, IR_in_sum, s_sum_out: std_logic_vector (15 downto 0);
    signal s_ir_ld, s_i_rd, s_pc_ld, s_pc_inc, s_pc_clr: std_logic;

begin
    addr <= pc_out_addr;
    IR_in_sum <= out_IR(7) & out_IR(7) & out_IR(7) & out_IR(7)
               & out_IR(7) & out_IR(7) & out_IR(7) & out_IR(7) 
               & out_IR(7 downto 0);
    
    
    PC_block: PC port map (
                ld  => s_pc_ld,
                clr => s_pc_clr,
                clk => clk,
                up  => s_PC_inc,
                PC_sum => s_sum_out,
                PC_out => pc_out_addr
               );
    
    sum: somador port map (
            sum_in => pc_out_addr,
            IR_in_sum => IR_in_sum, 
            sum_out => s_sum_out
        );
    
    IR_block: inst_reg port map(
                clk => clk,
                ld => s_ir_ld,
                data_in_IR => data,
                data_out_IR => out_IR 
               );
    
    FSM_block: FSM Port map ( 
            clk => clk,
            rst => rst,
            ir => out_ir,
            rp_zero => RF_Rp_zero,
            --Dados de sa�das para se comunicar com o bloco operacional
            -- o que tiver o pre-label "d_" se comunica fora do bloco operacional
            w_addr  => RF_w_addr,
            rp_addr => RF_rp_addr,
            rq_addr => RF_rq_addr,
            w_wr    => RF_w_wr, 
            rp_rd   => RF_rp_rd, 
            rq_rd   => RF_rq_rd, 
            d_rd    => d_rd, 
            d_wr    => d_wr,
            d_addr  => d_addr,
            w_data  => RF_W_data,
            rf_s1   => RF_s1,
            rf_s0   => RF_s0, 
            ula_s1  => alu_s1, 
            ula_s0  => alu_s0,
            --Dados de sa�das para se comunicar com  a parte internda da unidade de controle 
            ir_ld   => s_ir_ld,
            i_ld    => s_i_rd,
            PC_clr  => s_pc_clr,
            PC_inc  => s_pc_inc,
            PC_ld   => s_pc_ld
    );
    
    rd <= s_i_rd;
    
end Behavioral;
