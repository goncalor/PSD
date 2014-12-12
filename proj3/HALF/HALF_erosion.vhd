----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:21:17 12/12/2014 
-- Design Name: 
-- Module Name:    HALF_erosion - Behavioral 
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

entity HALF_erosion is
	Port ( data_in : in  STD_LOGIC_VECTOR (31 downto 0);
		carry_in : in  STD_LOGIC;
		carry_enable : in  STD_LOGIC;
		accumulator_in : in  STD_LOGIC;
		accumulator_enable : in STD_LOGIC;
		data_out : out  STD_LOGIC_VECTOR (31 downto 0);
		carry_out : out  STD_LOGIC);
end HALF_erosion;

architecture Behavioral of HALF_erosion is

begin

ANDGENERATE:
for i in 1 to 30 generate
	begin
		data_out(i) <= data_in(i-1) and data_in(i) and data_in(i+1);
	end generate;
	
data_out(31) <= (carry_in or (not carry_enable)) and data_in(31) and data_in(30);

data_out(0) <= (accumulator_in or (not accumulator_enable)) and data_in(1) and data_in(0);

carry_out <= data_in(0);


end Behavioral;

