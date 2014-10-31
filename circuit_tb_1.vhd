--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:57:35 10/31/2014
-- Design Name:   
-- Module Name:   /home/raffitz/Documents/2014-2015/1º Semestre/Xilinx/p2i2/circuit_tb_1.vhd
-- Project Name:  p2i2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: circuit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY circuit_tb_1 IS
END circuit_tb_1;
 
ARCHITECTURE behavior OF circuit_tb_1 IS 

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT circuit
	PORT(
		data_ready : IN  std_logic;
		clk : IN  std_logic;
		rst : IN  std_logic;
		a : IN  std_logic_vector(15 downto 0);
		b : IN  std_logic_vector(15 downto 0);
		c : IN  std_logic_vector(15 downto 0);
		d : IN  std_logic_vector(15 downto 0);
		e : IN  std_logic_vector(15 downto 0);
		f : IN  std_logic_vector(15 downto 0);
		g : IN  std_logic_vector(15 downto 0);
		h : IN  std_logic_vector(15 downto 0);
		i : IN  std_logic_vector(15 downto 0);
		out_ready : OUT  std_logic;
		res : OUT  std_logic_vector(47 downto 0)
	);
	END COMPONENT;


	--Inputs
	signal data_ready : std_logic := '0';
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal a : std_logic_vector(15 downto 0) := (others => '0');
	signal b : std_logic_vector(15 downto 0) := (others => '0');
	signal c : std_logic_vector(15 downto 0) := (others => '0');
	signal d : std_logic_vector(15 downto 0) := (others => '0');
	signal e : std_logic_vector(15 downto 0) := (others => '0');
	signal f : std_logic_vector(15 downto 0) := (others => '0');
	signal g : std_logic_vector(15 downto 0) := (others => '0');
	signal h : std_logic_vector(15 downto 0) := (others => '0');
	signal i : std_logic_vector(15 downto 0) := (others => '0');

	--Outputs
	signal out_ready : std_logic;
	signal res : std_logic_vector(47 downto 0);

	-- Clock period definitions
	constant clk_period : time := 15ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: circuit PORT MAP (
		data_ready => data_ready,
		clk => clk,
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
		out_ready => out_ready,
		res => res
	);

	-- Clock process definitions
	clk_process :process
		begin
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
		end process;


	-- Stimulus process
	stim_proc: process
	begin		
	-- hold reset state for 100ms.
	wait for 100ns;	

	wait for clk_period*10;

	a <= "0000000000000001" after 0 ns,
		"1111111111111111" after 10*clk_period;
	b <= "0000000000000000" after 0 ns,
		"0000000000000010" after 10*clk_period;
	c <= "0000000000000000" after 0 ns,
		"0000000000000011" after 10*clk_period;
	d <= "0000000000000000" after 0 ns,
		"1111111111111100" after 10*clk_period;
	e <= "0000000000000001" after 0 ns,
		"0000000000000101" after 10*clk_period;
	f <= "0000000000000000" after 0 ns,
		"0000000000000110" after 10*clk_period;
	g <= "0000000000000000" after 0 ns,
		"0000000000000111" after 10*clk_period;
	h <= "0000000000000000" after 0 ns,
		"0000000000001000" after 10*clk_period;
	i <= "0000000000000001" after 0 ns,
		"0000000000001001" after 10*clk_period;
	data_ready <= '1' after 1*clk_period,
		'0' after 10*clk_period,
		'1' after 11*clk_period,
		'0' after 350 ns;
	
	rst <= '0' after 0 ns,
		'1' after 350 ns;

	wait;
	end process;

END;
