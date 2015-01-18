----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:19:49 12/19/2014 
-- Design Name: 
-- Module Name:    SAVE_circuit - Behavioral 
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

entity SAVE_circuit is
	PORT(
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC;
		stop : IN STD_LOGIC;
		start : IN STD_LOGIC;
		op_type : IN std_logic_vector(2 downto 0);  
		data_in : IN std_logic_vector(31 downto 0);
		original : IN std_logic_vector(31 downto 0);
		offset : IN std_logic_vector(1 downto 0);
		ww : IN std_logic_vector(2 downto 0);  
		valid : OUT std_logic;
		output : OUT std_logic_vector(31 downto 0)
	);
end SAVE_circuit;

architecture Behavioral of SAVE_circuit is
	COMPONENT SAVE_control
	PORT(
		stop : IN std_logic;
		start : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		op_type : IN std_logic_vector(2 downto 0);          
		ww : IN std_logic_vector(2 downto 0);  
		orw_old : OUT std_logic;
		m_ort : OUT std_logic;
		c_ort : OUT std_logic;
		e_is : OUT std_logic;
		d_is : OUT std_logic;
		cfs : OUT std_logic;
		cs : OUT std_logic;
		ofs : OUT std_logic;
		os : OUT std_logic;
		valid : OUT std_logic
		);
	END COMPONENT;
	COMPONENT SAVE_datapath
	PORT(
		clk : IN std_logic;
		orw_old : IN std_logic;
		orw_new : IN std_logic;
		m_ort : IN std_logic;
		c_ort : IN std_logic;
		e_is : IN std_logic;
		d_is : IN std_logic;
		cfs : IN std_logic;
		cs : IN std_logic;
		ofs : IN std_logic;
		os : IN std_logic;
		data_in : IN std_logic_vector(31 downto 0);
		original : IN std_logic_vector(31 downto 0);
		offset : IN std_logic_vector(1 downto 0);
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	signal orw_old : std_logic;
	signal m_ort : std_logic;
	signal c_ort : std_logic;
	signal e_is : std_logic;
	signal d_is : std_logic;
	signal cfs : std_logic;
	signal cs : std_logic;
	signal ofs : std_logic;
	signal os : std_logic;
	
	signal stop_1 : std_logic;
	signal stop_2 : std_logic;
	signal stop_3 : std_logic;
	signal stop_4 : std_logic;
	signal stop_5 : std_logic;
	
	signal start_1 : std_logic;
	signal start_2 : std_logic;
	signal start_3 : std_logic;
	signal start_4 : std_logic;
	signal start_5 : std_logic;
	signal start_6 : std_logic;
begin
	
	SAVE_FSM: SAVE_control PORT MAP(
		stop => stop_5,
		start => start_6,
		clk => clk,
		rst => rst,
		op_type => op_type,
		ww => ww,
		orw_old => orw_old,
		m_ort => m_ort,
		c_ort => c_ort,
		e_is => e_is,
		d_is => d_is,
		cfs => cfs,
		cs => cs,
		ofs => ofs,
		os => os,
		valid => valid
	);
	SAVE_D: SAVE_datapath PORT MAP(
		clk => clk,
		orw_old => orw_old,
		orw_new => stop_1,
		m_ort => m_ort,
		c_ort => c_ort,
		e_is => e_is,
		d_is => d_is,
		cfs => cfs,
		cs => cs,
		ofs => ofs,
		os => os,
		data_in => data_in,
		original => original,
		offset => offset,
		output => output
	);
	
	-- Registers:
	REG_PROC: process (clk)
	begin
		if (clk'event and clk = '1') then
			case (offset) is
				when "00" =>
					stop_5 <= stop_4;
					stop_4 <= stop_3;
					stop_3 <= stop_2;
					stop_2 <= stop_1;
					stop_1 <= stop;
					start_6 <= start_5;
					start_5 <= start_4;
					start_4 <= start_3;
					start_3 <= start_2;
					start_2 <= start_1;
					start_1 <= start;
				when "01" =>
					stop_5 <= stop_4;
					stop_4 <= stop_2;
					stop_3 <= stop_1;
					stop_2 <= stop;
					stop_1 <= stop;
					start_6 <= start_5;
					start_5 <= start_4;
					start_4 <= start_2;
					start_3 <= start_1;
					start_2 <= start;
					start_1 <= start;
				when "10" =>
					stop_5 <= stop_4;
					stop_4 <= stop_1;
					stop_3 <= stop;
					stop_2 <= stop;
					stop_1 <= stop;
					start_6 <= start_5;
					start_5 <= start_4;
					start_4 <= start_1;
					start_3 <= start;
					start_2 <= start;
					start_1 <= start;
				when others =>
					stop_5 <= stop_4;
					stop_4 <= stop;
					stop_3 <= stop;
					stop_2 <= stop;
					stop_1 <= stop;
					start_6 <= start_5;
					start_5 <= start_4;
					start_4 <= start;
					start_3 <= start;
					start_2 <= start;
					start_1 <= start;
			end case;
		end if;
	end process;
	
end Behavioral;

