----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:05:23 10/07/2014 
-- Design Name: 
-- Module Name:    fpga - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fpga is
    Port ( mclk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           led : out  STD_LOGIC_VECTOR (7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dp : out  STD_LOGIC);
end fpga;

architecture Behavioral of fpga is
	COMPONENT circuit
	PORT(
		clk : IN std_logic;
		buttons : IN std_logic_vector(3 downto 0);
		switches : IN std_logic_vector(7 downto 0);          
		disp : OUT std_logic_vector(12 downto 0)
		);
	END COMPONENT;

	COMPONENT clkdiv
	PORT(
		clk : IN std_logic;          
		clk50M : OUT std_logic;
		clk10Hz : OUT std_logic;
		clk_disp : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT disp7
	PORT(
		disp4 : IN std_logic_vector(3 downto 0);
		disp3 : IN std_logic_vector(3 downto 0);
		disp2 : IN std_logic_vector(3 downto 0);
		disp1 : IN std_logic_vector(3 downto 0);
		clk : IN std_logic;
		aceso : IN std_logic_vector(4 downto 1);          
		en_disp : OUT std_logic_vector(4 downto 1);
		segm : OUT std_logic_vector(7 downto 1);
		dp : OUT std_logic
		);
	END COMPONENT;

	signal clk50M, clk10Hz, clk_disp : std_logic;
	signal pre_disp: std_logic_vector(12 downto 0);
	signal disp: std_logic_vector(15 downto 0);

begin
	Inst_circuit: circuit PORT MAP(
		clk => clk10Hz,
		buttons => btn,
		switches => sw,
		disp => pre_disp
	);
	
	disp <= "000" & pre_disp;	-- hm... signal bit will be 0 or 1 like this
	
	Inst_clkdiv: clkdiv PORT MAP(
		clk => mclk,
		clk50M => clk50M,
		clk10Hz => clk10Hz,
		clk_disp => clk_disp
	);

	Inst_disp7: disp7 PORT MAP(
		disp4 => disp(15 downto 12),
		disp3 => disp(11 downto 8),
		disp2 => disp(7 downto 4),
		disp1 => disp(3 downto 0),
		clk => clk_disp,
		aceso => "1111",
		en_disp => an,
		segm => seg,
		dp => dp
	);

	led <= sw;

end Behavioral;

