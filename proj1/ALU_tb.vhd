--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:41:52 10/03/2014
-- Design Name:   
-- Module Name:   C:/Users/PSD/vivalaespana/Lab1_0/ALU_test0_tb.vhd
-- Project Name:  Lab1_0
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_test0_tb IS
END ALU_test0_tb;
 
ARCHITECTURE behavior OF ALU_test0_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         a : IN  std_logic_vector(6 downto 0);
         b : IN  std_logic_vector(12 downto 0);
         inst : IN  std_logic_vector(2 downto 0);
			clk : IN std_logic;
         res : OUT  std_logic_vector(12 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(6 downto 0) := (others => '0');
   signal b : std_logic_vector(12 downto 0) := (others => '0');
   signal inst : std_logic_vector(2 downto 0) := (others => '0');
	signal clk : std_logic := '0';

 	--Outputs
   signal res : std_logic_vector(12 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          a => a,
          b => b,
          inst => inst,
			 clk => clk,
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		a <= "1111111" after 10 ns,
			"0000101" after 20 ns,
			"1000101" after 30 ns,
			"0000101" after 40 ns,
			"0000001" after 50 ns,
			"0000001" after 60 ns,
			"0000010" after 70 ns,
			"0000001" after 80 ns,
			"0000101" after 90 ns,
			"0111111" after 100 ns,
			"1111111" after 110 ns;
			
		b <= "0000000000100" after 10 ns,
			"0000000000101" after 20 ns,
			"0000000000110" after 30 ns,
			"1000000000011" after 40 ns,
			"0000000000111" after 50 ns,
			"0000000000011" after 60 ns,
			"0000000001111" after 70 ns,
			"0000000000010" after 80 ns,
			"0000001111111" after 90 ns,
			"0111111111111" after 100 ns,
			"0111111111111" after 110 ns;
			
		inst <= "010" after 10 ns,
			"000" after 20 ns,
			"001" after 30 ns,
			"001" after 40 ns,
			"100" after 50 ns,
			"100" after 60 ns,
			"100" after 70 ns,
			"011" after 80 ns,
			"010" after 90 ns,
			"010" after 100 ns,
			"010" after 110 ns;

      wait;
   end process;

END;
