----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:07 12/12/2014 
-- Design Name: 
-- Module Name:    addman - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addman is
	Port ( reset : in  STD_LOGIC;
		clk : in STD_LOGIC;
		offset : in  STD_LOGIC_VECTOR (2 downto 0);
		address : out  STD_LOGIC_VECTOR (8 downto 0));
end addman;

architecture Behavioral of addman is
	COMPONENT reg
	GENERIC(
		nbits : integer);
	PORT(
		en : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		D : IN std_logic_vector(nbits-1 downto 0);          
		Q : OUT std_logic_vector(nbits-1 downto 0));
	END COMPONENT;
	
	signal en : STD_LOGIC;
	signal add_out : std_logic_vector(8 downto 0);
	signal current : std_logic_vector(8 downto 0);
begin
	en <= offset(0) or offset(1) or offset(2);
	counter : reg
	GENERIC MAP( nbits => 9 )
	PORT MAP(
		en => en,
		clk => clk,
		rst => reset,
		D => add_out,
		Q => current
	);
	
	add_out <= current + offset;
	
	address <= current;

end Behavioral;

