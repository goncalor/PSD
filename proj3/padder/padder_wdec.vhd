----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:16:12 12/05/2014 
-- Design Name: 
-- Module Name:    wdec - Behavioral 
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

entity wdec is
	Port ( width_minusone : in  STD_LOGIC_VECTOR (4 downto 0);
		en : in  STD_LOGIC;
		wdec_out : out  STD_LOGIC_VECTOR (31 downto 0));
end wdec;

architecture Behavioral of wdec is

	signal before_en : STD_LOGIC_VECTOR (31 downto 0);

begin
	with width_minusone select

	before_en <= X"80000000" when "00000",
				X"C0000000" when "00001",
				X"E0000000" when "00010",
				X"F0000000" when "00011",
				X"F8000000" when "00100",
				X"FC000000" when "00101",
				X"FE000000" when "00110",
				X"FF000000" when "00111",
				X"FF800000" when "01000",
				X"FFC00000" when "01001",
				X"FFE00000" when "01010",
				X"FFF00000" when "01011",
				X"FFF80000" when "01100",
				X"FFFC0000" when "01101",
				X"FFFE0000" when "01110",
				X"FFFF0000" when "01111",
				X"FFFF8000" when "10000",
				X"FFFFC000" when "10001",
				X"FFFFE000" when "10010",
				X"FFFFF000" when "10011",
				X"FFFFF800" when "10100",
				X"FFFFFC00" when "10101",
				X"FFFFFE00" when "10110",
				X"FFFFFF00" when "10111",
				X"FFFFFF80" when "11000",
				X"FFFFFFC0" when "11001",
				X"FFFFFFE0" when "11010",
				X"FFFFFFF0" when "11011",
				X"FFFFFFF8" when "11100",
				X"FFFFFFFC" when "11101",
				X"FFFFFFFE" when "11110",
				X"FFFFFFFF" when others;

	wdec_out <= before_en when en = '1' else X"FFFFFFFF";
		
end Behavioral;

