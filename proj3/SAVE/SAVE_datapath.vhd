----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:52:22 12/18/2014 
-- Design Name: 
-- Module Name:    SAVE_datapath - Behavioral 
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

entity SAVE_datapath is
	Port( clk : in STD_LOGIC;
		orw_old : in STD_LOGIC;
		orw_new : in STD_LOGIC;
		m_ort : in STD_LOGIC;
		c_ort : in STD_LOGIC;
		e_is : in STD_LOGIC;
		d_is : in STD_LOGIC;
		cfs : in STD_LOGIC;
		cs : in STD_LOGIC;
		ofs : in STD_LOGIC;
		os : in STD_LOGIC;
		data_in : in STD_LOGIC_VECTOR(31 downto 0);
		original : in STD_LOGIC_VECTOR(31 downto 0);
		output: out STD_LOGIC_VECTOR(31 downto 0)
	);
end SAVE_datapath;

architecture Behavioral of SAVE_datapath is
	COMPONENT SAVE_storage_unit
	PORT(
		data_in : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;          
		out_0 : OUT std_logic_vector(31 downto 0);
		out_1 : OUT std_logic_vector(31 downto 0);
		out_2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT SAVE_erosion
	PORT(
		inputs_0 : IN std_logic_vector(31 downto 0);
		inputs_1 : IN std_logic_vector(31 downto 0);
		inputs_2 : IN std_logic_vector(31 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT SAVE_dilation
	PORT(
		inputs_0 : IN std_logic_vector(31 downto 0);
		inputs_1 : IN std_logic_vector(31 downto 0);
		inputs_2 : IN std_logic_vector(31 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT SAVE_subtract
	PORT(
		input_a : IN std_logic_vector(31 downto 0);
		input_b : IN std_logic_vector(31 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	signal m_override : std_logic_vector(31 downto 0);
	signal c_override : std_logic_vector(31 downto 0);
	signal su_m_old : std_logic_vector(31 downto 0);
	signal su_m_cur : std_logic_vector(31 downto 0);
	signal su_m_new : std_logic_vector(31 downto 0);
	signal su_c_old : std_logic_vector(31 downto 0);
	signal su_c_cur : std_logic_vector(31 downto 0);
	signal su_c_new : std_logic_vector(31 downto 0);
	signal m_old : std_logic_vector(31 downto 0);
	signal m_new : std_logic_vector(31 downto 0);
	signal c_old : std_logic_vector(31 downto 0);
	signal c_new : std_logic_vector(31 downto 0);
	
	signal e_in_old : std_logic_vector(31 downto 0);
	signal e_in_cur : std_logic_vector(31 downto 0);
	signal e_in_new : std_logic_vector(31 downto 0);
	signal d_in_old : std_logic_vector(31 downto 0);
	signal d_in_cur : std_logic_vector(31 downto 0);
	signal d_in_new : std_logic_vector(31 downto 0);
	
	signal e_out : std_logic_vector(31 downto 0);
	signal d_out : std_logic_vector(31 downto 0);
	
	signal cfin : std_logic_vector(31 downto 0);
	signal su_c_in : std_logic_vector(31 downto 0);
	
	signal s_out : std_logic_vector(31 downto 0);
	signal f_out : std_logic_vector(31 downto 0);
	
begin
	SU_main: SAVE_storage_unit PORT MAP(
		data_in => data_in,
		clk => clk,
		out_0 => su_m_new,
		out_1 => su_m_cur,
		out_2 => su_m_old
	);
	SU_composite: SAVE_storage_unit PORT MAP(
		data_in => su_c_in,
		clk => clk,
		out_0 => su_c_new,
		out_1 => su_c_cur,
		out_2 => su_c_old
	);
	
	m_override <= X"FFFFFFFF" when m_ort = '1' else X"00000000";
	c_override <= X"FFFFFFFF" when c_ort = '1' else X"00000000";
	m_old <= m_override when orw_old = '1' else su_m_old;
	m_new <= m_override when orw_new = '1' else su_m_new;
	c_old <= c_override when orw_old = '1' else su_c_old;
	c_new <= c_override when orw_new = '1' else su_c_new;
	
	e_in_new <= c_new when e_is = '1' else m_new;
	e_in_old <= c_old when e_is = '1' else m_old;
	e_in_cur <= su_c_cur when e_is = '1' else su_m_cur;
	
	d_in_new <= c_new when d_is = '1' else m_new;
	d_in_old <= c_old when d_is = '1' else m_old;
	d_in_cur <= su_c_cur when d_is = '1' else su_m_cur;
	
	cfin <= d_out when cfs = '1' else e_out;
	su_c_in <= cfin when cs = '1' else original;
	
	E_block: SAVE_erosion PORT MAP(
		inputs_0 => e_in_new,
		inputs_1 => e_in_cur,
		inputs_2 => e_in_old,
		output => e_out
	);
	D_block: SAVE_dilation PORT MAP(
		inputs_0 => d_in_new,
		inputs_1 => d_in_cur,
		inputs_2 => d_in_old,
		output => d_out
	);
	
	f_out <= d_out when ofs = '1' else e_out;
	
	S_block: SAVE_subtract PORT MAP(
		input_a => e_out,
		input_b => su_c_cur,
		output => s_out
	);
	
	output <= s_out when os = '1' else f_out;

end Behavioral;

