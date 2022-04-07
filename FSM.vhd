----------------------------------------------------------------------------------
-- Create Date: 05.04.2022 16:28:38
-- Design Name: 
-- Module Name: FSM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
    Port ( 
        clk: in std_logic;
        rst: in std_logic;
        ir: in std_logic_vector (15 downto 0);
        rp_zero:in std_logic;
        --Dados de saídas para se comunicar com o bloco operacional
        -- o que tiver o pre-lebal "d_" se comunica fora do bloco operacional
        w_addr, rp_addr, rq_addr: out std_logic_vector (3 downto 0);
        w_wr, rp_rd, rq_rd, d_rd, d_wr: out std_logic;
        d_addr, w_data: out std_logic_vector (7 downto 0);
        rf_s1,rf_s0, ula_s1, ula_s0: out std_logic;
        --Dados de saídas para se comunicar com  a parte internda da unidade de controle 
        ir_ld, i_ld: out std_logic;
        PC_clr, PC_inc, PC_ld: out std_logic
    );
end FSM;

architecture Behavioral of FSM is
    type tipo_estado is (inicio,busca,decodificacao,carregar,armazenar,somar,carregar_constante,subtrair,saltar_se_zero, saltar);
    signal prox_estado, atual_estado : tipo_estado :=inicio;
    signal ra,rb,rc : std_logic_vector (3 downto 0);
    signal d,c : std_logic_vector (7 downto 0);
begin
    
    
    rst_state : process(clk, rst)
    begin
        if rst = '1' then
            atual_estado <= inicio;
        elsif rising_edge(clk) then
            atual_estado <= prox_estado;
        end if; 
    end process;
    
    controle: process (atual_estado, ir)
    begin
            case atual_estado is
                when inicio =>
                    prox_estado <= busca;
                    ir_ld   <='0';
                    PC_clr  <='1';
                    PC_inc  <='0';
                    PC_ld   <='0';
                    i_ld    <='0';
                        
                    w_addr  <="0000";
                    w_data  <="00000000";
                    w_wr    <='0';
                    rp_addr <="0000";
                    rp_rd   <='0';
                    rq_addr <="0000";
                    rq_rd   <='0';
                    rf_s1   <='0';
                    rf_s0   <='0';
                    ula_s1  <='0';
                    ula_s0  <='0';
                    
                    d_rd    <='0';
                    d_wr    <='0';
                    d_addr  <="00000000";
                    
                when busca =>
                    if rp_zero = '0' then
                        prox_estado <= decodificacao;
                    else
                        prox_estado <= busca;
                    end if;
                    ir_ld   <='1';
                    PC_clr  <='0';
                    PC_inc  <='1';
                    PC_ld   <='0';
                    i_ld    <='1';
                    
                    w_addr  <="0000";
                    w_data  <="00000000";
                    w_wr    <='0';
                    rp_addr <="0000";
                    rp_rd   <='0';
                    rq_addr <="0000";
                    rq_rd   <='0';
                    rf_s1   <='0';
                    rf_s0   <='0';
                    ula_s1  <='0';
                    ula_s0  <='0';
                    
                    d_rd    <='0';
                    d_wr    <='0';
                    d_addr  <="00000000";
                when decodificacao =>
                    if ir (15 downto 12) = "0000" then -- Carregar
                        prox_estado <= carregar;
                        
                        ra  <= ir(11 downto 8);
                        d   <= ir(7  downto 0);
                        
                    elsif ir (15 downto 12) = "0001" then -- Armazenar
                        prox_estado <= armazenar;
                        
                        ra  <= ir(11 downto 8);
                        d   <= ir(7  downto 0);
                        
                    elsif ir (15 downto 12) = "0010" then -- Somar
                        prox_estado <= somar;
                        
                        ra  <= ir(11 downto 8);
                        rb  <= ir(7 downto 4);
                        rc  <= ir(3 downto 0);
                        
                    elsif ir (15 downto 12) = "0011" then -- Carregar_Constante
                        prox_estado <= carregar_constante;
                        
                        ra  <= ir(11 downto 8);
                        c   <= ir(7 downto 0);
                        
                    elsif ir (15 downto 12) = "0100" then -- Subtrair
                        prox_estado <= subtrair;
                        
                        ra  <= ir(11 downto 8);
                        rb  <= ir(7 downto 4);
                        rc  <= ir(3 downto 0);
                        
                    elsif ir (15 downto 12) = "0101" then -- Saltar_se_Zero
                        prox_estado <= saltar_se_zero;
                        
                        ra  <= ir(11 downto 8);
                        
                        
                    else 
                        prox_estado <= decodificacao;
                        
                    end if;
                    
                    ir_ld   <='0';
                    PC_clr  <='0';
                    PC_inc  <='0';
                    PC_ld   <='0';
                    i_ld    <='0';
                        
                    w_addr  <="0000";
                    w_data  <="00000000";
                    w_wr    <='0';
                    rp_addr <="0000";
                    rp_rd   <='0';
                    rq_addr <="0000";
                    rq_rd   <='0';
                    rf_s1   <='0';
                    rf_s0   <='0';
                    ula_s1  <='0';
                    ula_s0  <='0';
                    
                    d_rd    <='0';
                    d_wr    <='0';
                    d_addr  <="00000000";
                    
                when carregar =>
                    prox_estado <= busca;
                    
                    i_ld    <='0';
                    ir_ld   <='0';
                    PC_clr  <='0';
                    PC_inc  <='0';
                    PC_ld   <='0';

                    w_addr  <=ra;
                    w_wr    <='1';
                    w_data  <="00000000";
                    
                    rp_addr <="0000";
                    rp_rd   <='0';
                    
                    rq_addr <="0000";
                    rq_rd   <='0';
                    
                    rf_s1   <='1';
                    rf_s0   <='0';
                    
                    ula_s1  <='0';
                    ula_s0  <='0';
                    
                    d_addr  <=d;
                    d_rd    <='1';
                    d_wr    <='0';

                when armazenar =>
                    prox_estado <= busca;
                    
                    i_ld    <='0';
                    ir_ld   <='0';
                    PC_clr  <='0';
                    PC_inc  <='0';
                    PC_ld   <='0';                        
                    
                    w_addr  <="0000";
                    w_wr    <='0';
                    w_data  <="00000000";
                                            
                    rp_addr <=ra;
                    rp_rd   <='1';

                    rq_addr <="0000";
                    rq_rd   <='0';

                    rf_s1   <='X';
                    rf_s0   <='X';
                    
                    ula_s1  <='0';
                    ula_s0  <='0';
                    
                    d_addr  <=d;
                    d_rd    <='0';
                    d_wr    <='1';
                        
                        
                when somar =>
                    prox_estado <= busca;
                    
                    i_ld    <='0';
                    ir_ld   <='0';
                    PC_clr  <='0';
                    PC_inc  <='0';
                    PC_ld   <='0';
                    
                    w_addr  <=ra;
                    w_wr    <='1';
                    w_data  <="00000000";
                    
                    rp_addr <=rb;
                    rp_rd   <='1';
                                            
                    rq_addr <=rc;
                    rq_rd   <='1';
                    
                    
                    rf_s1   <='0';
                    rf_s0   <='0';
                    
                    ula_s1  <='0';
                    ula_s0  <='1';
                    
                    d_rd    <='0';
                    d_wr    <='0';
                    d_addr  <="00000000";
                        
                when carregar_constante =>
                    prox_estado <= busca;
                        
                    i_ld    <='0';
                    ir_ld   <='0';
                    PC_clr  <='0';
                    PC_inc  <='0';
                    PC_ld   <='0';
                    
                    
                    w_addr  <=ra;
                    w_data  <=c;
                    w_wr    <='1';
                    
                    rp_addr <="0000";
                    rp_rd   <='0';
                    rq_addr <="0000";
                    rq_rd   <='0';
                    
                    rf_s1   <='1';
                    rf_s0   <='0';
                    
                    ula_s1  <='0';
                    ula_s0  <='0';
                    
                    d_addr  <="00000000";
                    d_rd    <='0';
                    d_wr    <='0';
                        
                when subtrair =>
                    prox_estado <= busca;
                        
                    i_ld    <='0';
                    ir_ld   <='0';
                    PC_clr  <='0';
                    PC_inc  <='0';
                    PC_ld   <='0';
                    
                    w_addr  <=ra;
                    w_data  <="00000000";
                    w_wr    <='1';
                    
                    rp_addr <=rb;
                    rp_rd   <='1';
                    
                    rq_addr <=rc;
                    rq_rd   <='1';
                    
                    rf_s1   <='0';
                    rf_s0   <='0';
                    
                    ula_s1  <='1';
                    ula_s0  <='0';
                    
                    d_rd    <='0';
                    d_wr    <='0';
                    d_addr  <="00000000";
                    
                when saltar_se_zero =>
                    if rp_zero = '1' then
                        prox_estado <= saltar;
                        
                        i_ld    <='0';
                        ir_ld   <='0';
                        PC_clr  <='0';
                        PC_inc  <='0';
                        PC_ld   <='0';
                        
                        w_addr  <="0000";
                        w_data  <="00000000";
                        w_wr    <='0';
                        
                        rp_addr <=ra;
                        rp_rd   <='1';
                        
                        rq_addr <="0000";
                        rq_rd   <='0';
                        
                        rf_s1   <='0';
                        rf_s0   <='0';
                        
                        ula_s1  <='0';
                        ula_s0  <='0';
                        
                        d_rd    <='0';
                        d_wr    <='0';
                        d_addr  <="00000000";
                    else
                        prox_estado <= busca;
                    end if; 
                when saltar =>
                    prox_estado <= busca;
                        
                    i_ld    <='0';
                    ir_ld   <='0';
                    PC_clr  <='0';
                    PC_inc  <='0';
                    PC_ld   <='1';
                    
                    w_addr  <="0000";
                    w_data  <="00000000";
                    w_wr    <='0';
                    
                    rp_addr <="0000";
                    rp_rd   <='0';
                    
                    rq_addr <="0000";
                    rq_rd   <='0';
                    
                    rf_s1   <='0';
                    rf_s0   <='0';
                    
                    ula_s1  <='0';
                    ula_s0  <='0';
                    
                    d_rd    <='0';
                    d_wr    <='0';
                    d_addr  <="00000000";
                    
            end case;

    end process;
end Behavioral;
