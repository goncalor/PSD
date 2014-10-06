----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:55:59 10/06/2014 
-- Design Name: 
-- Module Name:    circuit - Behavioral 
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

entity circuit is
	Port (
		clk : in  STD_LOGIC;
		buttons : in  STD_LOGIC_VECTOR (3 downto 0);
		switches : in  STD_LOGIC_VECTOR (7 downto 0);
		disp : out  STD_LOGIC_VECTOR (12 downto 0)
	);
end circuit;

architecture Behavioral of circuit is
	COMPONENT control
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		l1 : IN std_logic;
		l2 : IN std_logic;
		op : IN std_logic;          
		r1en : OUT std_logic;
		r2en : OUT std_logic;
		scntl : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT datapath
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		scntl : IN std_logic;
		wren1 : IN std_logic;
		wren2 : IN std_logic;
		ent : IN std_logic_vector(6 downto 0);          
		r1 : OUT std_logic_vector(6 downto 0);
		r2 : OUT std_logic_vector(12 downto 0)
		);
	END COMPONENT;
	
	signal r1en : STD_LOGIC;
	signal r2en : STD_LOGIC;
	signal scntl : STD_LOGIC;
	signal reg1 : STD_LOGIC_VECTOR(6 downto 0);
	signal reg2 : STD_LOGIC_VECTOR(12 downto 0);
begin
	ctrl_unit : control
	PORT MAP(
		rst => buttons(0),
		clk => clk,
		l1 => buttons(1),
		l2 => buttons(2),
		op => buttons(3),
		r1en => r1en,
		r2en => r2en,
		scntl => scntl
	);

	data_unit : datapath
	PORT MAP(
		rst => buttons(0),
		clk => clk,
		scntl => scntl,
		wren1 => r1en,
		wren2 => r2en,
		ent => switches(6 downto 0),
		r1 => reg1,
		r2 => reg2
	);
	
	disp <= reg2 when switches(7) = '0' else reg1(6) & "000000" & reg1(5 downto 0);
	
end Behavioral;
