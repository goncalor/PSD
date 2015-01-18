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
  Port ( add1, add2 : out  std_logic_vector (8 downto 0);
         start, clk, rst : in  std_logic;
         executing : out  std_logic);
end controlo;

architecture Behavioral of controlo is
  type fsm_states is ( s_initial, s_end, s_exec, s_last_exec );
  signal currstate, nextstate: fsm_states;
  signal count_en, end_of_counting : std_logic;
  signal count : std_logic_vector (8 downto 0);
  constant countEND : std_logic_vector (8 downto 0) := (others => '1');
begin
  end_of_counting <= '1' when count = countEND else '0';
  state_reg: process (clk, rst)
  begin 
    if rst = '1' then
      currstate <= s_initial ;
    elsif clk'event and clk = '1' then
      currstate <= nextstate ;
    end if ;
  end process;

  state_comb: process (currstate, start, end_of_counting)
  begin  --  process
    nextstate <= currstate ;  
    -- by default, does not change the state.
    executing <= '0';
    count_en <= '0';
    
    case currstate is
      when s_initial =>
        if start='1' then
          nextstate <= s_exec ;
        end if;
      when s_exec =>
        if end_of_counting = '1' then
          nextstate <= s_last_exec;
        end if;
        count_en <= '1';
        executing <= '1';
      when s_last_exec =>
        nextstate <= s_end;
        count_en <= '1';
        executing <= '1';
      when s_end =>
    end case;
  end process;

  process (clk, rst) 
  begin
    if rst='1' then 
      count <= (others => '0');
    elsif clk='1' and clk'event then
      if count_en='1' then
        if end_of_counting = '0' then
          count <= count + 1;
        end if;
      end if;
    end if;
  end process;

  -- add1 provides first address counter.
  -- add2 is add1 delayed by one clock cycle. 
  add1 <= count;
  process (clk) 
  begin
    if clk='1' and clk'event then
      add2 <= count;
    end if;
  end process;
end Behavioral;

