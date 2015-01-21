----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:05:21 04/23/2010 
-- Design Name: 
-- Module Name:    controlo - Behavioral 
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

entity controlo is
	Port (
	switches : in  std_logic_vector (7 downto 0);
	btn, valid, rst : in  std_logic;
	clk : in std_logic;
	start : out  std_logic;
	width, height: out std_logic_vector(7 downto 0);
	op_type : out std_logic_vector(2 downto 0)
	);
end controlo;

architecture Behavioral of controlo is
  type fsm_states is (s_initial, w_saved, i_height, h_saved, i_op, op_saved, ready, s_start, write_out, s_end);
  signal currstate, nextstate: fsm_states;
  signal op_typeaux : std_logic_vector(7 downto 0);
--  signal count_en, end_of_counting : std_logic;
--  signal count : std_logic_vector (8 downto 0);
--  constant countEND : std_logic_vector (8 downto 0) := (others => '1');
begin
--  end_of_counting <= '1' when count = countEND else '0';

  state_reg: process (clk, rst)
  begin 
    if rst = '1' then
      currstate <= s_initial ;
    elsif clk'event and clk = '1' then
      currstate <= nextstate ;
    end if ;
  end process;

  next_state: process (currstate, btn, valid)
  begin  --  process
    nextstate <= currstate ;  
    -- by default, does not change the state.
--    executing <= '0';
--    count_en <= '0';
    
	case currstate is
		when s_initial =>
			start <= '0';
			if btn = '1' then
				nextstate <= w_saved;
			end if;
		when w_saved =>
			start <= '0';
			if btn = '0' then
				nextstate <= i_height;
			end if;
		when i_height =>
			start <= '0';
			if btn = '1' then
				nextstate <= h_saved;
			end if;
		when h_saved =>
			start <= '0';
			if btn = '0' then
				nextstate <= i_op;
			end if;
		when i_op =>
			start <= '0';
			if btn = '1' then
				nextstate <= op_saved;
			end if;
		when op_saved =>
			start <= '0';
			if btn = '0' then
				nextstate <= ready;
			end if;
		when ready =>
			start <= '0';
			if btn = '1' then
				nextstate <= s_start;
			end if;
		when s_start =>
			start <= '1';
			if valid = '1' then
				nextstate <= write_out;
			end if;
		when write_out =>
			start <= '0';
			if valid = '0' then
				nextstate <= s_end;
			end if;
		when others => -- s_end
			start <= '0';
			if btn = '0' then
				nextstate <= s_initial;
			end if;
	end case;

--    case currstate is
--      when s_initial =>
--        if start='1' then
--          nextstate <= s_exec ;
--        end if;
--      when s_exec =>
--        if end_of_counting = '1' then
--          nextstate <= s_last_exec;
--        end if;
--        count_en <= '1';
--        executing <= '1';
--      when s_last_exec =>
--        nextstate <= s_end;
--        count_en <= '1';
--        executing <= '1';
--      when s_end =>
--    end case;
  end process;

  process (clk, rst) 
  begin
	  if clk='1' and clk'event then
		  if btn = '1' then
			  if currstate = s_initial then
				  width <= switches;
			  elsif currstate = i_height then
				  height <= switches;
			  elsif currstate = i_op then
				  op_typeaux <= switches;
			  end if;
		  end if;
	  end if;

--    if rst='1' then 
--      count <= (others => '0');
--    elsif clk='1' and clk'event then
--      if count_en='1' then
--        if end_of_counting = '0' then
--          count <= count + 1;
--        end if;
--      end if;
--    end if;
  end process;

  op_type <= op_typeaux(2 downto 0);
  -- add1 provides first address counter.
  -- add2 is add1 delayed by one clock cycle. 
--  add1 <= count;
--  process (clk) 
--  begin
--    if clk='1' and clk'event then
--      add2 <= count;
--    end if;
--  end process;
end Behavioral;

