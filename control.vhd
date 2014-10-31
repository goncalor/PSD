----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:37 10/31/2014 
-- Design Name: 
-- Module Name:    control - Behavioral 
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

entity control is
	Port ( clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		data_ready : in  STD_LOGIC;
		m1_ctl : out  STD_LOGIC_VECTOR (1 downto 0);
		m2_ctl : out  STD_LOGIC_VECTOR (2 downto 0);
		as_ctl : out  STD_LOGIC;
		as_op : out  STD_LOGIC;
		en_a : out  STD_LOGIC;
		en_b : out  STD_LOGIC;
		en_c : out  STD_LOGIC;
		en_d : out  STD_LOGIC;
		out_ready : out  STD_LOGIC);
end control;

architecture Behavioral of control is
	type fsm_states is (s_initial, s_1, s_2, s_3, s_4, s_5, s_6, s_end);
	signal currstate, nextstate: fsm_states;
begin
	state_reg: process(clk,rst)
	begin
		if rst = '1' then
			currstate <= s_initial;
		elsif clk'event and clk = '1' then
			currstate <= nextstate;
		end if;
	end process;
	
	state_decision: process(data_ready,currstate)
	begin
		nextstate <= currstate;
		
		case currstate is
			when s_initial =>
				if data_ready = '1' then
					nextstate <= s_1;
				end if;
				m1_ctl <= "XX";
				m2_ctl <= "XXX";
				as_ctl <= 'X';
				as_op <= 'X';
				en_a <= 'X';
				en_b <= 'X';
				en_c <= 'X';
				en_d <= 'X';
				out_ready <= '0';
			when s_1 =>
				nextstate <= s_2;
				m1_ctl <= "00";
				m2_ctl <= "000";
				as_ctl <= 'X';
				as_op <= 'X';
				en_a <= '1';
				en_b <= '1';
				en_c <= 'X';
				en_d <= 'X';
				out_ready <= '0';
			when s_2 =>
				nextstate <= s_3;
				m1_ctl <= "01";
				m2_ctl <= "001";
				as_ctl <= '0';
				as_op <= '1';
				en_a <= '1';
				en_b <= '1';
				en_c <= '1';
				en_d <= 'X';
				out_ready <= '0';
			when s_3 =>
				nextstate <= s_4;
				m1_ctl <= "10";
				m2_ctl <= "010";
				as_ctl <= '0';
				as_op <= '1';
				en_a <= '1';
				en_b <= '1';
				en_c <= '0';
				en_d <= '1';
				out_ready <= '0';
			when s_4 =>
				nextstate <= s_5;
				m1_ctl <= "11";
				m2_ctl <= "011";
				as_ctl <= '0';
				as_op <= '1';
				en_a <= '1';
				en_b <= '1';
				en_c <= '1';
				en_d <= 'X';
				out_ready <= '0';
			when s_5 =>
				nextstate <= s_6;
				m1_ctl <= "XX";
				m2_ctl <= "111";
				as_ctl <= '0';
				as_op <= '0';
				en_a <= 'X';
				en_b <= '1';
				en_c <= '1';
				en_d <= 'X';
				out_ready <= '0';
			when s_6 =>
				nextstate <= s_end;
				m1_ctl <= "XX";
				m2_ctl <= "XXX";
				as_ctl <= '1';
				as_op <= '0';
				en_a <= 'X';
				en_b <= 'X';
				en_c <= '1';
				en_d <= 'X';
				out_ready <= '0';
			when s_end =>
				if data_ready = '0' then
					nextstate <= s_initial;
				end if;
				m1_ctl <= "XX";
				m2_ctl <= "XXX";
				as_ctl <= 'X';
				as_op <= 'X';
				en_a <= 'X';
				en_b <= 'X';
				en_c <= '0';
				en_d <= 'X';
				out_ready <= '1';
		end case;
	end process;
	
end Behavioral;

