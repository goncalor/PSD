--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:48:57 01/21/2015
-- Design Name:   
-- Module Name:   D:/Dropbox/Public/IST/PSD/labs/proj3/controlo_teste/controlo_tb1.vhd
-- Project Name:  controlo_teste
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controlo
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY controlo_tb1 IS
	END controlo_tb1;

ARCHITECTURE behavior OF controlo_tb1 IS 

-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT controlo
		PORT(
				switches : IN  std_logic_vector(7 downto 0);
				btn : IN  std_logic;
				valid : IN  std_logic;
				rst : IN  std_logic;
				clk : IN  std_logic;
				start : OUT  std_logic;
				width : OUT  std_logic_vector(7 downto 0);
				height : OUT  std_logic_vector(7 downto 0);
				op_type : OUT  std_logic_vector(2 downto 0)
			);
	END COMPONENT;


--Inputs
	signal switches : std_logic_vector(7 downto 0) := (others => '0');
	signal btn : std_logic := '0';
	signal valid : std_logic := '0';
	signal rst : std_logic := '0';
	signal clk : std_logic := '0';

--Outputs
	signal start : std_logic;
	signal width : std_logic_vector(7 downto 0);
	signal height : std_logic_vector(7 downto 0);
	signal op_type : std_logic_vector(2 downto 0);

-- Clock period definitions
	constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: controlo PORT MAP (
							   switches => switches,
							   btn => btn,
							   valid => valid,
							   rst => rst,
							   clk => clk,
							   start => start,
							   width => width,
							   height => height,
							   op_type => op_type
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
		-- hold reset state for 100 ns.
		wait for 100 ns;	

		wait for clk_period*10;

		-- insert stimulus here 
		rst <= '1',
			   '0' after 10 ns;

		btn <= '1' after 10 ns,
			   '0' after 30 ns,
			   '1' after 40 ns,
			   '0' after 50 ns,
			   '1' after 60 ns,
			   '0' after 70 ns, -- ready
			   '1' after 80 ns,
			   '0' after 200 ns;
-- start
		valid <= '0',
				 '1' after 90 ns,
				 '0' after 150 ns;

		wait;
	end process;

END;
