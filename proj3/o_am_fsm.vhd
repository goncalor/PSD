----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:11:48 01/21/2015 
-- Design Name: 
-- Module Name:    o_am_fsm - Behavioral 
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

entity o_am_fsm is
	PORT(
		valid : in std_logic;
		ww : in std_logic_vector(1 downto 0);
		clk : in std_logic;
		rst : in std_logic;
		offset : out std_logic_vector(2 downto 0)
	);
end o_am_fsm;

architecture Behavioral of o_am_fsm is
	type state_type is (s_idle,w1,w2,w3,w4,stop); 
	signal state, next_state : state_type; 
begin
	SYNC_PROC: process (clk)
	begin
		if (clk'event and clk = '1') then
			if (rst = '1') then
				state <= s_idle;
			else
				state <= next_state;
			end if;        
		end if;
	end process;


	OUTPUT_DECODE: process (state,ww)
	begin
		case (state) is
			when s_idle =>
				if ww = "01" then
					offset <= "100";
				else
					offset <= "001";
				end if;
			when w1 =>
				if ww = "01" then
					offset <= "100";
				else
					offset <= "001";
				end if;
			when w2 =>
				if ww = "10" then
					offset <= "011";
				else
					offset <= "001";
				end if;
			when w3 =>
				if ww = "11" then
					offset <= "010";
				else
					offset <= "001";
				end if;
			when w4 =>
				offset <= "001";
			when others =>
				offset <= "000";
		end case;
	end process;

	NEXT_STATE_DECODE: process (state, valid,ww)
	begin
	--declare default state for next_state to avoid latches
	next_state <= state;  --default is to stay in current state
	--insert statements to decode next_state
	--below is a simple example
		case (state) is
			when s_idle =>
				if valid = '1' then
					if ww = "01" then
						next_state <= w1;
					else
						next_state <= w2;
					end if;
				end if;
			when w1 =>
				if ww = "01" then
					next_state <= w1;
				else
					next_state <= w2;
				end if;
				if valid = '0' then
					next_state <= stop;
				end if;
			when w2 =>
				if ww = "10" then
					next_state <= w1;
				else
					next_state <= w3;
				end if;
				if valid = '0' then
					next_state <= stop;
				end if;
			when w3 =>
				if ww = "11" then
					next_state <= w1;
				else
					next_state <= w4;
				end if;
				if valid = '0' then
					next_state <= stop;
				end if;
			when w4 =>
				next_state <= w1;
				if valid = '0' then
					next_state <= stop;
				end if;
			when others =>
				next_state <= s_idle;
		end case;      
	end process;

end Behavioral;

