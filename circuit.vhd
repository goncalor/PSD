----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:46:36 10/31/2014 
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
	Port ( data_ready : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		a : in  STD_LOGIC_VECTOR (15 downto 0);
		b : in  STD_LOGIC_VECTOR (15 downto 0);
		c : in  STD_LOGIC_VECTOR (15 downto 0);
		d : in  STD_LOGIC_VECTOR (15 downto 0);
		e : in  STD_LOGIC_VECTOR (15 downto 0);
		f : in  STD_LOGIC_VECTOR (15 downto 0);
		g : in  STD_LOGIC_VECTOR (15 downto 0);
		h : in  STD_LOGIC_VECTOR (15 downto 0);
		i : in  STD_LOGIC_VECTOR (15 downto 0);
		out_ready : out STD_LOGIC;
		res : out  STD_LOGIC_VECTOR (47 downto 0));
end circuit;

architecture Behavioral of circuit is
	COMPONENT control
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		data_ready : IN std_logic;          
		m1_ctl : OUT std_logic_vector(1 downto 0);
		m2_ctl : OUT std_logic_vector(2 downto 0);
		as_ctl : OUT std_logic;
		as_op : OUT std_logic;
		en_a : OUT std_logic;
		en_b : OUT std_logic;
		en_c : OUT std_logic;
		en_d : OUT std_logic;
		out_ready : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT datapath
	PORT(
		clk : IN std_logic;
		m1_ctl : IN std_logic_vector(1 downto 0);
		m2_ctl : IN std_logic_vector(2 downto 0);
		as_ctl : IN std_logic;
		as_op : IN std_logic;
		en_a : IN std_logic;
		en_b : IN std_logic;
		en_c : IN std_logic;
		en_d : IN std_logic;
		rst : IN std_logic;
		a : IN std_logic_vector(15 downto 0);
		b : IN std_logic_vector(15 downto 0);
		c : IN std_logic_vector(15 downto 0);
		d : IN std_logic_vector(15 downto 0);
		e : IN std_logic_vector(15 downto 0);
		f : IN std_logic_vector(15 downto 0);
		g : IN std_logic_vector(15 downto 0);
		h : IN std_logic_vector(15 downto 0);
		i : IN std_logic_vector(15 downto 0);          
		res : OUT std_logic_vector(47 downto 0)
		);
	END COMPONENT;
	
	signal m1_ctl : std_logic_vector(1 downto 0);
	signal m2_ctl : std_logic_vector(2 downto 0);
	signal as_ctl : std_logic;
	signal as_op : std_logic;
	signal en_a : std_logic;
	signal en_b : std_logic;
	signal en_c : std_logic;
	signal en_d : std_logic;
begin
	Inst_control: control PORT MAP(
		clk => clk,
		rst => rst,
		data_ready => data_ready,
		m1_ctl => m1_ctl,
		m2_ctl => m2_ctl,
		as_ctl => as_ctl,
		as_op => as_op,
		en_a => en_a,
		en_b => en_b,
		en_c => en_c,
		en_d => en_d,
		out_ready => out_ready
	);
	Inst_datapath: datapath PORT MAP(
		clk => clk,
		m1_ctl => m1_ctl,
		m2_ctl => m2_ctl,
		as_ctl => as_ctl,
		as_op => as_op,
		en_a => en_a,
		en_b => en_b,
		en_c => en_c,
		en_d => en_d,
		rst => rst,
		a => a,
		b => b,
		c => c,
		d => d,
		e => e,
		f => f,
		g => g,
		h => h,
		i => i,
		res => res
	);
end Behavioral;

