----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2022 10:24:30 PM
-- Design Name: 
-- Module Name: control_unit_t - Behavioral
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

entity control_unit_t is
--  Port ( );
end control_unit_t;

architecture Behavioral of control_unit_t is

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

    signal clk :  STD_LOGIC;
    signal rst :  STD_LOGIC;
    --I memory
    signal data :  STD_LOGIC_VECTOR (15 downto 0);
    signal rd :  STD_LOGIC;
    signal addr:  STD_LOGIC_VECTOR (15 downto 0);
    
    --D memory
    signal D_addr :  STD_LOGIC_VECTOR (7 downto 0);
    signal D_rd :   STD_LOGIC;
    signal D_wr :   STD_LOGIC;
     
     --Datapah
     --Mux16Bits
    signal RF_W_data :  STD_LOGIC_VECTOR (7 downto 0);
    signal RF_s1 :      STD_LOGIC;
    signal RF_s0 :      STD_LOGIC;
     
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

begin

uut: control_unit port map( clk,
                            rst,   
                            data,
                            rd,
                            addr,
                            D_addr,
                            D_rd,
                            D_wr,
                            RF_W_data, 
                            RF_s1,   
                            RF_s0,   
                            RF_W_addr,
                            RF_W_wr, 
                            RF_Rp_addr,
                            RF_Rp_rd,
                            RF_Rq_addr,
                            RF_Rq_rd,
                            RF_Rp_zero,
                            alu_s1,
                            alu_s0);
                            
                            
generate_clock: process
begin
    clk <= '1';
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
end process;

stimulus: process
begin
    rst<= '1';   data<="0000000000000000"; RF_Rp_zero <= '0';
    wait for 10 ns;
    -- MOV R10, 0x03
    rst<= '0';   data<="0000101000000011"; RF_Rp_zero <= '0';
    wait for 30 ns;
    -- MOV 0x03, R10
    rst<= '0';   data<="0001101000000011"; RF_Rp_zero <= '0';
    wait for 30 ns;
    -- ADD R0, R1, R2
    rst<= '0';   data<="0010000000010010"; RF_Rp_zero <= '0';
    wait for 30 ns;
    -- MOV R2, #10
    rst<= '0';   data<="0011001000001010"; RF_Rp_zero <= '0';
    wait for 30 ns;
    -- SUB R0, R1, R2
    rst<= '0';   data<="0100000000010010"; RF_Rp_zero <= '0';
    wait for 30 ns;
    -- JMPZ R10, 0x0f
    rst<= '0';   data<="0101101000001111"; RF_Rp_zero <= '1';
    wait for 40 ns;
    
    wait;
end process;

            
end Behavioral; 
