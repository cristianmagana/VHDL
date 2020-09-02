----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1 - S20
-- LFDetector Structural Model
----------------------------------------------------------------------
-- Student First Name : Cristian
-- Student Last Name : Magana
-- Student ID : ----
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY NAND2 IS
   PORT (x: IN std_logic;
         y: IN std_logic;
         F: OUT std_logic);
END NAND2;  

ARCHITECTURE behav OF NAND2 IS
BEGIN
   PROCESS(x, y)
   BEGIN
      F <= NOT (x AND y) AFTER 1.4 ns; 
   END PROCESS;
END behav;
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY LFDetector_structural IS
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_structural;

ARCHITECTURE Structural OF LFDetector_structural IS

-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
-- use the appropriate library component(s) specified in the lab handout
-- add the appropriate internal signals & wire your design below
 COMPONENT NAND2 IS 
        PORT ( x: IN std_logic;
               y: IN std_logic;
               F: OUT std_logic);
    END COMPONENT;
    
    SIGNAL w1, w2, w3, w4: std_logic;  
   
BEGIN
    
    NAND2_1: NAND2 PORT MAP (x => Fuel2, y => Fuel3, F => w1);
    NAND2_2: NAND2 PORT MAP (x => Fuel2, y => w1, F => w2);
    NAND2_3: NAND2 PORT MAP (x => w1, y => Fuel3, F => w3);
    NAND2_4: NAND2 PORT MAP (x => w2, y => w3, F => w4);


END Structural;
