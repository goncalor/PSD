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
		i_address : in  STD_LOGIC_VECTOR (1 downto 0);
		mux_e : out  STD_LOGIC;
		mux_d : out  STD_LOGIC;
		bypass : out  STD_LOGIC;
		e_carry_en : out  STD_LOGIC;
		d_carry_en : out  STD_LOGIC;
		e_acc_en : out  STD_LOGIC;
		d_acc_en : out  STD_LOGIC;
		i_rs : out  STD_LOGIC;
		e_rs : out  STD_LOGIC;
		d_rs : out  STD_LOGIC;
		i_os : out  STD_LOGIC_VECTOR (2 downto 0);
		e_os : out  STD_LOGIC_VECTOR (2 downto 0);
		d_os : out  STD_LOGIC_VECTOR (2 downto 0));
end HALF_control;

architecture Behavioral of HALF_control is

begin


end Behavioral;

