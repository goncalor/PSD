----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:23:37 10/04/2014 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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

entity datapath is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           scntl : in STD_LOGIC;
           wren1 : in STD_LOGIC;
           wren2 : in STD_LOGIC;
           ent : in  STD_LOGIC_VECTOR (6 downto 0);
           r1 : out  STD_LOGIC_VECTOR (6 downto 0);
           r2 : out  STD_LOGIC_VECTOR (12 downto 0));
end datapath;

architecture Behavioral of datapath is
	COMPONENT alu
		PORT(
			a : IN std_logic_vector(6 downto 0);
			b : IN std_logic_vector(12 downto 0);
			inst : IN std_logic_vector(2 downto 0);          
			res : OUT std_logic_vector(12 downto 0)
			);
	END COMPONENT;
	
	COMPONENT reg
		GENERIC(
			nbits : integer
			);
		PORT(
			en : IN std_logic;
			clk : IN std_logic;
			rst : IN std_logic;
			D : IN std_logic_vector(nbits-1 downto 0);          
			Q : OUT std_logic_vector(nbits-1 downto 0)
			);
	END COMPONENT;
	
	signal r1_output : STD_LOGIC_VECTOR (6 downto 0);
	signal r2_output : STD_LOGIC_VECTOR (12 downto 0);
	signal r2_source : STD_LOGIC_VECTOR (12 downto 0);
	signal alu_output : STD_LOGIC_VECTOR (12 downto 0);
begin
	-- First register instantiation:
	reg_r1 : reg
	generic map (
		nbits => 7
	)
	port map (
		en => wren1,
		clk => clk,
		rst => rst,
		D => ent,
		Q => r1_output
	);
	
	-- Second register instantiation:
	reg_r2 : reg
	generic map (
		nbits => 13
	)
	port map (
		en => wren2,
		clk => clk,
		rst => rst,
		D => r2_source,
		Q => r2_output
	);
	
	-- ALU instantiation:
	alu_inst : alu
	port map (
		a => r1_output,
		b => r2_output,
		inst => ent(2 downto 0),
		res => alu_output
	);
	
	-- r2 source multiplexer:
	r2_source <= ent(6) & "000000" & ent(5 downto 0) when scntl = '0' else alu_output;
	
	-- outputs:
	r1 <= r1_output;
	r2 <= r2_output;

end Behavioral;

