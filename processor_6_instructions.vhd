----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2022 07:47:46 PM
-- Design Name: 
-- Module Name: processor_6_instructions - Behavioral
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

entity processor_6_instructions is
  Port ( clk: in std_logic;
         rst: in std_logic);
end processor_6_instructions;

architecture Behavioral of processor_6_instructions is
    component control_unit is
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
    end component;
    
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
    
    component memory is -- external memory accessed by MIPS
        generic(width: integer := 16);
        port(	clk, D_wr, D_rd: in STD_LOGIC;
            W_data: in STD_LOGIC_VECTOR(width-1 downto 0);
            R_data: out STD_LOGIC_VECTOR(width-1 downto 0);
            D_addr: in std_logic_vector(7 downto 0));
    end component;
    
    component inst_memory is
        port (
            rd : in std_logic;	
            addr : in std_logic_vector (15 downto 0);
            data : out std_logic_vector (15 downto 0)
        );
    end component;
    
    --I memory
    signal data :  STD_LOGIC_VECTOR (15 downto 0);
    signal rd :  STD_LOGIC;
    signal addr:  STD_LOGIC_VECTOR (15 downto 0);
    
    --D memory
    signal D_addr :  STD_LOGIC_VECTOR (7 downto 0);
    signal D_rd :   STD_LOGIC;
    signal D_wr :   STD_LOGIC;
    signal W_data: std_logic_vector(15 downto 0);
    signal R_data: std_logic_vector(15 downto 0);
     
     --Datapath
     --Mux16Bits
    signal RF_W_data :  STD_LOGIC_VECTOR (7 downto 0);
    signal RF_s1 :      STD_LOGIC;
    signal RF_s0 :      STD_LOGIC;
    signal RF_s :      STD_LOGIC_vector(1 downto 0);
    --RF
    signal RF_W_addr:  STD_LOGIC_VECTOR (3 downto 0);
    signal RF_W_wr:  STD_LOGIC;
    signal RF_Rp_addr:  STD_LOGIC_VECTOR (3 downto 0);
    signal RF_Rp_rd:  STD_LOGIC;
    signal RF_Rq_addr:  STD_LOGIC_VECTOR (3 downto 0);
    signal RF_Rq_rd:  STD_LOGIC;
    signal RF_Rp_zero:  STD_LOGIC;
     
    --ALU
    signal     alu_s1: STD_LOGIC;
    signal     alu_s0: STD_LOGIC;
    signal     alu_s: std_logic_vector(1 downto 0);
    
begin

alu_s <= alu_s1 & alu_s0;
RF_s <= RF_s1 & RF_s0;

c_unit: control_unit port map(  clk => clk,
                                rst => rst,   
                                data => data,
                                rd => rd,
                                addr => addr,
                                D_addr => D_addr,
                                D_rd => D_rd,
                                D_wr => D_wr,
                                RF_W_data => RF_W_data, 
                                RF_s1 => RF_s1,   
                                RF_s0 => RF_s0,   
                                RF_W_addr => RF_W_addr,
                                RF_W_wr => RF_W_wr, 
                                RF_Rp_addr => RF_Rp_addr,
                                RF_Rp_rd => RF_Rp_rd,
                                RF_Rq_addr => RF_Rq_addr,
                                RF_Rq_rd => RF_Rq_rd,
                                RF_Rp_zero => RF_Rp_zero,
                                alu_s1 => alu_s1,
                                alu_s0 => alu_s0);
                                
data_p: datapath port map(RF_W_addr      => RF_W_addr,
                           RF_Rp_addr     => RF_Rp_addr, 
                           RF_Rq_addr     => RF_Rq_addr ,
                           RF_W_data      => RF_W_data  ,
                           RF_W_wr        => RF_W_wr    ,
                           RF_Rp_rd       => RF_Rp_rd   ,
                           RF_Rq_rd       => RF_Rq_rd   ,
                           RF_Rp_zero     => RF_Rp_zero ,
                           alu_s          => alu_s,
                           RF_s           => RF_s,
                           R_data         => R_data     ,
                           W_data         => W_data     ,
                           clk            => clk        
                     );

D_memory:  memory port map(	clk => clk,
                           D_wr => D_wr,
                           D_rd => D_rd,
                           D_addr => D_addr, 
                           W_data => W_data,
                           R_data => R_data);
                           
I_memory: inst_memory port map(rd => rd,
                               addr => addr,
                               data => data);


end Behavioral;
