--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:52:43 12/19/2014
-- Design Name:   
-- Module Name:   D:/Dropbox/Public/IST/PSD/labs/proj3/proj3/padder_datapath_tb.vhd
-- Project Name:  proj3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: padder_datapath
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
 
ENTITY padder_datapath_tb IS
END padder_datapath_tb;
 
ARCHITECTURE behavior OF padder_datapath_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT padder_datapath
    PORT(
         data_in : IN  std_logic_vector(31 downto 0);
         width : IN  std_logic_vector(5 downto 0);
         en_wdec : IN  std_logic;
			pass_data: IN  std_logic;
         savebit_en : IN  std_logic;
         clk : IN  std_logic;
         data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(31 downto 0) := (others => '0');
   signal width : std_logic_vector(5 downto 0) := (others => '0');
   signal en_wdec : std_logic := '0';
	signal pass_data : std_logic := '0';
   signal savebit_en : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: padder_datapath PORT MAP (
          data_in => data_in,
          width => width,
          en_wdec => en_wdec,
			 pass_data => pass_data,
          savebit_en => savebit_en,
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

		-- should output X"FFFF0000"
		data_in <= X"FFFF0000" ;	-- has 16 1s, 16 0s
		width <= "010001" ;	--	width is 17
		en_wdec <= '1' ;
		pass_data <= 'X' ;
		savebit_en <= '1' ;

		-- should output X"FFFFFFFF"
		width <= "010000" after clk_period;	--	width is 16
		en_wdec <= '1' after clk_period;
		pass_data <= 'X' after clk_period;
		savebit_en <= '1' after clk_period;

		-- should output X"FFFFFFFF" because the previously extended bit was '1'
		width <= "010000" after 2*clk_period;
		en_wdec <= '0' after 2*clk_period;
		pass_data <= '0' after 2*clk_period;
		savebit_en <= '0' after 2*clk_period;

		-- pass data
		width <= "010000" after 3*clk_period;
		en_wdec <= '0' after 3*clk_period;
		pass_data <= '1' after 3*clk_period;
		savebit_en <= '0' after 3*clk_period;

      wait;
   end process;

END;
