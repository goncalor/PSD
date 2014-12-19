--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:35:32 12/19/2014
-- Design Name:   
-- Module Name:   D:/Dropbox/Public/IST/PSD/labs/proj3/proj3/padder_circuit_tb.vhd
-- Project Name:  proj3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: padder_circuit
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
 
ENTITY padder_circuit_tb IS
END padder_circuit_tb;
 
ARCHITECTURE behavior OF padder_circuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT padder_circuit
    PORT(
         rst : IN  std_logic;
         start : IN  std_logic;
         stop : IN  std_logic;
         ww : IN  std_logic_vector(2 downto 0);
         data_in : IN  std_logic_vector(31 downto 0);
         width : IN  std_logic_vector(5 downto 0);
         clk : IN  std_logic;
         data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal start : std_logic := '0';
   signal stop : std_logic := '0';
   signal ww : std_logic_vector(2 downto 0) := (others => '0');
   signal data_in : std_logic_vector(31 downto 0) := (others => '0');
   signal width : std_logic_vector(5 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: padder_circuit PORT MAP (
			rst => rst,
			start => start,
			stop => stop,
			ww => ww,
			data_in => data_in,
			width => width,
			clk => clk,
			data_out => data_out
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
		rst <= '1';
		stop <= '0';

		rst <= '0' after clk_period;
		start <= '1' after clk_period;
		data_in <= X"FFFF0000" after clk_period;
		width <= "010000" after clk_period;
		ww <= "001" after clk_period;

		data_in <= X"FFFF0000" after 5*clk_period;
		width <= "010001" after 5*clk_period;
		ww <= "001" after 5*clk_period;

		rst <= '1' after 9*clk_period;
		rst <= '0' after 10*clk_period;

		data_in <= X"FFFF0000" after 10*clk_period;
		width <= "010000" after 10*clk_period;
		ww <= "010" after 10*clk_period;

		wait;
   end process;

END;
