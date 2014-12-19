--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:38:46 12/19/2014
-- Design Name:   
-- Module Name:   /home/raffitz/Documents/2014-2015/1º Semestre/Xilinx/proj3_aux7/circuit_tb.vhd
-- Project Name:  proj3_aux7
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
 
ENTITY circuit_tb IS
END circuit_tb;
 
ARCHITECTURE behavior OF circuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT circuit
    PORT(
         start : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         ww : IN  std_logic_vector(1 downto 0);
         op_type : IN  std_logic_vector(2 downto 0);
         data_in : IN  std_logic_vector(31 downto 0);
         height : IN  std_logic_vector(7 downto 0);
         out_sel : IN  std_logic;
         i_en : OUT  std_logic;
         i_address : OUT  std_logic_vector(8 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal start : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ww : std_logic_vector(1 downto 0) := (others => '0');
   signal op_type : std_logic_vector(2 downto 0) := (others => '0');
   signal data_in : std_logic_vector(31 downto 0) := (others => '0');
   signal height : std_logic_vector(7 downto 0) := (others => '0');
   signal out_sel : std_logic := '0';

 	--Outputs
   signal i_en : std_logic;
   signal i_address : std_logic_vector(8 downto 0);
   signal output : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuit PORT MAP (
          start => start,
          clk => clk,
          rst => rst,
          ww => ww,
          op_type => op_type,
          data_in => data_in,
          height => height,
          out_sel => out_sel,
          i_en => i_en,
          i_address => i_address,
          output => output
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
	rst <= '1' after 0*clk_period,
		'0' after 1*clk_period;
		
	start <= '1' after 1*clk_period;
	
	ww <= "01" after 0*clk_period;
	
	op_type <= "001" after 0*clk_period; --Dilation;
	
	height <= "00100000" after 0*clk_period;
	
	out_sel <= '1' after 0*clk_period;
	
	--Imagem de entrada:
	
	data_in <= X"00000000" after 2*clk_period,
		X"55555555" after 3*clk_period,
		X"00000000" after 4*clk_period,
		X"40000002" after 5*clk_period,
		X"00000000" after 6*clk_period,
		X"40000002" after 7*clk_period,
		X"00000000" after 8*clk_period,
		X"40000002" after 9*clk_period,
		X"00000000" after 10*clk_period,
		X"40000002" after 11*clk_period,
		X"00000000" after 12*clk_period,
		X"40000002" after 13*clk_period,
		X"00000000" after 14*clk_period,
		X"40000002" after 15*clk_period,
		X"00000000" after 16*clk_period,
		X"40000002" after 17*clk_period,
		X"00000000" after 18*clk_period,
		X"40000002" after 19*clk_period,
		X"00000000" after 20*clk_period,
		X"40000002" after 21*clk_period,
		X"00000000" after 22*clk_period,
		X"40000002" after 23*clk_period,
		X"00000000" after 24*clk_period,
		X"40000002" after 25*clk_period,
		X"00000000" after 26*clk_period,
		X"40000002" after 27*clk_period,
		X"00000000" after 28*clk_period,
		X"40000002" after 29*clk_period,
		X"00000000" after 30*clk_period,
		X"40000002" after 31*clk_period,
		X"55555555" after 32*clk_period,
		X"00000000" after 33*clk_period;
      wait;
   end process;

END;
