----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:52:41 12/17/2014 
-- Design Name: 
-- Module Name:    SAVE_storage_unit - Behavioral 
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

entity SAVE_storage_unit is
	Port ( data_in : in  STD_LOGIC_VECTOR (31 downto 0);
		clk : in STD_LOGIC;
		out_0 : out  STD_LOGIC_VECTOR (31 downto 0);
		out_1 : out  STD_LOGIC_VECTOR (31 downto 0);
		out_2 : out  STD_LOGIC_VECTOR (31 downto 0));
end SAVE_storage_unit;

architecture Behavioral of SAVE_storage_unit is
	signal it_1 : std_logic_vector (31 downto 0);
	signal it_2 : std_logic_vector (31 downto 0);
	signal it_3 : std_logic_vector (31 downto 0);
	signal it_4 : std_logic_vector (31 downto 0);
	signal it_5 : std_logic_vector (31 downto 0);
	signal it_6 : std_logic_vector (31 downto 0);
	signal it_7 : std_logic_vector (31 downto 0);
	signal it_8 : std_logic_vector (31 downto 0);
	signal it_9 : std_logic_vector (31 downto 0);
begin
	REGISTERS_PROC: process (clk)
	begin
		if (clk'event and clk = '1') then
			it_9 <= it_8;
			it_8 <= it_7;
			it_7 <= it_6;
			it_6 <= it_5;
			it_5 <= it_4;
			it_4 <= it_3;
			it_3 <= it_2;
			it_2 <= it_1;
			it_1 <= data_in;
		end if;
	end process;
	
	out_2 <= it_9;
	out_1 <= it_5;
	out_0 <= it_1;
end Behavioral;

