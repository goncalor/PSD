----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:05 12/19/2014 
-- Design Name: 
-- Module Name:    circuit - Behavioral 
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

entity circuit is
	PORT(
		start : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		ww : IN std_logic_vector(1 downto 0);
		op_type : IN std_logic_vector(2 downto 0);
		data_in : IN std_logic_vector(31 downto 0);
		height : IN std_logic_vector(7 downto 0);
		out_sel : IN std_logic;
		i_en : out std_logic;
		i_address : OUT std_logic_vector(8 downto 0);
		valid : OUT std_logic;
		output : OUT std_logic_vector(31 downto 0)
	);
end circuit;

architecture Behavioral of circuit is
	COMPONENT HALF_circuit
	PORT(
		start : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		ww : IN std_logic_vector(1 downto 0);
		op_type : IN std_logic_vector(2 downto 0);
		data_in : IN std_logic_vector(31 downto 0);
		height : IN std_logic_vector(7 downto 0);
		out_sel : IN std_logic;
		stop : OUT std_logic;
		valid : OUT std_logic;
		i_en : OUT std_logic;
		f_os : OUT std_logic_vector(1 downto 0);
		i_address : OUT std_logic_vector(8 downto 0);
		output_func : OUT std_logic_vector(31 downto 0);
		output_orig : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT SAVE_circuit
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		stop : IN std_logic;
		start : IN std_logic;
		op_type : IN std_logic_vector(2 downto 0);
		data_in : IN std_logic_vector(31 downto 0);
		original : IN std_logic_vector(31 downto 0);
		offset : IN std_logic_vector(1 downto 0);
		ww : IN std_logic_vector(1 downto 0);
		valid : OUT std_logic;
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	signal stop : std_logic;
	signal offset : std_logic_vector(1 downto 0);
	signal data_HALF : std_logic_vector(31 downto 0);
	signal data_orig : std_logic_vector(31 downto 0);
	
	signal go_ahead : std_logic;
begin

	HALF: HALF_circuit PORT MAP(
		start => start,
		clk => clk,
		rst => rst,
		ww => ww,
		op_type => op_type,
		data_in => data_in,
		height => height,
		out_sel => out_sel,
		stop => stop,
		valid => go_ahead,
		i_en => i_en,
		f_os => offset,
		i_address => i_address,
		output_func => data_HALF,
		output_orig => data_orig
	);
	
	SAVE: SAVE_circuit PORT MAP(
		clk => clk,
		rst => rst,
		stop => stop,
		start => go_ahead,
		op_type => op_type,
		data_in => data_HALF,
		original => data_orig,
		offset => offset,
		ww => ww,
		valid => valid,
		output => output
	);
	
end Behavioral;

