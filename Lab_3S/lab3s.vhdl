----------------------------------------------------------------------
-- EECS31L Assignment 3
-- Locator Structural Model
----------------------------------------------------------------------
-- Student First Name : Cristian
-- Student Last Name : Magana
-- Student ID : 37578770
----------------------------------------------------------------------

---------- Components library ----------

---------- 8x16 Register File ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegFile IS
   PORT (R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
         R_en, W_en: IN std_logic;
         Reg_Data1 : OUT std_logic_vector(15 DOWNTO 0); 
			Reg_Data2 : OUT std_logic_vector(15 DOWNTO 0); 
         W_Data: IN std_logic_vector(15 DOWNTO 0); 
         Clk, Rst: IN std_logic);
END RegFile;

ARCHITECTURE Beh OF RegFile IS 
   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type;
BEGIN
   WriteProcess: PROCESS(Clk)    
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            regArray(0) <= X"0000" AFTER 6.0 NS;
            regArray(1) <= X"000B" AFTER 6.0 NS;
            regArray(2) <= X"0008" AFTER 6.0 NS;
            regArray(3) <= X"0003" AFTER 6.0 NS;
            regArray(4) <= X"0005" AFTER 6.0 NS;
            regArray(5) <= X"0000" AFTER 6.0 NS;
            regArray(6) <= X"0000" AFTER 6.0 NS;
            regArray(7) <= X"0000" AFTER 6.0 NS;
         ELSE
            IF (W_en = '1') THEN
                regArray(conv_integer(W_Addr)) <= W_Data AFTER 6.0 NS;
                END IF;
        END IF;
     END IF;
   END PROCESS;
            
   ReadProcess1: PROCESS(R_en, R_Addr1, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr1 IS
            WHEN "000" =>
                Reg_Data1 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data1 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data1 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data1 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data1 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data1 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data1 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data1 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data1 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
	
	ReadProcess2: PROCESS(R_en, R_Addr2, regArray)
   BEGIN
      IF (R_en = '1') THEN
        CASE R_Addr2 IS
            WHEN "000" =>
                Reg_Data2 <= regArray(0) AFTER 6.0 NS;
            WHEN "001" =>
                Reg_Data2 <= regArray(1) AFTER 6.0 NS;
            WHEN "010" =>
                Reg_Data2 <= regArray(2) AFTER 6.0 NS;
            WHEN "011" =>
                Reg_Data2 <= regArray(3) AFTER 6.0 NS;
            WHEN "100" =>
                Reg_Data2 <= regArray(4) AFTER 6.0 NS;
            WHEN "101" =>
                Reg_Data2 <= regArray(5) AFTER 6.0 NS;
            WHEN "110" =>
                Reg_Data2 <= regArray(6) AFTER 6.0 NS;
            WHEN "111" =>
                Reg_Data2 <= regArray(7) AFTER 6.0 NS;
            WHEN OTHERS =>
                Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
        END CASE;
      ELSE
        Reg_Data2 <= (OTHERS=>'0') AFTER 6.0 NS;
      END IF;
   END PROCESS;
END Beh;


---------- 16-Bit ALU ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


ENTITY ALU IS
    PORT (Sel: IN std_logic;
            A: IN std_logic_vector(15 DOWNTO 0);
            B: IN std_logic_vector(15 DOWNTO 0);
            ALU_Out: OUT std_logic_vector (15 DOWNTO 0) );
END ALU;

ARCHITECTURE Beh OF ALU IS

BEGIN
    PROCESS (A, B, Sel)
         variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
    BEGIN
        IF (Sel = '0') THEN
            ALU_Out <= A + B AFTER 12 NS;                
        ELSIF (Sel = '1') THEN
            temp := A * B ;
                ALU_Out <= temp(15 downto 0) AFTER 12 NS; 
        END IF;
          
    END PROCESS;
END Beh;


---------- 16-bit Shifter ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Shifter IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         sel: IN std_logic );
END Shifter;

ARCHITECTURE Beh OF Shifter IS 
BEGIN
   PROCESS (I,sel) 
   BEGIN
         IF (sel = '1') THEN 
            Q <= I(14 downto 0) & '0' AFTER 4.0 NS;
         ELSE
            Q <= '0' & I(15 downto 1) AFTER 4.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 2-to-1 Selector ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Selector IS
   PORT (sel: IN std_logic;
         x,y: IN std_logic_vector(15 DOWNTO 0);
         f: OUT std_logic_vector(15 DOWNTO 0));
END Selector;

ARCHITECTURE Beh OF Selector IS 
BEGIN
   PROCESS (x,y,sel)
   BEGIN
         IF (sel = '0') THEN
            f <= x AFTER 3.0 NS;
         ELSE
            f <= y AFTER 3.0 NS;
         END IF;   
   END PROCESS; 
END Beh;


---------- 16-bit Register ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg IS
   PORT (I: IN std_logic_vector(15 DOWNTO 0);
         Q: OUT std_logic_vector(15 DOWNTO 0);
         Ld: IN std_logic; 
         Clk, Rst: IN std_logic );
END Reg;

ARCHITECTURE Beh OF Reg IS 
BEGIN
   PROCESS (Clk)
   BEGIN
      IF (Clk = '1' AND Clk'EVENT) THEN
         IF (Rst = '1') THEN
            Q <= X"0000" AFTER 4.0 NS;
         ELSIF (Ld = '1') THEN
            Q <= I AFTER 4.0 NS;
         END IF;   
      END IF;
   END PROCESS; 
END Beh;

---------- 16-bit Three-state Buffer ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ThreeStateBuff IS
    PORT (Control_Input: IN std_logic;
          Data_Input: IN std_logic_vector(15 DOWNTO 0);
          Output: OUT std_logic_vector(15 DOWNTO 0) );
END ThreeStateBuff;

ARCHITECTURE Beh OF ThreeStateBuff IS
BEGIN
    PROCESS (Control_Input, Data_Input)
    BEGIN
        IF (Control_Input = '1') THEN
            Output <= Data_Input AFTER 2 NS;
        ELSE
            Output <= (OTHERS=>'Z') AFTER 2 NS;
        END IF;
    END PROCESS;
END Beh;

---------- Controller ----------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Controller IS
    PORT(R_en: OUT std_logic;
         W_en: OUT std_logic;
         R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
		 R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
         W_Addr: OUT std_logic_vector(2 DOWNTO 0);
         Shifter_Sel: OUT std_logic;
         Selector_Sel: OUT std_logic;
         ALU_sel : OUT std_logic;
         OutReg_Ld: OUT std_logic;
         Oe: OUT std_logic;
         Done: OUT std_logic;
         Start, Clk, Rst: IN std_logic); 
END Controller;


ARCHITECTURE Beh OF Controller IS

--TYPE statetype is 
 --  (start_state, cal_at, cal_at_w, cal_att, cal_att_w,cal_atth, cal_atth_w, cal_vot, cal_vot_w, 
	--	cal_aPv, cal_aPv_w, cal_avPx, cal_avPx_w,end_state);
  --signal currentstate, nextstate: statetype;
  
  SIGNAL CurrentState, NextState: std_logic_vector (3 downto 0) := "0000";
BEGIN
    statereg: process(clk)
    begin
        if(clk ='1' and clk'event) then
            if(rst='1') then
                currentstate <= "0000" after 4 NS; 
            else 
                currentstate <= nextstate after 4 ns; -- otherwise save the next state
            end if;
        end if;        
    end process;
	
	combLogic : process(currentstate, clk)
    begin
        case currentstate IS
            when "0000"=>
                if(clk = '1' AND start='1' AND rst= '0') then
                    R_en <= '0' after 11 ns;
					W_en<= '0' after 11 ns;
					R_Addr1<= "000" after 11 ns;
					R_Addr2 <= "000" after 11 ns;
				    W_Addr <= "000" after 11 ns;
					Shifter_Sel  <= '0' after 11 ns;
					Selector_Sel <= '0' after 11 ns;
					ALU_sel <= '0' after 11 ns;
					OutReg_Ld <= '0' after 11 ns;
					Oe <= '0' after 11 ns;
					Done <= '0' after 11 ns;
                    nextstate <= "0001" after 11 ns;
                end if;                
			when "0001" => 
				--if(clk = '1' AND start='0' AND rst= '0') then
				
					R_en <= '1' after 11 ns;
					W_en<= '0' after 11 ns;
					R_Addr1<= "001" after 11 ns;
					R_Addr2 <= "010" after 11 ns;
				    W_Addr <= "000" after 11 ns;
					Shifter_Sel  <= '1' after 11 ns;
					Selector_Sel <= '1' after 11 ns;
					ALU_sel <= '1' after 11 ns;
					OutReg_Ld <= '0' after 11 ns;
					Oe <= '0' after 11 ns;
					Done <= '0' after 11 ns;
					nextstate <= "0010" after 11 ns;

			when "0010" =>
				--if(clk = '1' AND start='0' AND rst= '0') then
					 R_en <= '1' after 11 ns;
					 W_en<= '1' after 11 ns;
					R_Addr1<= "001" after 11 ns;
					R_Addr2 <= "010" after 11 ns;
					 W_Addr <= "101"after 11 ns;
					 Shifter_Sel  <= '1' after 11 ns;
					 Selector_Sel <= '1' after 11 ns;
					 ALU_sel <= '1' after 11 ns;
					 OutReg_Ld <= '0' after 11 ns;
					 Oe <= '0' after 11 ns;
					 Done <= '0' after 11 ns; 	
					nextstate <= "0011" after 11 ns;

			when "0011" =>
               --  if(clk = '1' AND start='0' AND rst= '0') then
                         R_en <= '1' after 11 ns;
                         W_en<= '0' after 11 ns;
                         R_Addr1<= "010" after 11 ns;
                         R_Addr2 <= "101" after 11 ns;
                         W_Addr <= "101" after 11 ns;
                         Shifter_Sel  <= '1' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '1' after 11 ns;
                         OutReg_Ld <= '0' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns; 	
                        nextstate <= "0100" after 11 ns;
 
			when "0100" =>
			
			             R_en <= '1' after 11 ns;
                         W_en<= '1' after 11 ns;
                         R_Addr1<= "010" after 11 ns;
                         R_Addr2 <= "101" after 11 ns;
                         W_Addr <= "101" after 11 ns;
                         Shifter_Sel  <= '1' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '1' after 11 ns;
                         OutReg_Ld <= '0' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns; 	
                        nextstate <= "0101" after 11 ns;

			when "0101" =>
			
			             R_en <= '1' after 11 ns;
                         W_en<= '0' after 11 ns;
                         R_Addr1<= "000" after 11 ns;
                         R_Addr2 <= "101" after 11 ns;
                         W_Addr <= "101" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '0' after 11 ns;
                         ALU_sel <= '1' after 11 ns;
                         OutReg_Ld <= '0' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns;	
                        nextstate <= "0110" after 11 ns;

			when "0110" => --cal_atth_w
			             R_en <= '1' after 11 ns;
                         W_en<= '1' after 11 ns;
                         R_Addr1<= "000" after 11 ns;
                         R_Addr2 <= "101" after 11 ns;
                         W_Addr <= "101" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '0' after 11 ns;
                         ALU_sel <= '1' after 11 ns;
                         OutReg_Ld <= '0' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns; 	
                        nextstate <= "0111" after 11 ns;
			
			when "0111" => --cal_vot	
			             R_en <= '1' after 11 ns;
                         W_en<= '0' after 11 ns;
                         R_Addr1<= "011" after 11 ns;
                         R_Addr2 <= "010" after 11 ns;
                         W_Addr <= "110" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '1' after 11 ns;
                         OutReg_Ld <= '0' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns;	
                        nextstate <= "1000" after 11 ns;
										
			when "1000" => --cal_vot_w
			             R_en <= '1' after 11 ns;
                         W_en<= '1' after 11 ns;
                         R_Addr1<= "011" after 11 ns;
                         R_Addr2 <= "010" after 11 ns;
                         W_Addr <= "110" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '1' after 11 ns;
                         OutReg_Ld <= '0' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns;	
                        nextstate <= "1001" after 11 ns;
                        
                        
			when "1001"=> --cal_aPv =>
			
			             R_en <= '1' after 11 ns;
                         W_en<= '0' after 11 ns;
                         R_Addr1<= "101" after 11 ns;
                         R_Addr2 <= "110" after 11 ns;
                         W_Addr <= "111" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '0' after 11 ns;
                         OutReg_Ld <= '0' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns; 	
                        nextstate <= "1010" after 11 ns;

			when "1010"=> --cal_aPv_w => --state 10
			
			             R_en <= '1' after 11 ns;
                         W_en<= '1' after 11 ns;
                         R_Addr1<= "101" after 11 ns;
                         R_Addr2 <= "110" after 11 ns;
                         W_Addr <= "111" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '0' after 11 ns;
                         OutReg_Ld <= '1' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns; 	
                        nextstate <= "1011" after 11 ns;
				 
			when "1011"=>--cal_avPx => -- state 11
			             R_en <= '1' after 11 ns;
                         W_en<= '0' after 11 ns;
                         R_Addr1<= "111" after 11 ns;
                         R_Addr2 <= "100" after 11 ns;
                         W_Addr <= "110" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '0' after 11 ns;
                         OutReg_Ld <= '1' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns;	
						 nextstate <= "1100" after 11 ns;								
			when "1100"=>  --cal_avPx_w => --state 12
			   			 R_en <= '1' after 11 ns;
                         W_en<= '1' after 11 ns;
                         R_Addr1<= "111" after 11 ns; 
                         R_Addr2 <= "100" after 11 ns;
                         W_Addr <= "110" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '0' after 11 ns;
                         OutReg_Ld <= '1' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0' after 11 ns; 	
						 nextstate <= "1101" after 11 ns;
			when "1101"=>  --end_state => -- state 13 
			             R_en <= '1' after 11 ns;
                         W_en<= '1' after 11 ns;
                         R_Addr1<= "111" after 11 ns;
                         R_Addr2 <= "100" after 11 ns;
                         W_Addr <= "111" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '0' after 11 ns;
                         OutReg_Ld <= '1' after 11 ns;
                         Oe <= '1' after 11 ns;
                         Done <= '1' after 11 ns; 	
						 nextstate <= "1110" after 11 ns;
			when "1110" =>--end_state => -- state 14
			             R_en <= '0' after 11 ns;
                         W_en<= '0' after 11 ns;
                         R_Addr1<= "110" after 11 ns;
                         R_Addr2 <= "100" after 11 ns;
                         W_Addr <= "111" after 11 ns;
                         Shifter_Sel  <= '0' after 11 ns;
                         Selector_Sel <= '1' after 11 ns;
                         ALU_sel <= '0' after 11 ns;
                         OutReg_Ld <= '1' after 11 ns;
                         Oe <= '0' after 11 ns;
                         Done <= '0';
						 nextstate <= "0000" after 11 ns;

            when others =>
                     R_en <= '0' after 11 ns;
					W_en<= '0' after 11 ns;
					R_Addr1<= "000" after 11 ns;
					R_Addr2 <= "000" after 11 ns;
				    W_Addr <= "000" after 11 ns;
					Shifter_Sel  <= '0' after 11 ns;
					Selector_Sel <= '0' after 11 ns;
					ALU_sel <= '0' after 11 ns;
					OutReg_Ld <= '0' after 11 ns;
					Oe <= '0' after 11 ns;
					Done <= '0' after 11 ns;
                    nextstate <= "0000" after 11 ns;

        end case;
    end process;    

-------------------------------------------------------
-- Hint:
-- Controller shall consist of a CombLogic process 
-- containing case-statement and a StateReg process.
--      
-------------------------------------------------------

 -- add your code here

END Beh;


---------- Locator (with clock cycle =  ?? NS )----------
--         INDICATE YOUR CLOCK CYCLE TIME ABOVE      ----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Locator_struct is
    Port ( Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0) := "ZZZZZZZZZZZZZZZZ";
           Done : out  STD_LOGIC);
end Locator_struct;

architecture Struct of Locator_struct is
    
    COMPONENT RegFile IS
        PORT (  R_Addr1, R_Addr2, W_Addr: IN std_logic_vector(2 DOWNTO 0);
                R_en, W_en: IN std_logic;
                Reg_Data1: OUT std_logic_vector(15 DOWNTO 0); 
				Reg_Data2: OUT std_logic_vector(15 DOWNTO 0);
                W_Data: IN std_logic_vector(15 DOWNTO 0); 
                Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ALU IS
        PORT (Sel: IN std_logic;
                A: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
                ALU_Out: OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
    END COMPONENT;

    COMPONENT Shifter IS
         PORT (I: IN std_logic_vector(15 DOWNTO 0);
               Q: OUT std_logic_vector(15 DOWNTO 0);
               sel: IN std_logic );
    END COMPONENT;

    COMPONENT Selector IS
        PORT (sel: IN std_logic;
              x,y: IN std_logic_vector(15 DOWNTO 0);
              f: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
   
    COMPONENT Reg IS
        PORT (I: IN std_logic_vector(15 DOWNTO 0);
              Q: OUT std_logic_vector(15 DOWNTO 0);
              Ld: IN std_logic; 
              Clk, Rst: IN std_logic );
    END COMPONENT;
    
    COMPONENT ThreeStateBuff IS
        PORT (Control_Input: IN std_logic;
              Data_Input: IN std_logic_vector(15 DOWNTO 0);
              Output: OUT std_logic_vector(15 DOWNTO 0) );
    END COMPONENT;
    
    COMPONENT Controller IS
       PORT(R_en: OUT std_logic;
            W_en: OUT std_logic;
            R_Addr1: OUT std_logic_vector(2 DOWNTO 0);
			R_Addr2: OUT std_logic_vector(2 DOWNTO 0);
            W_Addr: OUT std_logic_vector(2 DOWNTO 0);
            Shifter_sel: OUT std_logic;
            Selector_sel: OUT std_logic;
            ALU_sel : OUT std_logic;
            OutReg_Ld: OUT std_logic;
            Oe: OUT std_logic;
            Done: OUT std_logic;
            Start, Clk, Rst: IN std_logic); 
     END COMPONENT;

-- do not modify any code above this line
-- add signals needed below. hint: name them something you can keep track of while debugging/testing
-- add your code starting here

    --COMPONENT SIGNALS
    SIGNAL RenSignal,WenSignal, shiftSelSignal,SelectorSignal, ALU_SelSignal, OutRegSignal, OeSignal: std_logic;
    SIGNAL RAddr1Signal, RAddr2Signal, WAddrSignal: std_logic_vector(2 DOWNTO 0);
    
    -- REGFILE SIGNALS
    SIGNAL RegData1_Signal, RegData2_Signal : std_logic_vector(15 DOWNTO 0); 
    
    --ALU SIGNAL
    SIGNAL ALU_OutSignal: std_logic_vector(15 DOWNTO 0); 
    
    --SHIFTER SIGNAL
    SIGNAL ShifterOutSignal: std_logic_vector(15 DOWNTO 0); 
    
    --SELECTOR OUT SIGNAL
    SIGNAL SelectorOutSignal: std_logic_vector(15 DOWNTO 0); 
    
    --OUTREG SIGNAL
    SIGNAL OutRegOutSignal:  std_logic_vector(15 DOWNTO 0);
     
BEGIN
    Controller_2: Controller PORT MAP(Start => Start, Clk => Clk, Rst => Rst, Done => Done,
    R_en => RenSignal, W_en => WenSignal, R_Addr1 => RAddr1Signal, R_Addr2 => RAddr2Signal, W_Addr => WAddrSignal, 
    Selector_sel => SelectorSignal, Shifter_sel => shiftSelSignal, ALU_sel => ALU_SelSignal, OutReg_Ld => OutRegSignal, Oe => OeSignal);
    
    RegFile_2: RegFile Port Map(R_Addr1 => RAddr1Signal, R_Addr2 => RAddr2Signal, W_Addr => WAddrSignal, R_en => RenSignal,
     W_en => WenSignal, Reg_Data1 => RegData1_Signal, Reg_Data2 => RegData2_Signal , W_Data =>SelectorOutSignal, Clk => Clk, Rst => Rst);
    
    ALU_2: ALU PORT MAP(A => RegData1_Signal, B => RegData2_Signal, Sel => ALU_SelSignal, ALU_Out => ALU_OutSignal); 
    
    Shiter_2: Shifter PORT MAP(I => RegData2_Signal, sel => shiftSelSignal, Q => ShifterOutSignal);
    
    Selector_2: Selector PORT MAP(sel => SelectorSignal, y => ALU_OutSignal, x => ShifterOutSignal, f=> SelectorOutSignal );
    
    Reg_2: Reg PORT MAP (I => SelectorOutSignal, Ld =>  OutRegSignal, Clk => Clk, Rst => Rst, Q=> OutRegOutSignal); 
    
    ThreeStateBuffer_2: ThreeStateBuff PORT MAP (Control_Input => OeSignal, Data_Input => OutRegOutSignal, Output => Loc);
    
end Struct;

