--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Cristian Magana
--
-- Create Date:   
-- Design Name:   
-- Module Name:   
-- Project Name:  Lab2_FSM_S
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FSM_S
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestBench_SX IS
END TestBench_SX;
 
ARCHITECTURE behavior OF TestBench_SX IS 
	
	    -- Component Declaration for the Unit Under Test (UUT)
	
	COMPONENT  FSM_Vending IS
     PORT (clk: IN std_logic;
			Input: IN std_logic_vector (2 downto 0);
			Permit: OUT std_logic;
			ReturnChange: OUT std_logic );
	END COMPONENT;
	
		--Inputs
	SIGNAL clk: std_logic := '0';
	signal Input: std_logic_vector(2 downto 0) := (others => '0');
	
	--Outputs
	SIGNAL Permit : STD_LOGIC; 
	SIGNAL ReturnChange: std_logic ;
	
	--CLOCK PERIOD DEFINITION
	--CONSTANT clk_period : time :=  11.6 ns; 
	
begin
	uut: FSM_Vending PORT MAP (
						clk => clk,
						Input => Input,
						Permit => Permit,
						ReturnChange => ReturnChange
					);
   -- Clock process definitions
   Clk_process: process
   begin
		clk <= '0';
		wait for 11.6 ns;
		clk <= '1';
		wait for 11.6 ns;
   end process;
   
    -- Stimulus process
   
  -- Stimulius process	
	stim_process: process
	begin
	
		-- insert stimulus here
		
		--TEST CASE 1--
		Input <= "010";
		Wait for 20 NS ;
		
		Input <= "000";
		wait for 20 ns;
		
		Input <= "010";
		WAIT FOR 11.6 NS;

		WAIT FOR 11.6 NS;
		
	    Input <= "000";
	    ASSERT Permit = '1' REPORT "p = 1 fail with test case 0" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 0" SEVERITY WARNING;
		wait for 100 ns;
		
		
-----------------------------------------------------------------------------------------------
        
        --TEST CASE 2--
        Input <= "010";
		Wait for 20 NS ;
		
		Input <= "000";
		wait for 20 ns;
		
		Input <= "100";
		Wait for 20 NS ;
		
		Input <= "000";
		Wait for 20 NS ;

		Input <= "100";	
	    WAIT FOR 20 NS;
		
		Input <= "000";
	    ASSERT Permit = '1' REPORT "p = 1 fail with test case 1" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 1" SEVERITY WARNING;
		Wait for 100 NS ;

-----------------------------------------------------------------------------------------------
		--TEST CASE 3--
		Input <= "001";
		Wait for 20 NS ;
		
		Input <= "000";
	    ASSERT Permit = '1' REPORT "p = 1 fail with test case 3" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 3" SEVERITY WARNING;
		Wait for 100 NS ;
		
		
				
-----------------------------------------------------------------------------------------------
		
		  ---TEST CASE 4-----
        
        --INPUT $10 x 2
	    Input <= "010";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "010";
		Wait for 10 NS ;
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 4" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 4" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
---TEST CASE 5-----
        
        --INPUT $10 x 1 & $5x2  
	    Input <= "010";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "100";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "100";
		Wait for 10 NS ;
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 4" SEVERITY WARNING;
		ASSERT ReturnChange = '0' REPORT "r = 0 fail with test case 4" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
		
---TEST CASE 6-----
        
        --INPUT $10 x 1 & $5x1 & $20 x1  
	    Input <= "010";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "100";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "001";
		Wait for 10 NS ;
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 6" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 0 fail with test case 6" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
        ---TEST CASE 7----
        --INPUT $5 x 1& Cancel_return change  
	    Input <= "100";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "111";
		Wait for 10 NS ;
		ASSERT Permit = '0' REPORT "p = 1 fail with test case 7" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 0 fail with test case 7" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
                
        ---TEST CASE 8----
        --INPUT $10 x 1& Cancel_return change  
	    Input <= "010";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "111";
		Wait for 10 NS ;
		ASSERT Permit = '0' REPORT "p = 1 fail with test case 8" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 0 fail with test case 8" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
        
        ---TEST CASE 9----
        --INPUT $10 x 1 & $5x1 & Cancel_return change  
	    Input <= "010";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "100";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "111";
		Wait for 10 NS ;
		ASSERT Permit = '0' REPORT "p = 1 fail with test case 9" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 0 fail with test case 9" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
        ---TEST CASE 10----
        --INPUT CANCEL NO CASH RETURN 
		
	    Input <= "111";
		Wait for 10 NS ;
		ASSERT Permit = '0' REPORT "p = 1 fail with test case 10" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 0 fail with test case 10" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
        
        ---TEST CASE 11-----
        
        --INPUT $10 x 1 & $5x1 & $10 x1  
	    Input <= "010";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "100";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "010";
		Wait for 10 NS ;
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 11" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 0 fail with test case 11" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
        
               ---TEST CASE 12-----
                --INPUT $10 x 1 & $20x1  
	    Input <= "010";
		Wait for 20 NS ;
		
	    Input <= "000";
		Wait for 20 NS ;
		
	    Input <= "001";
		Wait for 10 NS ;
		ASSERT Permit = '1' REPORT "p = 1 fail with test case 12" SEVERITY WARNING;
		ASSERT ReturnChange = '1' REPORT "r = 0 fail with test case 12" SEVERITY WARNING;
		Wait for 10 NS ;
		
	    Input <= "000";
        Wait for 100 NS ;  
		
				
		
		
		wait;
	end process; 
   
   
END behavior;


















