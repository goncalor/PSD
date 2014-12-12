----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:23:00 10/04/2014 
-- Design Name: 
-- Module Name:    register - Behavioral 
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

entity reg is
	generic ( nbits : integer := 8 );		-- default value of 8 bits
    Port ( en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (nbits-1 downto 0);
           Q : out  STD_LOGIC_VECTOR (nbits-1 downto 0));
end reg;

architecture Behavioral of reg is
begin
	process(clk, rst)
		begin
			if(rst = '1') then
				Q <= (others => '0');
			elsif(clk'event and clk = '1' and en = '1') then
				Q <= D;
		end if;
	end process;
end Behavioral;

