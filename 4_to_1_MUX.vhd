# VHDL

----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1 - S20
-- LFDetector Structural Model
----------------------------------------------------------------------
-- Student First Name : Cristian
-- Student Last Name : Magana
-- Student ID : 37578770
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY AND2 IS
   PORT (a: IN std_logic;
         b: IN std_logic;
		 c: IN std_logic;
         F: OUT std_logic);
END AND2;  

ARCHITECTURE behav OF AND2 IS
BEGIN
   PROCESS(a,b,c)
   BEGIN
      F <= (a AND b AND c) AFTER 2.8 ns; 
   END PROCESS;
END behav;
---------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY 4_to_1_Selc IS
   PORT (d3, d2, d1, d0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
         s1, s0: IN std_logic;
         Y: IN STD_LOGIC_VECTOR (3 DOWNTO 0));
END 4_to_1_Selc;  
---------------------------------------------------------
ARCHITECTURE 4_to_1_Selc_struct OF 4_to_1_Selc IS
	COMPONENT AND2 IS
		PORT (a,b,c: IN std_logic;
				F: OUT std_logic);
	END COMPONENT;
	COMPONENT Or2 IS
		PORT (a,b,c,d: IN std_logic;
				F: OUT std_logic);
	END COMPONENT;
	COMPONENT Inv IS
		PORT (a: IN std_logic; 
				F: OUT std_logic);
	END COMPONENT;	
---------------------------------------------------------
	signal s0_inv,s1_inv,w1,w2,w3,w4,w_output;
	
---------------------------------------------------------
BEGIN
		Inv_s0: Inv PORT MAP(s0, s0_inv);
		Inv_s1: Inv PORT MAP(s1, s1_inv);
		AND2_3: AND2 PORT MAP(d3, s0, s1, w3);
		AND2_2: AND2 PORT MAP(d2, s0_inv, s1, w2);
		AND2_1: AND2 PORT MAP(d1, s0, s1_inv, w1);
		AND2_0: AND2 PORT MAP(d0, s0_inv, s1_inv, w0);
		Or2_F: Or2 Port Map (w3, w2, w1, w0, w_output) 
		
END 4_to_1_Selc_struct;
----------------------------------------------------------------------
