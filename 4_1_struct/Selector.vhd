# VHDL

--------------------------------------------
----------DEFINES MY CORE COMPONENTS--------
--------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY And2 IS
	PORT (a,b: IN std_logic;
		  F: OUT std_logic);
END And2;
ARCHITECTURE And2_beh OF And2 IS
BEGIN
	PROCESS (a,b)
	BEGIN
		F <= (a AND b) AFTER 2.4 NS;
	END PROCESS;
END And2_beh;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Or2 IS 
	PORT (a,b: std_logic;
		  F: OUT std_logic);
END Or2;
ARCHITECTURE Or2_beh OF Or2 IS
BEGIN
	PROCESS (a,b)
	BEGIN
		F <= (a OR b) AFTER 2.4 NS;
	END PROCESS;
END Or2_beh;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Inv IS
	PORT (a: IN std_logic;
	      F: OUT std_logic);
END Inv;
ARCHITECTURE Inv_beh OF Inv IS
BEGIN
	PROCESS (a)
	BEGIN
		F <= NOT a AFTER 1.0 NS;
	END PROCESS;
END Inv_beh;
--------------------------------------------
--------CREATES 1-BIT 4:1 Selector----------
--------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TwoToOne IS
   PORT (d1, d0 : IN STD_LOGIC;
         s0: IN std_logic;
         Y: OUT STD_LOGIC);
END TwoToOne;  

ARCHITECTURE TwoToOne_struct OF TwoToOne IS
	COMPONENT And2 IS
		PORT (a,b: IN std_logic;
				F: OUT std_logic);
	END COMPONENT;
	COMPONENT Or2 IS
		PORT (a,b: IN std_logic;
				F: OUT std_logic);
	END COMPONENT;
	COMPONENT Inv IS
		PORT (a: IN std_logic; 
				F: OUT std_logic);
	END COMPONENT;
	SIGNAL s0_inv,w1,w2,w3 : std_logic;
	
BEGIN
		Inv_s0: Inv PORT MAP(a => s0, F => s0_inv);
		AND2_1: And2 PORT MAP(a=>d0,b=>s0_inv,F=>w1);
		AND2_2: And2 PORT MAP(a=>d1,b=>s0,F=>w2);
		Or2_1:  Or2  PORT MAP(a=>w1,b=>w2,F=>Y);
		
END TwoToOne_struct;
-------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FourBit_FourToOne IS 
   PORT (Xi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
         Yi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
         Wi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
         Zi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
         Si, Sx: IN std_logic;
         F: OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END FourBit_FourToOne;  

ARCHITECTURE FourBit_FourToOne_struct OF FourBit_FourToOne IS

	COMPONENT TwoToOne IS
		PORT (d1, d0: IN STD_LOGIC;
         s0: IN std_logic;
         Y: OUT STD_LOGIC);  
    END COMPONENT; 
  
    
    SIGNAL w1,w2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    
BEGIN
    sel_x0: TwoToOne PORT MAP (d0 => Xi(0), d1 => Yi(0), s0 => Si, Y => w1(0));
    sel_y0: TwoToOne PORT MAP (d0=> wi(0), d1 => zi(0), s0 => Si, Y => w2(0));
    sel_F0: TwoToOne PORT MAP (d0=> w1(0), d1=> w2(0), s0 => Sx, Y => F(0));
    
    
    sel_x1: TwoToOne PORT MAP (d0=> Xi(1), d1=> Yi(1), s0 => Si, Y => w1(1));
    sel_y1: TwoToOne PORT MAP (d0=> wi(1), d1=> zi(1), s0 => Si, Y => w2(1));
        
    sel_x2: TwoToOne PORT MAP (d0=> Xi(2), d1=> Yi(2), s0 => Si, Y => w1(2));
    sel_y2: TwoToOne PORT MAP (d0=> wi(2), d1=> zi(2), s0 => Si, Y => w2(2));
        
    sel_x3: TwoToOne PORT MAP (d0=> Xi(3), d1=> Yi(3), s0 => Si, Y => w1(3));
    sel_y3: TwoToOne PORT MAP (d0=> wi(3), d1=> zi(3), s0 => Si, Y => w2(3));


    sel_F1: TwoToOne PORT MAP (d0=> w1(1), d1=> w2(1), s0 => Sx, Y => F(1));
    sel_F2: TwoToOne PORT MAP (d0=> w1(2), d1=> w2(2), s0 => Sx, Y => F(2));
    sel_F3: TwoToOne PORT MAP (d0=> w1(3), d1=> w2(3), s0 => Sx, Y => F(3));    
    
    
  --  sel_x0: TwoToOne_1 PORT MAP (a => Xi(0), b => Yi(0),s0 => Si, Y => w1);
  --  sel_y0: TwoToOne_2 PORT MAP (c => Xi(0), d => Yi(0), s0 => Si, Y1 => w2);
  --  sel_F_0: TwoToOne_1 PORT MAP (a => w1, b => w2, s0 => Sx, Y=> F(0));
    
 --   sel_x1: TwoToOne_1 PORT MAP (a => Xi(1), b => Yi(1),s0 => Si, Y => w1); 
 --   sel_y1: TwoToOne_2 PORT MAP (c => Xi(1), d => Yi(1), s0 => Si, Y1 => w2);
--sel_F_1: TwoToOne_1 PORT MAP (a => w1, b => w2, s0 => Sx, Y=> F(1));

 --   sel_x2: TwoToOne_1 PORT MAP (a => Xi(2), b => Yi(2),s0 => Si, Y => w1); 
 --   sel_y2: TwoToOne_2 PORT MAP (c => Xi(2), d => Yi(2), s0 => Si, Y1 => w2);
 --   sel_F_2: TwoToOne_1 PORT MAP (a => w1, b => w2, s0 => Sx, Y=> F(2));
    
   -- sel_x3: TwoToOne_1 PORT MAP (a => Xi(3), b => Yi(3),s0 => Si, Y => w1); 
--    sel_y3: TwoToOne_2 PORT MAP (c => Xi(3), d => Yi(3), s0 => Si, Y1 => w2);
 --  sel_F_3: TwoToOne_1 PORT MAP (a => w1, b => w2, s0 => Sx, Y=> F(3));
    
END FourBit_FourToOne_struct; 

