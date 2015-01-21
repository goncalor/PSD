----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:23 12/19/2014 
-- Design Name: 
-- Module Name:    ww_calc - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ww_calc is
    Port ( width : in  STD_LOGIC_VECTOR (7 downto 0);
           ww : out  STD_LOGIC_VECTOR (1 downto 0));
end ww_calc;

architecture Behavioral of ww_calc is

begin

--	00000001
--	00011111
--	00100000		ww 1
--
--	00100001
--	00111111
--	01000000		ww 2
--	
--	01000001		
--	01011111		
--	01100000		ww 3
--	
--	01100001
--	01111111
--	10000000		ww 4

	ww <=
			"01" when (width(6 downto 5) = "00" or width = "00100000") else
			"10" when (width(6 downto 5) = "01" or width = "01000000") else
			"11" when (width(6 downto 5) = "10" or width = "01100000") else
			"00";

end Behavioral;
