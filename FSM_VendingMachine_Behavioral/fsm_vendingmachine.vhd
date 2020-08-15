----------------------------------------------------------------------
-- eecs31l assignment 2
-- fsm behavioral model
----------------------------------------------------------------------
-- student first name : Cristian
-- student last name : MAGANA
-- student id : 37578770
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lab2b_fsm is
    port ( input : in  std_logic_vector(2 downto 0);
           clk : in  std_logic;
           permit : out  std_logic;
           returnchange : out  std_logic);
end lab2b_fsm;

architecture behavioral of lab2b_fsm is
-- do not modify any signals, ports, or entities above this line
-- recommendation: create 2 processes (one for updating state status and the other for describing transitions and outputs)
-- figure out the appropriate sensitivity list of both the processes.
-- use case statements and if/else/elsif statements to describe your processes.
-- add your code here
	
	-- LISTING OUT POSSIBLE STATES
	type statetype is 
		(start,
			five, five_w,
			ten, ten_w,
			fiftn, fiftn_w,
			eq_20, eq_20_w,	eq_20_w2, eq_20_w3,
			gr_20, gr_20_w,gr_20_w2,gr_20_w3,
			cancel, cancel_rc);
	signal currentstate, nextstate: statetype;
	
begin
	statereg: process(clk)
	begin	
		if (clk='1' and clk'event) then
				currentstate <= nextstate;

		end if;
	end process;
	
	
	
	comblogic: process(currentstate, input)
	begin 
	   permit <= '0';
	   returnchange <= '0';
	   
		case currentstate IS
			when start => 
				if (input = "100") then 
					nextstate <= five;
				elsif (input = "010") then 
					nextstate <= ten;
				elsif (input = "001") then 
					nextstate <= eq_20;
				elsif (input = "111") then
					nextstate <= cancel;
				else
					nextstate <= currentstate;
				end if; 
			when five  =>
			    if (input = "000") then
			        nextstate <= five_w;
			    elsif (input = "111") then
					nextstate <= cancel_rc;
				else 
					nextstate <= currentstate;
				end if; 
			when five_w => 
				if (input = "100") then 
					nextstate <= ten;
				elsif (input = "010") then 
					nextstate <= fiftn;
				elsif (input = "001") then 
					nextstate <= gr_20;
				elsif (input = "111") then
					nextstate <= cancel_rc;
				end if; 
			when ten => 
			    if (input = "000") then
			        nextstate <= ten_w;
			    elsif (input = "111") then
					nextstate <= cancel_rc;
				else 
					nextstate <= currentstate;
				end if; 
			when ten_w =>
				if (input = "100") then 
					nextstate <= fiftn;
				elsif (input = "010") then 
					nextstate <= eq_20;
				elsif (input = "001") then 
					nextstate <= gr_20;
				elsif (input = "111") then
					nextstate <= cancel_rc;
				end if; 
			when fiftn => 
			    if (input = "000") then
			        nextstate <= fiftn_w;
			    elsif (input = "111") then
					nextstate <= cancel_rc;
				else 
					nextstate <= currentstate;
				end if; 
			when fiftn_w =>
			    if (input = "100") then 
					nextstate <= eq_20;
				elsif (input = "010") then 
					nextstate <= gr_20;
				elsif (input = "001") then 
					nextstate <= gr_20;
				elsif (input = "111") then
					nextstate <= cancel_rc;
				end if;			
			when eq_20 =>
				permit <= '1';
				returnchange <= '0';
				nextstate <= eq_20_w;
			when eq_20_w =>
			     nextstate <= eq_20_w2;	 
			 when eq_20_w2 =>
			     nextstate <= eq_20_w3;
			 when eq_20_w3 =>
			     nextstate <= start;			     
			when gr_20 =>
				permit <= '1';
				returnchange <= '1';
				nextstate <= gr_20_w;
			when gr_20_w =>
			     nextstate <= gr_20_w2 ;	
			 when gr_20_w2 =>
			     nextstate <= eq_20_w3;
			 when gr_20_w3 =>
			     nextstate <=  start;	
			when cancel =>
				permit <= '0';
				returnchange <= '0';
				nextstate <= start;
			when cancel_rc =>
				permit <= '0';
				returnchange <= '1';
				nextstate <= start;
		END case;
	end process;
	
end behavioral;
