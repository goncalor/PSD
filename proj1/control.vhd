----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:22:12 10/04/2014 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
	Port ( rst, clk : in  STD_LOGIC;
		l1 : in  STD_LOGIC;
		l2 : in  STD_LOGIC;
		op : in  STD_LOGIC;
		r1en : out  STD_LOGIC;
		r2en : out  STD_LOGIC;
		scntl : out STD_LOGIC
	);
end control;

architecture Behavioral of control is
	type fsm_states is ( s_initial, s_end, s_load1, s_load2, s_op );
	signal currstate, nextstate: fsm_states;
begin
	state_reg: process(clk, rst)
	begin
		if rst = '1' then
			currstate <= s_initial;
		elsif clk'event and clk = '1' then
			currstate <= nextstate;
		end if;
	end process;

	state_decision: process(l1, l2, op, currstate)
	begin
		nextstate <= currstate;		-- default: do not change state
		
		case currstate is
			when s_initial =>
				if l1 = '1' then
					nextstate <= s_load1;
				elsif l2 = '1' then 
					nextstate <= s_load2;
				elsif op = '1' then
					nextstate <= s_op;
				end if;
				scntl <= 'X'; -- Necessary so that scntl doesn't become a latch
				r1en <= '0';
				r2en <= '0';
	
			when s_end =>
				if(l1 = '0' and l2 = '0' and op = '0') then
					nextstate <= s_initial;
				end if;
				scntl <= 'X'; -- Necessary so that scntl doesn't become a latch
				r1en <= '0';
				r2en <= '0';

			when s_load1 =>
				nextstate <= s_end;
				scntl <= 'X';
				r1en <= '1';
				r2en <= '0';

			when s_load2 =>
				nextstate <= s_end;
				scntl <= '0'; -- mux from switches
				r1en <= '0';
				r2en <= '1';

			when s_op =>
				nextstate <= s_end;
				scntl <= '1';	-- mux from alu
				r1en <= '0';
				r2en <= '1';
		end case;
	end process;

end Behavioral;

