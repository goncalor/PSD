----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:19:49 12/19/2014 
-- Design Name: 
-- Module Name:    SAVE_circuit - Behavioral 
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

entity SAVE_circuit is
	PORT(
		clk : IN STD_LOGIC;
		stop : IN STD_LOGIC;
		data_in : IN std_logic_vector(31 downto 0);
	);
end SAVE_circuit;

architecture Behavioral of SAVE_circuit is
	COMPONENT SAVE_control
	PORT(
		stop : IN std_logic;
		start : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		final : IN std_logic;
		op_type : IN std_logic_vector(2 downto 0);          
		orw_old : OUT std_logic;
		orw_new : OUT std_logic;
		m_ort : OUT std_logic;
		c_ort : OUT std_logic;
		e_is : OUT std_logic;
		d_is : OUT std_logic;
		cfs : OUT std_logic;
		cs : OUT std_logic;
		ofs : OUT std_logic;
		os : OUT std_logic
		);
	END COMPONENT;
	COMPONENT SAVE_datapath
	PORT(
		clk : IN std_logic;
		orw_old : IN std_logic;
		orw_new : IN std_logic;
		m_ort : IN std_logic;
		c_ort : IN std_logic;
		e_is : IN std_logic;
		d_is : IN std_logic;
		cfs : IN std_logic;
		cs : IN std_logic;
		ofs : IN std_logic;
		os : IN std_logic;
		data_in : IN std_logic_vector(31 downto 0);
		original : IN std_logic_vector(31 downto 0);
		offset : IN std_logic_vector(1 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
begin

	SAVE_FSM: SAVE_control PORT MAP(
		stop => ,
		start => ,
		clk => clk,
		rst => ,
		final => ,
		op_type => ,
		orw_old => ,
		orw_new => ,
		m_ort => ,
		c_ort => ,
		e_is => ,
		d_is => ,
		cfs => ,
		cs => ,
		ofs => ,
		os => 
	);
	SAVE_D: SAVE_datapath PORT MAP(
		clk => clk,
		orw_old => ,
		orw_new => ,
		m_ort => ,
		c_ort => ,
		e_is => ,
		d_is => ,
		cfs => ,
		cs => ,
		ofs => ,
		os => ,
		data_in => ,
		original => ,
		offset => ,
		output => 
	);
end Behavioral;

