----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:23:13 12/17/2014 
-- Design Name: 
-- Module Name:    SAVE_dilation - Behavioral 
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

entity SAVE_dilation is
	Port ( inputs_0 : in  STD_LOGIC_VECTOR (31 downto 0);
		inputs_1 : in  STD_LOGIC_VECTOR (31 downto 0);
		inputs_2 : in  STD_LOGIC_VECTOR (31 downto 0);
		output : out  STD_LOGIC_VECTOR (31 downto 0));
end SAVE_dilation;

architecture Behavioral of SAVE_dilation is

begin

LOGIC:
	for i in 0 to 31 generate
	begin
		output(i) <= inputs_0(i) or inputs_1(i) or inputs_2(i);
	end generate;
end Behavioral;

