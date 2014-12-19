----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:40:12 12/19/2014 
-- Design Name: 
-- Module Name:    padder_FSM - Behavioral 
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

entity padder_FSM is
    Port ( rst : in  STD_LOGIC;
           start : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           ww : in  STD_LOGIC_VECTOR (2 downto 0);
			  clk : in  STD_LOGIC;
           en_wdec : out  STD_LOGIC;
           savebit_en : out  STD_LOGIC;
           pass_data : out  STD_LOGIC);
end padder_FSM;

architecture Behavioral of padder_FSM is

	type state_type is (idle, sm_stop, ww1_1, ww1_2, ww1_3, ww1_4, ww2_1, ww2_2, ww2_3, ww2_4,
						ww3_1, ww3_2, ww3_3, ww3_4, ww4_1, ww4_2, ww4_3, ww4_4);
	signal state, next_state : state_type;

begin

	SYNC_PROC: process (clk)
	begin
		if (clk'event and clk = '1') then
			if (rst = '1') then
				state <= idle;
			else
				state <= next_state;
			end if;        
		end if;
	end process;
 
   --MOORE State-Machine - Outputs based on state only
	OUTPUT_DECODE: process (state)
	begin
		--insert statements to decode internal output signals
		case (state) is
			when idle =>
				en_wdec <= 'X';
				savebit_en <= 'X';
				pass_data <= 'X';

			when ww1_1 =>
				en_wdec <= '1';
				savebit_en <= '1';
				pass_data <= 'X';

			when ww1_2 =>
				en_wdec <= '0';
				savebit_en <= '0';
				pass_data <= '0';

			when ww1_3 =>
				en_wdec <= '0';
				savebit_en <= '0';
				pass_data <= '0';

			when ww1_4 =>
				en_wdec <= '0';
				savebit_en <= '0';
				pass_data <= '0';

			when ww2_1 =>
				en_wdec <= '0';
				savebit_en <= 'X';
				pass_data <= '1';

			when ww2_2 =>
				en_wdec <= '1';
				savebit_en <= '1';
				pass_data <= 'X';

			when ww2_3 =>
				en_wdec <= '0';
				savebit_en <= '0';
				pass_data <= '0';

			when ww2_4 =>
				en_wdec <= '0';
				savebit_en <= '0';
				pass_data <= '0';

			when ww3_1 =>
				en_wdec <= '0';
				savebit_en <= 'X';
				pass_data <= '1';

			when ww3_2 =>
				en_wdec <= '0';
				savebit_en <= 'X';
				pass_data <= '1';

			when ww3_3 =>
				en_wdec <= '1';
				savebit_en <= '1';
				pass_data <= 'X';

			when ww3_4 =>
				en_wdec <= '0';
				savebit_en <= '0';
				pass_data <= '0';

			when ww4_1 =>
				en_wdec <= '0';
				savebit_en <= 'X';
				pass_data <= '1';

			when ww4_2 =>
				en_wdec <= '0';
				savebit_en <= 'X';
				pass_data <= '1';

			when ww4_3 =>
				en_wdec <= '0';
				savebit_en <= 'X';
				pass_data <= '1';

			when ww4_4 =>
				en_wdec <= '1';
				savebit_en <= 'X';
				pass_data <= 'X';

			when others =>	-- sm_stop
				en_wdec <= 'X';
				savebit_en <= 'X';
				pass_data <= 'X';
		end case;
	end process;

	NEXT_STATE_DECODE: process (state, start, stop, ww)
	begin
		--declare default state for next_state to avoid latches
		next_state <= state;  --default is to stay in current state
		--insert statements to decode next_state
		--below is a simple example
		case (state) is
			when idle =>
				case ww is
					when "001" =>
						next_state <= ww1_1;
					when "010" =>
						next_state <= ww2_1;
					when "011" =>
						next_state <= ww3_1;
					when others => -- ww = X"4"
						next_state <= ww4_1;
				end case;

			when ww1_1 =>
				next_state <= ww1_2;
			when ww1_2 =>
				next_state <= ww1_3;
			when ww1_3 =>
				next_state <= ww1_4;
			when ww1_4 =>
				next_state <= ww1_1;

			when ww2_1 =>
				next_state <= ww2_2;
			when ww2_2 =>
				next_state <= ww2_3;
			when ww2_3 =>
				next_state <= ww2_4;
			when ww2_4 =>
				next_state <= ww2_1;


			when ww3_1 =>
				next_state <= ww3_2;
			when ww3_2 =>
				next_state <= ww3_3;
			when ww3_3 =>
				next_state <= ww3_4;
			when ww3_4 =>
				next_state <= ww3_1;

			when ww4_1 =>
				next_state <= ww4_2;
			when ww4_2 =>
				next_state <= ww4_3;
			when ww4_3 =>
				next_state <= ww4_4;
			when ww4_4 =>
				next_state <= ww4_1;

			when others =>
				if start = '0' then
					next_state <= idle;
				end if;
		end case;

		if stop = '1' then
			next_state <= sm_stop;
		end if;
	end process;

end Behavioral;
