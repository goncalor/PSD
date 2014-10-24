----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:41:05 10/24/2014 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
	Port (	clk : in STD_LOGIC;
		m1_ctl : in  STD_LOGIC_VECTOR (1 downto 0);
		m2_ctl : in  STD_LOGIC_VECTOR (2 downto 0);
		as_ctl : in  STD_LOGIC;
		as_op : in  STD_LOGIC;
		en_a : in  STD_LOGIC;
		en_b : in  STD_LOGIC;
		en_c : in  STD_LOGIC;
		en_d : in  STD_LOGIC;
		rst : in STD_LOGIC;
		a : in  STD_LOGIC_VECTOR (15 downto 0);
		b : in  STD_LOGIC_VECTOR (15 downto 0);
		c : in  STD_LOGIC_VECTOR (15 downto 0);
		d : in  STD_LOGIC_VECTOR (15 downto 0);
		e : in  STD_LOGIC_VECTOR (15 downto 0);
		f : in  STD_LOGIC_VECTOR (15 downto 0);
		g : in  STD_LOGIC_VECTOR (15 downto 0);
		h : in  STD_LOGIC_VECTOR (15 downto 0);
		i : in  STD_LOGIC_VECTOR (15 downto 0);
		res : out  STD_LOGIC_VECTOR (47 downto 0));
end datapath;

architecture Behavioral of datapath is
	
	COMPONENT reg
	GENERIC(
		nbits : integer
	);
	PORT(
		en : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;
		D : IN std_logic_vector(nbits-1 downto 0);          
		Q : OUT std_logic_vector(nbits-1 downto 0)
	);
	END COMPONENT;
	
	signal m1in1 : STD_LOGIC_VECTOR (15 downto 0);
	signal m1in2 : STD_LOGIC_VECTOR (31 downto 0);
	signal m2in1 : STD_LOGIC_VECTOR (15 downto 0);
	signal m2in2 : STD_LOGIC_VECTOR (31 downto 0);
	signal asin1 : STD_LOGIC_VECTOR (31 downto 0);
	signal asin2 : STD_LOGIC_VECTOR (31 downto 0);
	signal m1out : STD_LOGIC_VECTOR (47 downto 0);
	signal m2out : STD_LOGIC_VECTOR (47 downto 0);
	signal asout : STD_LOGIC_VECTOR (31 downto 0);
	signal RAin : STD_LOGIC_VECTOR (47 downto 0);
	signal RBin : STD_LOGIC_VECTOR (47 downto 0);
	signal RCin : STD_LOGIC_VECTOR (47 downto 0);
	signal RDin : STD_LOGIC_VECTOR (47 downto 0);
	signal RAout : STD_LOGIC_VECTOR (47 downto 0);
	signal RBout : STD_LOGIC_VECTOR (47 downto 0);
	signal RCout : STD_LOGIC_VECTOR (47 downto 0);
	signal RDout : STD_LOGIC_VECTOR (47 downto 0);
	signal extf : STD_LOGIC_VECTOR (31 downto 0);
	signal extg : STD_LOGIC_VECTOR (31 downto 0);
	signal exth : STD_LOGIC_VECTOR (31 downto 0);
	signal exti : STD_LOGIC_VECTOR (31 downto 0);
begin
	-- Register input assignments:
	RAin <= m1out;
	RBin <= m2out;
	RCin <= (others => asout(31));
	RCin(31 downto 0) <= asout;
	RDin <= (others => asout(31));
	RDin(31 downto 0) <= asout;
	
	-- Input signal extension:
	extf <= (others => f(15));
	extf(15 downto 0) <= f;
	extg <= (others => g(15));
	extg(15 downto 0) <= g;
	exth <= (others => h(15));
	exth(15 downto 0) <= h;
	exti <= (others => i(15));
	exti(15 downto 0) <= i;
	
	-- Instances of reg:
	-- RA:
	reg_RA : reg
	GENERIC MAP( nbits => 48 )
	PORT MAP(
		en => en_a,
		clk => clk,
		rst => rst,
		D => RAin,
		Q => RAout
	);
	
	-- RB:
	reg_RB : reg
	GENERIC MAP( nbits => 48 )
	PORT MAP(
		en => en_b,
		clk => clk,
		rst => rst,
		D => RBin,
		Q => RBout
	);
	
	-- RC:
	reg_RC : reg
	GENERIC MAP( nbits => 48 )
	PORT MAP(
		en => en_c,
		clk => clk,
		rst => rst,
		D => RCin,
		Q => RCout
	);
	
	-- RD:
	reg_RD : reg
	GENERIC MAP( nbits => 48 )
	PORT MAP(
		en => en_d,
		clk => clk,
		rst => rst,
		D => RDin,
		Q => RDout
	);
	
	-- Functional unit assignments:
	m1out <= m1in1 * m1in2;
	m2out <= m2in1 * m2in2;
	asout <= asin1 - asin2 when as_op = '1' else asin1 + asin2;
	
	-- Multiplier 1 Multiplexers:
	with m1_ctl select
		m1in1 <= e when "00",
			g when "01",
			d when "10",
			b when others;
	with m1_ctl select
		m1in2 <= exti when "00",
			extf when "01",
			exth when "10",
			RDout(47)&RDout(30 downto 0) when others;

end Behavioral;

