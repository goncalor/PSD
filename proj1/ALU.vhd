----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:39 10/03/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( a : in  STD_LOGIC_VECTOR (6 downto 0);
           b : in  STD_LOGIC_VECTOR (12 downto 0);
			  inst: in STD_LOGIC_VECTOR (2 downto 0);
			  clk : in STD_LOGIC;
           res : out  STD_LOGIC_VECTOR (12 downto 0));
end ALU;

architecture Behavioral of ALU is
	signal oper1,oper2: STD_LOGIC_VECTOR (12 downto 0);
	signal product: STD_LOGIC_VECTOR (25 downto 0);
	signal shift: STD_LOGIC_VECTOR (12 downto 0);
	signal preres: STD_LOGIC_VECTOR (12 downto 0);
begin
	oper1 <= "0000000" & a(5 downto 0) when a(6)='0' else not ("0000000" & a(5 downto 0)) + 1;
	oper2 <= "0" & b(11 downto 0) when b(12)='0' else not ("0" & b(11 downto 0)) + 1;
	product <= oper1 * oper2;
	with oper1(2 downto 0) select
		shift <= oper2 when "000",
				oper2(12) & oper2(12 downto 1) when "001",
				oper2(12) & oper2(12) & oper2(12 downto 2) when "010",
				oper2(12) & oper2(12) & oper2(12) & oper2(12 downto 3) when "011",
				oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12 downto 4) when "100",
				oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12 downto 5) when "101",
				oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12 downto 6) when "110",
				oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12) & oper2(12 downto 7) when others;
	with inst select
		preres <= oper1 + oper2								when "000", -- SUM
				oper1 - oper2									when "001", -- SUB
				product(25) & product(11 downto 0)		when "010", -- MUL
				oper1 nor oper2								when "011", -- NOR
				shift												when others; -- SHIFT
	
	res <= "0" & preres(11 downto 0) when preres(12)='0' else not("0" & preres(11 downto 0)) + 1;

end Behavioral;

