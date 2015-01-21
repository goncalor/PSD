----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:27:39 01/21/2015 
-- Design Name: 
-- Module Name:    o_am - Behavioral 
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

entity o_am is
	PORT(
		rst : in std_logic;
		clk : in std_logic;
		valid : in std_logic;
		ww : in std_logic_vector(1 downto 0);
		address : out std_logic_vector(8 downto 0)
	);
end o_am;

architecture Behavioral of o_am is
	COMPONENT addman
	PORT(
		reset : IN std_logic;
		clk : IN std_logic;
		offset : IN std_logic_vector(2 downto 0);          
		address : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;
	
	COMPONENT o_am_fsm
	PORT(
		valid : IN std_logic;
		ww : IN std_logic_vector(1 downto 0);
		clk : IN std_logic;
		rst : IN std_logic;          
		offset : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	signal offset : std_logic_vector(2 downto 0);
begin
	Inst_addman: addman PORT MAP(
		reset => not valid,
		clk => clk,
		offset => offset,
		address => address
	);
	Inst_o_am_fsm: o_am_fsm PORT MAP(
		valid => valid,
		ww => ww,
		clk => clk,
		rst => rst,
		offset => offset
	);

end Behavioral;

