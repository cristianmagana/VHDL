----------------------------------------------------------------------
-- Digital Design 101 Lab Assignment 1 - Z20
-- LFDetector Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Cristian
-- Student Last Name : Magana
-- Student ID :----
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY LFDetector_behav IS
   PORT (Fuel3, Fuel2, Fuel1, Fuel0: IN std_logic;
         FuelWarningLight: OUT std_logic);
END LFDetector_behav;

ARCHITECTURE Behavior OF LFDetector_behav IS

-- DO NOT modify any signals, ports, or entities above this line
-- add your code below this line
-- put your code in a PROCESS
-- use AND/OR/NOT keywords for behavioral (Boolean) function
BEGIN
    PROCESS(Fuel2, Fuel3)
    BEGIN
        FuelWarningLight <= NOT Fuel2 AND NOT Fuel3 AFTER 4.4 NS;
    END PROCESS;
END Behavior;
