----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:59:05 10/04/2014 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
	Port ( a : in  STD_LOGIC_VECTOR (6 downto 0);
		b : in  STD_LOGIC_VECTOR (12 downto 0);
		inst : in  STD_LOGIC_VECTOR (2 downto 0);
		res : out  STD_LOGIC_VECTOR (12 downto 0));
end alu;

architecture Behavioral of alu is
	signal ct_a : STD_LOGIC_VECTOR (12 downto 0);
	signal ct_b : STD_LOGIC_VECTOR (12 downto 0);
	signal sum : STD_LOGIC_VECTOR (12 downto 0);
	signal product : STD_LOGIC_VECTOR (25 downto 0);
	signal short_product : STD_LOGIC_VECTOR (12 downto 0);
	signal shift : STD_LOGIC_VECTOR (12 downto 0);
	signal nored : STD_LOGIC_VECTOR (12 downto 0);
	signal mux_a : STD_LOGIC_VECTOR (12 downto 0);
	signal mux_b : STD_LOGIC_VECTOR (12 downto 0);
	signal sm_mux_a : STD_LOGIC_VECTOR (12 downto 0);
begin


	-- Conversion from signal-module notation to complement two:
	ct_a <= "000000" & a(6 downto 0) when a(6)='0' else (not ("0000000" & a(5 downto 0)) + 1);
	ct_b <= b(12 downto 0) when b(12)='0'else (not ("0" & b(11 downto 0)) + 1);
	
	
	-- Results of the various functional units:
	sum <= ct_b + ct_a when inst(0)='0' else ct_b - ct_a;
	product <= ct_b * ct_a;
	short_product <= product(25) & product(11 downto 0);
		-- Shift Right Arithmetic:
		-- The characteristic of a shift right arithmetic is the
		-- conservation of the signal, hence our option to keep that bit
		with a(2 downto 0) select
			shift <= b when "000",
				b(12) & "0" & b(11 downto 1) when "001",
				b(12) & "00" & b(11 downto 2) when "010",
				b(12) & "000" & b(11 downto 3) when "011",
				b(12) & "0000" & b(11 downto 4) when "100",
				b(12) & "00000" & b(11 downto 5) when "101",
				b(12) & "000000" & b(11 downto 6) when "110",
				b(12) & "0000000" & b(11 downto 7) when others;
			
		-- On the NOR gate, we chose to keep the signal bit in the
		-- beginning as well, for the sake of coherence
	nored <= (a(6) & "000000" & a(5 downto 0)) nor b(12 downto 0);
	
	
	-- First multiplexers:
	mux_a <= sum when inst(1)='0' else short_product;
	mux_b <= shift when inst(1)='0' else nored;
	
	
	-- Reconversion to signal-module notation of the adder/multiplier result
	sm_mux_a <= mux_a when mux_a(12)='0' else (not("0" & mux_a(11 downto 0)) + 1);
	
	-- Last multiplexer;
	res <= sm_mux_a when inst(2)='0' else mux_b;
end Behavioral;
