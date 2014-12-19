----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:53:34 12/19/2014 
-- Design Name: 
-- Module Name:    padder_circuit - Behavioral 
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

entity padder_circuit is
    Port ( rst : in  STD_LOGIC;
			start : in  STD_LOGIC;
			stop : in  STD_LOGIC;
			ww : in  STD_LOGIC_VECTOR (2 downto 0);
			data_in : in  STD_LOGIC_VECTOR (31 downto 0);
			width : in  STD_LOGIC_VECTOR (5 downto 0);
			clk : in STD_LOGIC;
			data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end padder_circuit;

architecture Behavioral of padder_circuit is

	COMPONENT padder_FSM
	PORT(
		rst : IN std_logic;
		start : IN std_logic;
		stop : IN std_logic;
		ww : IN std_logic_vector(2 downto 0);
		clk : IN std_logic;          
		en_wdec : OUT std_logic;
		savebit_en : OUT std_logic;
		pass_data : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT padder_datapath
	PORT(
		data_in : IN std_logic_vector(31 downto 0);
		width : IN std_logic_vector(5 downto 0);
		en_wdec : IN std_logic;
		pass_data : IN std_logic;
		savebit_en : IN std_logic;
		clk : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	signal en_wdec : STD_LOGIC;
	signal savebit_en : STD_LOGIC;
	signal pass_data : STD_LOGIC;

begin

	Inst_padder_FSM: padder_FSM PORT MAP(
		rst => rst,
		start => start,
		stop => stop,
		ww => ww,
		clk => clk,
		en_wdec => en_wdec,
		savebit_en => savebit_en,
		pass_data => pass_data
	);

	Inst_padder_datapath: padder_datapath PORT MAP(
		data_in => data_in,
		width => width,
		en_wdec => en_wdec,
		pass_data => pass_data,
		savebit_en => savebit_en,
		clk => clk,
		data_out => data_out
	);

end Behavioral;

