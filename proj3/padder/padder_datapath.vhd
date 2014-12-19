----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:12:45 12/18/2014 
-- Design Name: 
-- Module Name:    padder_datapath - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity padder_datapath is
	Port ( data_in : in  STD_LOGIC_VECTOR (31 downto 0);
			width : in  STD_LOGIC_VECTOR (5 downto 0);
			en_wdec : in  STD_LOGIC;
			savebit_en : in  STD_LOGIC;
			clk : in  STD_LOGIC;
			data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end padder_datapath;

architecture Behavioral of padder_datapath is

	COMPONENT wdec
	PORT(
		width_minusone : IN std_logic_vector(4 downto 0);
		en : IN std_logic;          
		wdec_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	signal width_minusone : STD_LOGIC_VECTOR (4 downto 0);
	signal width_minusone_aux : STD_LOGIC_VECTOR (5 downto 0);
	signal wdec_out : STD_LOGIC_VECTOR (31 downto 0);
	signal extend_bit : STD_LOGIC;
	signal extend_bit_final : STD_LOGIC;
	signal bit_saver_out : STD_LOGIC;

begin

	width_minusone_aux <= (width - 1);
	width_minusone <= width_minusone_aux(4 downto 0);

	Inst_wdec: wdec PORT MAP(
		width_minusone => width_minusone,
		en => en_wdec,
		wdec_out => wdec_out
	);

	bit_saver:
	process (clk)
	begin
		if (clk'event and clk = '1' and savebit_en = '1') then
			bit_saver_out <= extend_bit;
		end if;
	end process;

	extend_bit <=
			data_in(31) when width_minusone = "00000" else
			data_in(30) when width_minusone = "00001" else
			data_in(29) when width_minusone = "00010" else
			data_in(28) when width_minusone = "00011" else
			data_in(27) when width_minusone = "00100" else
			data_in(26) when width_minusone = "00101" else
			data_in(25) when width_minusone = "00110" else
			data_in(24) when width_minusone = "00111" else
			data_in(23) when width_minusone = "01000" else
			data_in(22) when width_minusone = "01001" else
			data_in(21) when width_minusone = "01010" else
			data_in(20) when width_minusone = "01011" else
			data_in(19) when width_minusone = "01100" else
			data_in(18) when width_minusone = "01101" else
			data_in(17) when width_minusone = "01110" else
			data_in(16) when width_minusone = "01111" else
			data_in(15) when width_minusone = "10000" else
			data_in(14) when width_minusone = "10001" else
			data_in(13) when width_minusone = "10010" else
			data_in(12) when width_minusone = "10011" else
			data_in(11) when width_minusone = "10100" else
			data_in(10) when width_minusone = "10101" else
			 data_in(9) when width_minusone = "10110" else
			 data_in(8) when width_minusone = "10111" else
			 data_in(7) when width_minusone = "11000" else
			 data_in(6) when width_minusone = "11001" else
			 data_in(5) when width_minusone = "11010" else
			 data_in(4) when width_minusone = "11011" else
			 data_in(3) when width_minusone = "11100" else
			 data_in(2) when width_minusone = "11101" else
			 data_in(1) when width_minusone = "11110" else
			 data_in(0) when width_minusone = "11111" else
			 '1';

	extend_bit_final <= extend_bit when en_wdec = '1' else bit_saver_out;

	line_select:
	for i in 0 to 31 generate
		data_out(i) <= data_in(i) when wdec_out(i) = '1' else extend_bit_final;
	end generate;

end Behavioral;
