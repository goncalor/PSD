----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:49:31 12/12/2014 
-- Design Name: 
-- Module Name:    HALF_datapath - Behavioral 
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

entity HALF_datapath is
	Port ( data_in : in  STD_LOGIC_VECTOR (31 downto 0);
		mux_e : in  STD_LOGIC;
		mux_d : in  STD_LOGIC;
		e_carry_en : in STD_LOGIC;
		d_carry_en : in STD_LOGIC;
		e_acc_en : in STD_LOGIC;
		d_acc_en : in STD_LOGIC;
		clk : in STD_LOGIC;
		height : in std_logic_vector(7 downto 0);
		out_sel : in STD_LOGIC;
		e_delay : in STD_LOGIC;
		d_delay : in STD_LOGIC;
		ww : in STD_LOGIC_VECTOR(1 downto 0);
		i_rs : in STD_LOGIC;
		i_os : in STD_LOGIC_VECTOR(2 downto 0);
		stop : out STD_LOGIC;
		i_address : out STD_LOGIC_VECTOR(8 downto 0);
		output_func : out  STD_LOGIC_VECTOR (31 downto 0);
		output_orig : out  STD_LOGIC_VECTOR (31 downto 0));
end HALF_datapath;

architecture Behavioral of HALF_datapath is

	COMPONENT HALF_erosion
	PORT(
		data_in : IN std_logic_vector(31 downto 0);
		carry_in : IN std_logic;
		carry_enable : IN std_logic;
		accumulator_in : IN std_logic;
		accumulator_enable : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0);
		carry_out : OUT std_logic
		);
	END COMPONENT;

	COMPONENT HALF_dilation
	PORT(
		data_in : IN std_logic_vector(31 downto 0);
		carry_in : IN std_logic;
		carry_enable : IN std_logic;
		accumulator_in : IN std_logic;
		accumulator_enable : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0);
		carry_out : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT reg
	GENERIC(
		nbits : integer);
	PORT(
		en : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		D : IN std_logic_vector(nbits-1 downto 0);          
		Q : OUT std_logic_vector(nbits-1 downto 0));
	END COMPONENT;
	
	COMPONENT addman
	PORT(
		reset : IN std_logic;
		clk : IN std_logic;
		offset : IN std_logic_vector(2 downto 0);          
		address : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;
	
	signal e_accum_in : std_logic_vector(31 downto 0); -- E block accumulator input
	signal e_accum_out : std_logic_vector(31 downto 0); -- E block accumulator output
	signal e_carry_a : std_logic; -- E Carry accumulated
	signal e_data_out : std_logic_vector(31 downto 0);
	signal e_carry_out : std_logic;
	
	signal e_dod : std_logic_vector(31 downto 0); -- E data out delayed
	
	signal e_reg_in : std_logic_vector(32 downto 0);
	signal e_reg_out : std_logic_vector(32 downto 0);
	
	signal e_ce_1 : STD_LOGIC;
	signal e_ce_2 : STD_LOGIC;
	signal e_ce_3 : STD_LOGIC;
	signal e_ce_f : STD_LOGIC;
	signal e_ae_1 : STD_LOGIC;
	signal e_ae_2 : STD_LOGIC;
	signal e_ae_3 : STD_LOGIC;
	signal e_ae_f : STD_LOGIC;
	
	
	signal d_accum_in : std_logic_vector(31 downto 0); -- D block accumulator input
	signal d_accum_out : std_logic_vector(31 downto 0); -- D block accumulator output
	signal d_carry_a : std_logic; -- D Carry accumulated
	signal d_data_out : std_logic_vector(31 downto 0);
	signal d_carry_out : std_logic;
	
	signal d_dod : std_logic_vector(31 downto 0); -- D data out delayed
	
	signal d_reg_in : std_logic_vector(32 downto 0);
	signal d_reg_out : std_logic_vector(32 downto 0);
	
	signal d_ce_1 : STD_LOGIC;
	signal d_ce_2 : STD_LOGIC;
	signal d_ce_3 : STD_LOGIC;
	signal d_ce_f : STD_LOGIC;
	signal d_ae_1 : STD_LOGIC;
	signal d_ae_2 : STD_LOGIC;
	signal d_ae_3 : STD_LOGIC;
	signal d_ae_f : STD_LOGIC;
	
	signal address_s : STD_LOGIC_VECTOR(8 downto 0);
	
	signal input_address : std_logic_vector(8 downto 0);
	signal address_compare : std_logic_vector(7 downto 0);
begin
	
	--Process for the unconditional registers:
	REG_PROC: process (clk)
	begin
		if (clk'event and clk = '1') then
			
			e_ce_3 <= e_ce_2;
			e_ce_2 <= e_ce_1;
			e_ce_1 <= e_carry_en;
			e_ae_3 <= e_ae_2;
			e_ae_2 <= e_ae_1;
			e_ae_1 <= e_acc_en;
			
			d_ce_3 <= d_ce_2;
			d_ce_2 <= d_ce_1;
			d_ce_1 <= d_carry_en;
			d_ae_3 <= d_ae_2;
			d_ae_2 <= d_ae_1;
			d_ae_1 <= d_acc_en;
			
		end if;
	end process;
	
	
	e_accum_in <= data_in when mux_e = '0' else d_dod;
	d_accum_in <= data_in when mux_d = '0' else e_dod;
	
	e_accum_reg : reg
	GENERIC MAP( nbits => 33 )
	PORT MAP(
		en => '1',
		clk => clk,
		rst => '0',
		D => e_reg_in,
		Q => e_reg_out
	);
	
	e_reg_in <= e_accum_in & e_carry_out;
	e_accum_out <= e_reg_out(32 downto 1);
	e_carry_a <= e_reg_out(0);
	
	d_accum_reg : reg
	GENERIC MAP( nbits => 33 )
	PORT MAP(
		en => '1',
		clk => clk,
		rst => '0',
		D => d_reg_in,
		Q => d_reg_out
	);
	
	d_reg_in <= d_accum_in & d_carry_out;
	d_accum_out <= d_reg_out(32 downto 1);
	d_carry_a <= d_reg_out(0);
	
	
	e_ce_f <= e_ce_3 when e_delay = '1' else e_ce_1;
	e_ae_f <= e_ae_3 when e_delay = '1' else e_ae_1;
	
	d_ce_f <= d_ce_3 when d_delay = '1' else d_ce_1;
	d_ae_f <= d_ae_3 when d_delay = '1' else d_ae_1;
	
	
	E_block: HALF_erosion PORT MAP(
		data_in => e_accum_out,
		carry_in => e_carry_a,
		carry_enable => e_ce_f,
		accumulator_in => e_accum_in(31),
		accumulator_enable => e_ae_f,
		data_out => e_data_out,
		carry_out => e_carry_out
	);
	
	D_block: HALF_dilation PORT MAP(
		data_in => d_accum_out,
		carry_in => d_carry_a,
		carry_enable => d_ce_f,
		accumulator_in => d_accum_in(31),
		accumulator_enable => d_ae_f,
		data_out => d_data_out,
		carry_out => d_carry_out
	);
	
	e_delay_reg : reg
	GENERIC MAP( nbits => 32 )
	PORT MAP(
		en => '1',
		clk => clk,
		rst => '0',
		D => e_data_out,
		Q => e_dod
	);
	
	d_delay_reg : reg
	GENERIC MAP( nbits => 32 )
	PORT MAP(
		en => '1',
		clk => clk,
		rst => '0',
		D => d_data_out,
		Q => d_dod
	);
	
	output_func <= e_data_out when out_sel = '0' else d_data_out;
	
	output_orig <= d_accum_out;
	
	-- Address Managers:
	
	i_addman: addman PORT MAP(
		reset => i_rs,
		clk => clk,
		offset => i_os,
		address => input_address
	);
	i_address <= input_address;
	
	with ww select address_s <=
		input_address + 4 when "01",
		input_address + 3 when "10",
		input_address + 2 when "11",
		input_address + 1 when others;
	
	address_compare <= height xor ("0"& address_s(8 downto 2));
	stop <= '1' when address_compare = X"00" else '0';

end Behavioral;

