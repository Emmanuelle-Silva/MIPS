----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2022 05:45:02 PM
-- Design Name: 
-- Module Name: ALU_16bit - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_16bit is
  Port ( A : in std_logic_vector(15 downto 0);
         B : in std_logic_vector(15 downto 0);
         Y : out std_logic_vector(15 downto 0);
         s : in std_logic_vector(1 downto 0) );
end ALU_16bit;

architecture Behavioral of ALU_16bit is

begin
    with s select Y <=
        A+B when "01",
        A-B when "10",
        A when others;

end Behavioral;
