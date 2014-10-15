--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:44 10/15/2014
-- Design Name:   
-- Module Name:   /home/raffitz/Documents/2014-2015/1º Semestre/Xilinx/p1vn/testcircuit_tb.vhd
-- Project Name:  p1vn
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
 
ENTITY testcircuit_tb IS
END testcircuit_tb;
 
ARCHITECTURE behavior OF testcircuit_tb IS 

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT circuit
	PORT(
		clk : IN  std_logic;
		buttons : IN  std_logic_vector(3 downto 0);
		switches : IN  std_logic_vector(7 downto 0);
		disp : OUT  std_logic_vector(12 downto 0)
	);
	END COMPONENT;


	--Inputs
	signal clk : std_logic := '0';
	signal buttons : std_logic_vector(3 downto 0) := (others => '0');
	signal switches : std_logic_vector(7 downto 0) := (others => '0');

	--Outputs
	signal disp : std_logic_vector(12 downto 0);

	-- Clock period definitions
	constant clk_period : time := 1us;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: circuit PORT MAP (
		clk => clk,
		buttons => buttons,
		switches => switches,
		disp => disp
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

		-- insert stimulus here 
		
		switches <= "01001000" after 0us,
			"01000001" after 5us,
			"0XXXX001" after 8us,
			"00000100" after 11us,
			"0XXXX01X" after 14us,
			"0XXXXXXX" after 17us;
		
		buttons <= "0001" after 0us,
			"0000" after 1us,
			"0100" after 3us,
			"0000" after 5us,
			"0010" after 6us,
			"0000" after 7us,
			"1000" after 9us,
			"0000" after 10us,
			"0010" after 12us,
			"0000" after 13us,
			"1000" after 15us,
			"0000" after 16us,
			"0001" after 18us,
			"0000" after 19us;
			
		wait;
	end process;

END;
