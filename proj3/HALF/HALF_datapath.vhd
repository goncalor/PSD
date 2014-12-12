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
		bypass : in  STD_LOGIC;
		e_carry_en : in STD_LOGIC;
		d_carry_en : in STD_LOGIC;
		e_acc_en : in STD_LOGIC;
		d_acc_en : in STD_LOGIC;
		clk : in STD_LOGIC;
		output_e : out  STD_LOGIC_VECTOR (31 downto 0);
		output_d : out  STD_LOGIC_VECTOR (31 downto 0));
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
	
	signal e_accum_in : std_logic_vector(31 downto 0); -- E block accumulator input
	signal e_accum_out : std_logic_vector(31 downto 0); -- E block accumulator output
	signal e_carry_a : std_logic; -- E Carry accumulated
	signal e_cen_a : std_logic; -- E Carry_enable accumulated
	signal e_acb_e : std_logic; -- E Accumulator Bypass Enable
	signal e_data_out : std_logic_vector(31 downto 0);
	signal e_carry_out : std_logic;
	
	signal e_dod : std_logic_vector(31 downto 0); -- E data out delayed
	
	signal e_reg_in : std_logic_vector(34 downto 0);
	signal e_reg_out : std_logic_vector(34 downto 0);
	
	
	
	signal d_accum_in : std_logic_vector(31 downto 0); -- D block accumulator input
	signal d_accum_out : std_logic_vector(31 downto 0); -- D block accumulator output
	signal d_carry_a : std_logic; -- D Carry accumulated
	signal d_cen_a : std_logic; -- D Carry_enable accumulated
	signal d_acb_e : std_logic; -- D Accumulator Bypass Enable
	signal d_data_out : std_logic_vector(31 downto 0);
	signal d_carry_out : std_logic;
	
	signal d_dod : std_logic_vector(31 downto 0); -- D data out delayed
	
	signal d_reg_in : std_logic_vector(34 downto 0);
	signal d_reg_out : std_logic_vector(34 downto 0);
	
begin
	
	e_accum_in <= data_in when mux_e = '0' else d_dod;
	d_accum_in <= data_in when mux_d = '0' else e_dod;
	
	e_accum_reg : reg
	GENERIC MAP( nbits => 35 )
	PORT MAP(
		en => '1',
		clk => clk,
		rst => '0',
		D => e_reg_in,
		Q => e_reg_out
	);
	
	e_reg_in <= e_accum_in & e_carry_out & e_carry_en & e_acc_en;
	e_accum_out <= e_reg_out(34 downto 3);
	e_carry_a <= e_reg_out(2);
	e_cen_a <= e_reg_out(1);
	e_acb_e <= e_reg_out(0);
	
	d_accum_reg : reg
	GENERIC MAP( nbits => 35 )
	PORT MAP(
		en => '1',
		clk => clk,
		rst => '0',
		D => d_reg_in,
		Q => d_reg_out
	);
	
	d_reg_in <= d_accum_in & d_carry_out & d_carry_en & d_acc_en;
	d_accum_out <= d_reg_out(34 downto 3);
	d_carry_a <= d_reg_out(2);
	d_cen_a <= d_reg_out(1);
	d_acb_e <= d_reg_out(0);
	
	E_block: HALF_erosion PORT MAP(
		data_in => e_accum_out,
		carry_in => e_carry_a,
		carry_enable => e_cen_a,
		accumulator_in => e_accum_in(31),
		accumulator_enable => e_acb_e,
		data_out => e_data_out,
		carry_out => e_carry_out
	);
	
	D_block: HALF_dilation PORT MAP(
		data_in => d_accum_out,
		carry_in => d_carry_a,
		carry_enable => d_cen_a,
		accumulator_in => d_accum_in(31),
		accumulator_enable => d_acb_e,
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
	
	output_e <= e_data_out;
	
	output_d <= d_data_out when bypass='0' else d_accum_out;

end Behavioral;

