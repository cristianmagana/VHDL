----------------------------------------------------------------------
-- EECS31L Assignment 3
-- Locator Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Cristian
-- Student Last Name : Magana
-- Student ID : 37578770
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;


entity Locator_beh  is
    Port ( Start : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Loc : out  STD_LOGIC_VECTOR (15 downto 0);
           Done : out  STD_LOGIC);
end Locator_beh;

architecture Behavioral of Locator_beh  is

   TYPE regArray_type IS 
      ARRAY (0 TO 7) OF std_logic_vector(15 DOWNTO 0); 
   SIGNAL regArray : regArray_type :=  (X"0000", X"000B", X"0008", X"0003", X"0005", X"0000", X"0000", X"0000");     

-- do not modify any code above this line
-- additional variables/signals can be declared if needed below
-- add your code starting here


    TYPE statetype is 
    (start_state,
    calculate_1,
    calculate_2,
    calculate_3,
    end_state);
  signal currentstate, nextstate: statetype;
  

  
begin
    statereg: process(clk)
    begin
        if(clk ='1' and clk'event) then
            if(rst='1') then
                currentstate <= start_state; 
            else 
                currentstate <= nextstate; -- otherwise save the next state
            end if;
        end if;        
    end process;
    

    combLogic : process(currentstate, clk)
    variable temp: std_logic_vector(31 DOWNTO 0):= X"00000000";
    variable temp2: std_logic_vector(31 DOWNTO 0):= X"00000000";
    variable temp3: std_logic_vector(15 DOWNTO 0):= X"0000";
    variable temp4: std_logic_vector(15 DOWNTO 0):= X"0000";
    
    begin
        
        done <= '0';
        --Loc <= X"00000000";
        case currentstate IS
            when start_state =>
                if(clk = '1' AND start='1' AND rst= '0') then
                        Loc<="ZZZZZZZZZZZZZZZZ";
                    nextstate <= calculate_1;
                elsif(clk = '1' AND start='1' AND rst = '1') then
                    Loc<="ZZZZZZZZZZZZZZZZ";
                    nextstate <= currentstate;
                elsif(clk = '1' AND start='0' AND rst = '1') then
                    Loc<="ZZZZZZZZZZZZZZZZ";
                    nextstate <= currentstate; 
                elsif(clk = '1' AND start='0' AND rst = '0') then
                    Loc<="ZZZZZZZZZZZZZZZZ";              
                    nextstate <= currentstate; 
                end if;
               when calculate_1 =>
                     temp := regArray(1) * regArray(2);
                     temp3 := temp(15 downto 0);
                     temp2 := regArray(2) * temp3;
                     temp4 := temp2(15 downto 0);
                     regArray(5) <= '0' & temp4(15 downto 1); 
                    Loc<="ZZZZZZZZZZZZZZZZ";                   
                    nextstate <= calculate_2;
               when calculate_2 =>
                    temp := regArray(2) * regArray(3);
                    regArray(6) <= temp(15 downto 0);    
                  Loc<="ZZZZZZZZZZZZZZZZ";
                  nextstate <= calculate_3;                                            
               when calculate_3 =>
                   regArray(7) <=  regArray(5) + regArray(6) + regArray(4);
                    Loc<="ZZZZZZZZZZZZZZZZ";                
                    nextstate <= end_state;
               when end_state =>
                    Loc <= regArray(7);
                    Done <= '1';
                    nextstate<=start_state;
        end case;
    end process;    
end Behavioral;

