--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:08:14 10/14/2014
-- Design Name:   
-- Module Name:   D:/Dropbox/Public/IST/PSD/labs/proj1/proj1/control_tb.vhd
-- Project Name:  proj1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: control
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
 
ENTITY control_tb IS
END control_tb;
 
ARCHITECTURE behavior OF control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         l1 : IN  std_logic;
         l2 : IN  std_logic;
         op : IN  std_logic;
         r1en : OUT  std_logic;
         r2en : OUT  std_logic;
         scntl : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal l1 : std_logic := '0';
   signal l2 : std_logic := '0';
   signal op : std_logic := '0';

 	--Outputs
   signal r1en : std_logic;
   signal r2en : std_logic;
   signal scntl : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;

	signal controls: std_logic_vector(2 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control PORT MAP (
          rst => rst,
          clk => clk,
          l1 => l1,
          l2 => l2,
          op => op,
          r1en => r1en,
          r2en => r2en,
          scntl => scntl
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
		rst <= '1' after 20 ns,
				'0' after 30 ns;

		controls <= "100" after 30 ns,
						"000" after 40 ns,
						"010" after 60 ns,
						"000" after 70 ns,
						"001" after 90 ns,
						"000" after 120 ns;

      wait;
   end process;

	l1 <= controls(2);
	l2 <= controls(1);
	op <= controls(0);

END;
