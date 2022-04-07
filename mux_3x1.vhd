----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2022 08:26:46 PM
-- Design Name: 
-- Module Name: memory - Behavioral
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

entity mux_3x1 is
  Port ( A0: in std_logic_vector(15 downto 0);
         A1: in std_logic_vector(15 downto 0);
         A2: in std_logic_vector(15 downto 0);
         Y: out std_logic_vector(15 downto 0);
         s : in std_logic_vector(1 downto 0) );
end mux_3x1;

architecture Behavioral of mux_3x1 is

begin
    with s select Y <= 
        A0 when "00",
        A1 when "01",
        A2 when "10",
        "0000000000000000" when others; 

end Behavioral;
