
--------------------------------------------------------------------------------
-- Company: QV's Minions - Z20
-- Engineer: Cristian Magana
--
-- Design Name:   LFDetector_behav
-- Module Name:   lab1s_tb.vhd
-- Project Name:  Lab1_LFDetector
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LFDetector_behav
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY lab1s_tb_vhd IS
END lab1s_tb_vhd;

ARCHITECTURE structural OF lab1s_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT LFDetector_structural
	PORT(
		Fuel3 : IN std_logic;
		Fuel2 : IN std_logic;
		Fuel1 : IN std_logic;
		Fuel0 : IN std_logic;          
		FuelWarningLight : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL Fuel3 :  std_logic := '0';
	SIGNAL Fuel2 :  std_logic := '0';
	SIGNAL Fuel1 :  std_logic := '0';
	SIGNAL Fuel0 :  std_logic := '0';


	--Outputs
	SIGNAL FuelWarningLight :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: LFDetector_structural PORT MAP(
		Fuel3 => Fuel3,
		Fuel2 => Fuel2,
		Fuel1 => Fuel1,
		Fuel0 => Fuel0,
		FuelWarningLight => FuelWarningLight
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Place/replace stimulus here
        -- add additional stimulus as needed

        -- testing value "0000", expecting FuelWarningLight = __?
		Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '0'; Fuel0 <='0';
		wait for 10 ns;
		Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '0'; Fuel0 <='1';
		wait for 10 ns;
       	Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '1'; Fuel0 <='0';
		wait for 10 ns;
		Fuel3 <= '0'; Fuel2 <= '0'; Fuel1 <= '1'; Fuel0 <='1';
		wait for 10 ns;
		Fuel3 <= '0'; Fuel2 <= '1'; Fuel1 <= '0'; Fuel0 <='0';
		wait for 10 ns;
		Fuel3 <= '0'; Fuel2 <= '1'; Fuel1 <= '0'; Fuel0 <='1';
		wait for 10 ns;
		Fuel3 <= '0'; Fuel2 <= '1'; Fuel1 <= '1'; Fuel0 <='1';
		wait for 10 ns;
        -- test more values
		-- for Lab 1, test all combinations
        
		wait; -- will wait forever
	END PROCESS;

END;
