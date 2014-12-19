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
		op_type : in STD_LOGIC_VECTOR (2 downto 0);
		
		orw_old : out STD_LOGIC; -- Overwrite old word (for first words)
		m_ort : out STD_LOGIC; -- Overwrite type (if operation is dilation, 0, if erosion, 1, for instance)
		c_ort : out STD_LOGIC;
		e_is : out STD_LOGIC; -- E input select
		d_is : out STD_LOGIC; -- D input select
		cfs : out STD_LOGIC; -- Composite Operation Function block select
		cs : out STD_LOGIC; -- Composite block input select
		ofs : out STD_LOGIC; -- Output function select
		os : out STD_LOGIC;
		valid : out STD_LOGIC); -- Output select
end SAVE_control;

architecture Behavioral of SAVE_control is
	--Use descriptive names for the states, like st1_reset, st2_search
	type state_type is (sm_idle, first_line, normal, sm_stop); 
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
	OUTPUT_DECODE: process (state, op_type)
	begin
		case (state) is
			when sm_idle =>
				orw_old <= 'X';
				m_ort <= 'X';
				c_ort <= 'X';
				e_is <= 'X';
				d_is <= 'X';
				cfs <= 'X';
				cs <= 'X';
				ofs <= 'X';
				os <= 'X';
				valid <= '0';
			when first_line =>
				orw_old <= '1';
				valid <= '1';
				case (op_type) is
					when "000" => -- Erosion
						m_ort <= '1';
						c_ort <= 'X';
						e_is <= '0';
						d_is <= 'X';
						cfs <= 'X';
						cs <= 'X';
						ofs <= '0';
						os <= '0';
					when "001" => -- Dilation
						m_ort <= '0';
						c_ort <= 'X';
						e_is <= 'X';
						d_is <= '0';
						cfs <= 'X';
						cs <= 'X';
						ofs <= '1';
						os <= '0';
					when "010" => -- E + D
						m_ort <= '1';
						c_ort <= '0';
						e_is <= '0';
						d_is <= '1';
						cfs <= '0';
						cs <= '1';
						ofs <= '1';
						os <= '0';
					when "011" => -- D+E
						m_ort <= '0';
						c_ort <= '1';
						e_is <= '1';
						d_is <= '0';
						cfs <= '1';
						cs <= '1';
						ofs <= '0';
						os <= '0';
					when others => -- Edge find
						m_ort <= '1';
						c_ort <= 'X';
						e_is <= '0';
						d_is <= 'X';
						cfs <= 'X';
						cs <= '0';
						ofs <= 'X';
						os <= '1';
				end case;
			when normal =>
				orw_old <= '0';
				valid <= '1';
				case (op_type) is
					when "000" => -- Erosion
						m_ort <= '1';
						c_ort <= 'X';
						e_is <= '0';
						d_is <= 'X';
						cfs <= 'X';
						cs <= 'X';
						ofs <= '0';
						os <= '0';
					when "001" => -- Dilation
						m_ort <= '0';
						c_ort <= 'X';
						e_is <= 'X';
						d_is <= '0';
						cfs <= 'X';
						cs <= 'X';
						ofs <= '1';
						os <= '0';
					when "010" => -- E + D
						m_ort <= '1';
						c_ort <= '0';
						e_is <= '0';
						d_is <= '1';
						cfs <= '0';
						cs <= '1';
						ofs <= '1';
						os <= '0';
					when "011" => -- D+E
						m_ort <= '0';
						c_ort <= '1';
						e_is <= '1';
						d_is <= '0';
						cfs <= '1';
						cs <= '1';
						ofs <= '0';
						os <= '0';
					when others => -- Edge find
						m_ort <= '1';
						c_ort <= 'X';
						e_is <= '0';
						d_is <= 'X';
						cfs <= 'X';
						cs <= '0';
						ofs <= 'X';
						os <= '1';
				end case;
			when others =>
				orw_old <= 'X';
				m_ort <= 'X';
				c_ort <= 'X';
				e_is <= 'X';
				d_is <= 'X';
				cfs <= 'X';
				cs <= 'X';
				ofs <= 'X';
				os <= 'X';
				valid <= '0';
		end case;
	end process;
	
	NEXT_STATE_DECODE: process (state, start, stop)
	begin
	--declare default state for next_state to avoid latches
		next_state <= state;  --default is to stay in current state
		--insert statements to decode next_state
		--below is a simple example
		case (state) is
			when sm_idle =>
				if start = '1' then
					next_state <= first_line;
				end if;
			when first_line =>
				next_state <= normal;
				if stop = '1' then
					next_state <= sm_stop;
				end if;
			when normal =>
				next_state <= normal;
				if stop = '1' then
					next_state <= sm_stop;
				end if;
			when others =>
				if start = '0' then
					next_state <= sm_idle;
				end if;
		end case;      
	end process;
end Behavioral;

