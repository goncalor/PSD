----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:12:54 12/12/2014 
-- Design Name: 
-- Module Name:    HALF_control - Behavioral 
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

entity HALF_control is
	Port ( stop : in  STD_LOGIC;
		start : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		ww : in STD_LOGIC_VECTOR (1 downto 0);
		op_type : in STD_LOGIC_VECTOR (2 downto 0);
		valid_o : out STD_LOGIC;
		mux_e : out  STD_LOGIC;
		mux_d : out  STD_LOGIC;
		e_carry_en : out  STD_LOGIC;
		d_carry_en : out  STD_LOGIC;
		e_acc_en : out  STD_LOGIC;
		d_acc_en : out  STD_LOGIC;
		e_delay : out STD_LOGIC;
		d_delay : out STD_LOGIC;
		i_rs : out  STD_LOGIC;
		i_en : out  STD_LOGIC;
		i_os : out  STD_LOGIC_VECTOR (2 downto 0));
end HALF_control;

architecture Behavioral of HALF_control is
	--Insert the following in the architecture before the begin keyword
	--Use descriptive names for the states, like st1_reset, st2_search
	type state_type is (sm_idle, read1_1, read2_1, read2_2, read3_1, read3_2, read3_3, read4_1, read4_2, read4_3, read4_4, sm_stop); 
	signal state, next_state : state_type; 
	
	signal valid : STD_LOGIC;
	
	signal valid_1 : STD_LOGIC;
	signal valid_2 : STD_LOGIC;
	signal valid_3 : STD_LOGIC;
	signal valid_f : STD_LOGIC;
	
begin
	
	valid_f <= valid_3 when op_type(2 downto 1) = "01" else valid_1;
	valid_o <= valid_f;
	
	SYNC_PROC: process (clk)
	begin
		if (clk'event and clk = '1') then
			-- FSM state ctrl:
			if (rst = '1') then
				state <= sm_idle;
			else
				state <= next_state;
			end if;
			
			-- Registers:
			valid_3 <= valid_2;
			valid_2 <= valid_1;
			valid_1 <= valid;
			
		end if;
	end process;

	--MOORE State-Machine - Outputs based on state only
	OUTPUT_DECODE: process (state, op_type)
	begin
	--insert statements to decode internal output signals
	--below is simple example
		case (state) is
			when sm_idle =>
				valid <= '0';
				mux_e <= 'X';
				mux_d <= 'X';
				e_carry_en <= 'X';
				d_carry_en <= 'X';
				e_acc_en <= 'X';
				d_acc_en <= 'X';
				e_delay <= 'X';
				d_delay <= 'X';
				i_rs <= '1';
				i_en <= '0';
				i_os <= "XXX";
			when read1_1 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '0';
						d_carry_en <= 'X';
						e_acc_en <= '0';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "100";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '0';
						e_acc_en <= 'X';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "100";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "100";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "100";
					when others => --> Edge find (E - O):
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "100";
				end case;
			when read2_1 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '0';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '0';
						e_acc_en <= 'X';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
				end case;
			when read2_2 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '0';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "011";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '1';
						e_acc_en <= 'X';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "011";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "011";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "011";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '0';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "011";
				end case;
			when read3_1 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '0';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '0';
						e_acc_en <= 'X';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
				end case;
			when read3_2 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '1';
						e_acc_en <= 'X';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
				end case;
			when read3_3 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '0';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "010";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '1';
						e_acc_en <= 'X';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "010";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "010";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "010";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '0';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "010";
				end case;
			when read4_1 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '0';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '0';
						e_acc_en <= 'X';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= '0';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '0';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
				end case;
			when read4_2 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '1';
						e_acc_en <= 'X';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
				end case;
			when read4_3 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '1';
						e_acc_en <= 'X';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '1';
						d_acc_en <= '1';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '1';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
				end case;
			when read4_4 =>
				valid <= '1';
				case (op_type) is
					when "000" => --> Erosion
						mux_e <= '0';
						mux_d <= 'X';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '0';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "001" => --> Dilation
						mux_e <= 'X';
						mux_d <= '0';
						e_carry_en <= 'X';
						d_carry_en <= '1';
						e_acc_en <= 'X';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "010" => --> E+D
						mux_e <= '0';
						mux_d <= '1';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '0';
						d_delay <= '1';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when "011" => --> D+E
						mux_e <= '1';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= '1';
						e_acc_en <= '0';
						d_acc_en <= '0';
						e_delay <= '1';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
					when others => --> Edge find:
						mux_e <= '0';
						mux_d <= '0';
						e_carry_en <= '1';
						d_carry_en <= 'X';
						e_acc_en <= '0';
						d_acc_en <= 'X';
						e_delay <= '0';
						d_delay <= '0';
						i_rs <= '0';
						i_en <= '1';
						i_os <= "001";
				end case;
			when others => -- Stop
				valid <= '0';
				mux_e <= 'X';
				mux_d <= 'X';
				e_carry_en <= 'X';
				d_carry_en <= 'X';
				e_acc_en <= 'X';
				d_acc_en <= 'X';
				e_delay <= 'X';
				d_delay <= 'X';
				i_rs <= 'X';
				i_en <= '0';
				i_os <= "XXX";
		end case;
	end process;

	NEXT_STATE_DECODE: process (state, stop, start, ww)
	begin
		--declare default state for next_state to avoid latches
		next_state <= state;  --default is to stay in current state
		--insert statements to decode next_state
		--below is a simple example
		case (state) is
			when sm_idle =>
				case (ww) is
					when "01" =>
						next_state <= read1_1;
					when "10" =>
						next_state <= read2_1;
					when "11" =>
						next_state <= read3_1;
					when others =>
						next_state <= read4_1;
				end case;
			when read1_1 =>
				
			when read2_1 =>
				next_state <= read2_2;
			when read2_2 =>
				next_state <= read2_1;
			when read3_1 =>
				next_state <= read3_2;
			when read3_2 =>
				next_state <= read3_3;
			when read3_3 =>
				next_state <= read3_1;
			when read4_1 =>
				next_state <= read4_2;
			when read4_2 =>
				next_state <= read4_3;
			when read4_3 =>
				next_state <= read4_4;
			when read4_4 =>
				next_state <= read4_1;
			when others =>
				if start = '0' then
					next_state <= sm_idle;
				end if;
		end case;
		if stop = '1' then
			next_state <= sm_stop;
		end if;
	end process;

end Behavioral;


