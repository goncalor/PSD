--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:32:28 10/04/2014
-- Design Name:   
-- Module Name:   /home/raffitz/Documents/2014-2015/1º Semestre/Xilinx/lab1_0/alu_test0_tb.vhd
-- Project Name:  lab1_0
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.ALL;
 
ENTITY alu_test0_tb IS
END alu_test0_tb;
 
ARCHITECTURE behavior OF alu_test0_tb IS 

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT alu
	PORT(
		a : IN  std_logic_vector(6 downto 0);
		b : IN  std_logic_vector(12 downto 0);
		inst : IN  std_logic_vector(2 downto 0);
		res : OUT  std_logic_vector(12 downto 0)
	);
	END COMPONENT;


	--Inputs
	signal a : std_logic_vector(6 downto 0) := (others => '0');
	signal b : std_logic_vector(12 downto 0) := (others => '0');
	signal inst : std_logic_vector(2 downto 0) := (others => '0');

	--Outputs
	signal res : std_logic_vector(12 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: alu PORT MAP (
		a => a,
		b => b,
		inst => inst,
		res => res
	);


	-- Stimulus process
	stim_proc: process
	begin		
		-- hold reset state for 100ms.
		wait for 200ns;

		-- insert stimulus here 
		
		-- a:
		a <= "0000000" after 30 ns,
			"1111111" after 60 ns,
			"0000000" after 90 ns,
			"1111111" after 120 ns,
			"0000010" after 150 ns;
		b <= "0000000000000" after 30 ns,
			"0000000000000" after 60 ns,
			"1111111111111" after 90 ns,
			"1111111111111" after 120 ns,
			"0000000000001" after 150 ns;
		inst <= "110" after 30 ns;
		wait;
	end process;

END;
