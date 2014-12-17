----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:29:31 12/17/2014 
-- Design Name: 
-- Module Name:    SAVE_erosion - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SAVE_erosion is
	Port ( inputs_0 : in  STD_LOGIC_VECTOR (31 downto 0);
		inputs_1 : in  STD_LOGIC_VECTOR (31 downto 0);
		inputs_2 : in  STD_LOGIC_VECTOR (31 downto 0);
		output : out  STD_LOGIC_VECTOR (31 downto 0));
end SAVE_erosion;

architecture Behavioral of SAVE_erosion is

begin

LOGIC:
	for i in 0 to 31 generate
	begin
		output(i) <= inputs_0(i) and inputs_1(i) and inputs_2(i);
	end generate;
end Behavioral;

