----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:53:46 12/16/2014 
-- Design Name: 
-- Module Name:    HALF_circuit - Behavioral 
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

entity HALF_circuit is
	Port (start : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		ww : in STD_LOGIC_VECTOR (1 downto 0);
		op_type : in STD_LOGIC_VECTOR (2 downto 0);
		data_in : in  STD_LOGIC_VECTOR (31 downto 0);
		height : in std_logic_vector(7 downto 0);
		out_sel : in STD_LOGIC;
		stop : out STD_LOGIC;
		i_en : out  STD_LOGIC;
		f_os : out  STD_LOGIC_VECTOR (1 downto 0);
		i_address : out STD_LOGIC_VECTOR(8 downto 0);
		output_func : out  STD_LOGIC_VECTOR (31 downto 0);
		output_orig : out  STD_LOGIC_VECTOR (31 downto 0));
end HALF_circuit;

architecture Behavioral of HALF_circuit is
	COMPONENT HALF_datapath
	PORT(
		data_in : IN std_logic_vector(31 downto 0);
		mux_e : IN std_logic;
		mux_d : IN std_logic;
		e_carry_en : IN std_logic;
		d_carry_en : IN std_logic;
		e_acc_en : IN std_logic;
		d_acc_en : IN std_logic;
		clk : IN std_logic;
		height : IN std_logic_vector(7 downto 0);
		out_sel : IN std_logic;
		e_delay : IN std_logic;
		d_delay : IN std_logic;
		i_rs : IN std_logic;
		i_os : IN std_logic_vector(2 downto 0);          
		stop : OUT std_logic;
		i_address : OUT std_logic_vector(8 downto 0);
		output_func : OUT std_logic_vector(31 downto 0);
		output_orig : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT HALF_control
	PORT(
		stop : IN std_logic;
		start : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		ww : IN std_logic_vector(1 downto 0);
		op_type : IN std_logic_vector(2 downto 0);          
		mux_e : OUT std_logic;
		mux_d : OUT std_logic;
		e_carry_en : OUT std_logic;
		d_carry_en : OUT std_logic;
		e_acc_en : OUT std_logic;
		d_acc_en : OUT std_logic;
		e_delay : OUT std_logic;
		d_delay : OUT std_logic;
		i_rs : OUT std_logic;
		i_en : OUT std_logic;
		i_os : OUT std_logic_vector(2 downto 0);
		f_os : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
	signal mux_e : STD_LOGIC;
	signal mux_d : STD_LOGIC;
	signal e_carry_en : STD_LOGIC;
	signal d_carry_en : STD_LOGIC;
	signal e_acc_en : STD_LOGIC;
	signal d_acc_en : STD_LOGIC;
	signal e_delay : STD_LOGIC;
	signal d_delay : STD_LOGIC;
	signal i_rs : STD_LOGIC;
	signal i_os : STD_LOGIC_VECTOR(2 downto 0);
	signal stop_s : STD_LOGIC;
	
	signal f_os_out : STD_LOGIC_VECTOR (1 downto 0);
	signal f_os_1 : STD_LOGIC_VECTOR (1 downto 0);
	signal f_os_2 : STD_LOGIC_VECTOR (1 downto 0);
	signal f_os_s : STD_LOGIC;
	
begin
	
	HALF_D: HALF_datapath PORT MAP(
		data_in => data_in, --from outside
		mux_e => mux_e,
		mux_d => mux_d,
		e_carry_en => e_carry_en,
		d_carry_en => d_carry_en,
		e_acc_en => e_acc_en,
		d_acc_en => d_acc_en,
		clk => clk, -- from outside
		height => height, --from outside
		out_sel => out_sel, --from outside
		e_delay => e_delay,
		d_delay => d_delay,
		i_rs => i_rs,
		i_os => i_os,
		stop => stop_s,
		i_address => i_address, --to outside
		output_func => output_func, --to outside
		output_orig => output_orig --to outside
	);
	
	f_os_s <= e_delay or d_delay;
	
	DELAY_PROC: process (clk) -- Registers
	begin
		if (clk'event and clk = '1') then
			f_os_2 <= f_os_1;
			f_os_1 <= f_os_out;
		end if;
	end process;
	
	f_os <= f_os_2 when f_os_s = '1' else f_os_1;
	
	HALF_FSM: HALF_control PORT MAP(
		stop => stop_s,
		start => start, --from outside
		clk => clk, --from outside
		rst => rst, --from outside
		ww => ww, --from outside
		op_type => op_type, --from outside
		mux_e => mux_e,
		mux_d => mux_d,
		e_carry_en => e_carry_en,
		d_carry_en => d_carry_en,
		e_acc_en => e_acc_en,
		d_acc_en => d_acc_en,
		e_delay => e_delay,
		d_delay => d_delay,
		i_rs => i_rs,
		i_en => i_en, --to outside
		i_os => i_os,
		f_os => f_os_out --to delay
	);
	
	stop <= stop_s;
	
end Behavioral;

