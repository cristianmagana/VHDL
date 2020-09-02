----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 2 - S20
-- LFDetector Structural Model
----------------------------------------------------------------------
-- Student First Name : Cristian
-- Student Last Name : Magana
-- Student ID : 37578770
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY  FSM_Vending IS
   PORT (clk: IN std_logic;
			Input: IN std_logic_vector (2 downto 0);
			Permit: OUT std_logic;
			ReturnChange: OUT std_logic );
END FSM_Vending;

ARCHITECTURE Structural OF FSM_Vending IS

	SUBTYPE Statetype is std_logic_vector (3 downto 0);
	SIGNAL CS, N_S: Statetype := "0000";

begin
	statereg: process(clk)
	begin	
		if (clk='1' and clk'event) then
				CS <= N_S;
        
		end if;
	end process;
	
	

   CombLogic: PROCESS(CS, Input)
   BEGIN
   Permit <= '0';
   ReturnChange <= '0';
      N_S(3) <= ((NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0)) --S1
					OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND CS(0) AND Input(2) AND Input(1) AND Input(0)) --S2
					OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) --S3
                    OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0)) --S3
                    OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND CS(0) AND Input(2) AND Input(1) AND Input(0)) --S4
					
					OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) --S5
					OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0)) --S5
					
					OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND CS(0) AND Input(2) AND Input(1) AND Input(0)) --S6
					
					OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) --S7
					OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0)) --S7
					OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0)) --S7
					
					OR (NOT CS(3) AND CS(2) AND CS(1) AND CS(0) AND NOT Input(2) AND NOT Input(1) AND NOT Input(0)) --S8
					
					OR (CS(3) AND NOT CS(2) AND NOT CS(1) AND CS(0) AND NOT Input(2) AND NOT Input(1) AND NOT Input(0))
					
					) after 5.6 ns; --S9
					
		N_S(2) <= ((NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) --S1
				OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND CS(0) AND Input(2) AND Input(1) AND Input(0))--S2
				
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0))--S3
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0))--S3
				
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND CS(0) AND NOT Input(2) AND NOT Input(1) AND NOT Input(0)) --S4
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND CS(0) AND Input(2) AND Input(1) AND Input(0)) --S4
				
				OR (NOT CS(3) AND CS(2) AND not CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0)) --S5
				OR (NOT CS(3) AND CS(2) AND not CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0)) --S5
				OR (NOT CS(3) AND CS(2) AND not CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0)) --S5
				
				OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND CS(0) AND NOT Input(2) AND NOT Input(1) AND NOT Input(0)) --S6
				OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND CS(0) AND Input(2) AND Input(1) AND Input(0)) --S6
				
				OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0)) --S7
				OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0))
				
				) AFTER 5.6 NS; --S7
				
				
				
		N_S(1) <= ((NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) --S1
		        OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0)) --S1
				OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0)) --S1
		
		
				OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND CS(0) AND NOT Input(2) AND NOT Input(1) AND NOT Input(0))--S2
				
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0)) --S3
				
				OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0)) --S5
		
				OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND CS(0) AND NOT Input(2) AND NOT Input(1) AND NOT Input(0)) --S6
				
				OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0)) --S7
				
				OR ( CS(3) AND NOT CS(2) AND NOT CS(1) AND CS(0) AND NOT Input(2) AND NOT Input(1) AND NOT Input(0)) --S7
				
				) after 5.6 ns;
				
		N_S(0) <= ((NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) --S1
		        OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0)) --S1
		        OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0)) --S1
		        OR (NOT CS(3) AND NOT CS(2) AND NOT CS(1) AND NOT CS(0) AND Input(2) AND Input(1) AND Input(0)) --S1
				
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0)) --S3
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0)) --S3
				OR (NOT CS(3) AND NOT CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0)) --S3
				
				OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0))
				OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0))
				OR (NOT CS(3) AND CS(2) AND NOT CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0))
				
				OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND NOT Input(1) AND Input(0))
				OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND NOT Input(2) AND Input(1) AND NOT Input(0))
				OR (NOT CS(3) AND CS(2) AND CS(1) AND NOT CS(0) AND Input(2) AND NOT Input(1) AND NOT Input(0))
				
				) after 5.6 ns;
				
		Permit <= ((NOT CS(3)  AND CS(2) AND CS(1) AND CS(0))
				OR (CS(3) AND NOT CS(2) AND NOT CS(1) AND CS(0)));
		
		ReturnChange <= ((CS(3) AND NOT CS(2) AND NOT CS(1) AND CS(0))
				OR (CS(3) AND CS(2) AND NOT CS(1) AND NOT CS(0)));
				
END PROCESS CombLogic;
   

   
END Structural;
