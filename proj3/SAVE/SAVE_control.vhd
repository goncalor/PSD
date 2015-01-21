----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:17 12/18/2014 
-- Design Name: 
-- Module Name:    SAVE_control - Behavioral 
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

entity SAVE_control is
	PORT(stop : in  STD_LOGIC;
		start : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		ww : in STD_LOGIC_VECTOR(1 downto 0);

		m_orw_old : out STD_LOGIC; -- Overwrite old word (for first words)
		valid : out STD_LOGIC);
end SAVE_control;

architecture Behavioral of SAVE_control is
	--Use descriptive names for the states, like st1_reset, st2_search
	type state_type is (sm_idle, wait1, wait2, wait3, wait4, first_line0, first_line1, first_line2, first_line3, normal, sm_stop); 
	signal state, next_state : state_type; 
begin

SYNC_PROC: process (clk)
	begin
		if (clk'event and clk = '1') then
			if (rst = '1') then
				state <= sm_idle;
			else
				state <= next_state;
			end if;
		end if;
	end process;

	--MOORE State-Machine - Outputs based on state only
	OUTPUT_DECODE: process (state)
	begin
		case (state) is
			when sm_idle =>
				m_orw_old <= 'X';
				valid <= '0';
			when first_line0 | first_line1 | first_line2 | first_line3 =>
				m_orw_old <= '1';
				valid <= '1';
			when normal =>
				m_orw_old <= '0';
				valid <= '1';
			when others =>	-- stop and wait1 ... wait4
				m_orw_old <= 'X';
				valid <= '0';
		end case;
	end process;
	
	NEXT_STATE_DECODE: process (state, start, stop, ww)
	begin
	--declare default state for next_state to avoid latches
		next_state <= state;  --default is to stay in current state
		--insert statements to decode next_state
		--below is a simple example
		case (state) is
			when sm_idle =>
				if start = '1' then
					case ww is
						when "01" => next_state <= wait1;
						when "10" => next_state <= wait2;
						when "11" => next_state <= wait3;
						when others => next_state <= wait4;
					end case;
				end if;
			when wait1 =>
				case ww is
					when "01" => next_state <= first_line3;
					when "10" => next_state <= first_line2;
					when "11" => next_state <= first_line1;
					when others => next_state <= first_line0;
				end case;
			when wait2 =>
				next_state <= wait1;
			when wait3 =>
				next_state <= wait2;
			when wait4 =>
				next_state <= wait3;

			when first_line0 =>
				next_state <= first_line1;
				if stop = '1' then
					next_state <= sm_stop;
				end if;
			when first_line1 =>
				next_state <= first_line2;
				if stop = '1' then
					next_state <= sm_stop;
				end if;
			when first_line2 =>
				next_state <= first_line3;
				if stop = '1' then
					next_state <= sm_stop;
				end if;
			when first_line3 =>
				next_state <= normal;
				if stop = '1' then
					next_state <= sm_stop;
				end if;

			when normal =>
				next_state <= normal;
				if stop = '1' then
					next_state <= sm_stop;
				end if;
			when others =>	-- sm_stop
				if start = '0' then
					next_state <= sm_idle;
				end if;
		end case;      
	end process;
end Behavioral;

