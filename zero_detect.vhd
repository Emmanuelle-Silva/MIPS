----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2022 08:27:19 PM
-- Design Name: 
-- Module Name: zero_detect - Behavioral
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

entity zero_detect is
  Port ( A : in std_logic_vector(15 downto 0);
         Y : out std_logic );
end zero_detect;

architecture Behavioral of zero_detect is

begin
    Y <= not (A(0) or A(1) or A(2) or A(3) or A(4) or A(5) or A(6)
      or A(7) or A(8) or A(9) or A(10) or A(11) or A(12) or A(13)
      or A(14) or A(15));

end Behavioral;
