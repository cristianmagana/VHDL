--------------------------------------------------------------------------------
-- Company: QV's Minions 
-- Engineer: Cristian Magana
--
-- Create Date:   09/06/2020
-- Design Name:   
-- Module Name:   
-- Project Name:  Lab_4B_TB
-- Target Device: DCT 
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DCT_str
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
USE std.textio.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_beh IS
END tb_beh;
 
ARCHITECTURE behavior OF tb_beh IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DCT_beh
    PORT(
         Clk : IN  std_logic;
         Start : IN  std_logic;
         Din : IN  integer;
         Done : OUT  std_logic;
         Dout : OUT  integer
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Start : std_logic := '0';
   signal Din : integer := 0;

 	--Outputs
   signal Done : std_logic;
   signal Dout : integer;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DCT_beh PORT MAP (
          Clk => Clk,
          Start => Start,
          Din => Din,
          Done => Done,
          Dout => Dout
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/4;
		Clk <= '1';
		wait for Clk_period/4;
   end process;

	-- Feel free to modify any code below; this is just a template   

    Start <= '0' after 0 ns,
             '1' after 50 ns,
             '0' after 100 ns;


   -- Stimulus process
   stim_proc: process
		          variable stringbuff : LINE;
					 variable a:integer:= 1;
                type RF is array ( 0 to 7, 0 to 7 ) of INTEGER;

                 --- Results for A*A^t-----
                  variable Result : RF := (
     
(56195370, -11595870, 14515110, -1054170, 9325350, 19218330, 6568290, 4622130),
(7775460, -1604460, 2008380, -145860, 1290300, 2659140, 908820, 639540),
(72806580, -15023580, 18805740, -1365780, 12081900, 24899220, 8509860, 5988420),
(-3534300, 729300, -912900, 66300, -586500, -1208700, -413100, -290700),
(31101840, -6417840, 8033520, -583440, 5161200, 10636560, 3635280, 2558160),
(48419910, -9991410, 12506730, -908310, 8035050, 16559190, 5659470, 3982590),
(-4241160, 875160, -1095480, 79560, -703800, -1450440, -495720, -348840),
(4594590, -948090, 1186770, -86190, 762450, 1571310, 537030, 377910)

);
     
        begin
		       	WRITE (stringbuff, string'("Starts Structural Simulation at "));
		      	WRITE (stringbuff, now);
			    WRITELINE (output, stringbuff);

                --- Initiates Process, i.e.; Handshake--- 
                wait until Start =  '1';

                --- Reads input, stares with buns 0-15 --- 
                for i in 0 to 7 loop
                       wait until Clk = '0';
                        Din <= 255;
                end loop;
                                
                 for i in 8 to 15 loop
                        wait until Clk = '0';
                        Din <= 255;
                end loop;
                
                --- Read cheese and meat 16 - 47 --- 
                for i in 16 to 23 loop
                        wait until Clk = '0';
                        Din <= 0;
                end loop;
                
                for i in 24 to 31 loop
                        wait until Clk = '0';
                        Din <= 0;
                end loop;

                for i in 32 to 39 loop
                        wait until Clk = '0';
                        Din <= 0;
                end loop;
                 
                for i in 40 to 47 loop
                        wait until Clk = '0';
                        Din <= 0;
                end loop;

                --- Reads bottoms buns --- 
                for i in 48 to 55 loop
                        wait until Clk = '0';
                        Din <= 255;
                end loop;              
                                
                for i in 56 to 63 loop
                        wait until Clk = '0';
                        Din <= 255;
                end loop;
                
                Din <= 0;
             
                --- OUTPUTS DONE --- 
                wait until Done = '1';
				wait for 5 ns;
                wait until Clk = '1' AND Clk'EVENT; 

				---VERIFYS RESULTS--- 
				-- check output values / you can check at the edge or anywhere in the clock cycle
				-- your code here
				
				for i in 0 to 7 loop
                    for j in 0 to 7 loop
                        wait until Clk = '0';
                        assert (Dout = Result(i, j)) 
			             REPORT "error: incorrect output"
			              SEVERITY warning;   
                    end loop;
                end loop;

				-- for each clock cycle now, start comparing values
				WRITE (stringbuff, string'("Verification completed. Simulation Ends at "));
				WRITE (stringbuff, now);
				WRITELINE (output, stringbuff);
				wait;
        end process;

END;
