--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:40:15 01/20/2015
-- Design Name:   
-- Module Name:   /home/raffitz/Documents/2014-2015/1º Semestre/Xilinx/psd_pr3_1150/circuit_tb6.vhd
-- Project Name:  psd_pr3_1150
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
 
ENTITY circuit_tb6 IS
END circuit_tb6;
 
ARCHITECTURE behavior OF circuit_tb6 IS 
 
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
         valid : OUT  std_logic;
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
   signal valid : std_logic;
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
          valid => valid,
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
	
	ww <= "00" after 0*clk_period;
	
	op_type <= "011" after 0*clk_period; --Dilation + Erosion;
	
	height <= "00001010" after 0*clk_period;
	
	out_sel <= '0' after 0*clk_period;
	
	--Imagem de entrada:
	
	data_in <= X"00000000" after 2*clk_period,
		X"109043C0" after 3*clk_period,
		X"00000000" after 4*clk_period,
		X"3800078C" after 5*clk_period,--fim 1ª linha
		
		X"7CF9C000" after 6*clk_period,
		X"1098C240" after 7*clk_period,
		X"1FF0FFE0" after 8*clk_period,
		X"C600088C" after 9*clk_period,--fim 2ª linha
		
		X"44812000" after 10*clk_period,
		X"10954420" after 11*clk_period,
		X"20008001" after 12*clk_period,
		X"0000108C" after 13*clk_period,
		
		X"44811004" after 14*clk_period,
		X"10924420" after 15*clk_period,
		X"40008002" after 16*clk_period,
		X"0000208C" after 17*clk_period,
		
		X"7CF91008" after 18*clk_period,
		X"10904810" after 19*clk_period,
		X"20008002" after 20*clk_period,
		X"0000408C" after 21*clk_period,
		
		X"40091060" after 22*clk_period,
		X"10904BD0" after 23*clk_period,
		X"1FF8FF82" after 24*clk_period,
		X"00007E4C" after 25*clk_period,
		
		X"40091090" after 26*clk_period,
		X"10904810" after 27*clk_period,
		X"00048001" after 28*clk_period,
		X"0020804C" after 29*clk_period,
		
		X"400920E0" after 30*clk_period,
		X"10904810" after 31*clk_period,
		X"00028001" after 32*clk_period,
		X"0021004C" after 33*clk_period,
		
		X"40F9C080" after 34*clk_period,
		X"10904810" after 35*clk_period,
		X"00048000" after 36*clk_period,
		X"C1C20040" after 37*clk_period,
		
		X"00000070" after 38*clk_period,
		X"0F104810" after 39*clk_period,
		X"7FF8FFFC" after 40*clk_period,
		X"3E04004C" after 41*clk_period;
		


      wait;
   end process;

END;
