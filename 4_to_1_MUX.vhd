LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Sel4 IS
	PORT (d3,d2,d1,d0: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			s1,s0: IN std_logic;
			Y: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END Sel4; 

ARCHITECTURE Sel4_beh OF Sel4 IS
BEGIN 
	
	PROCESS(d3,d2,d1,d0,s1,s0)
		BEGIN
			IF(s0 ='0' AND s1='0') THEN 
				Y <=d3;
			ELSIF (s0 ='0' AND s1='1') THEN 
				Y <=d2;
			ELSIF (s0 ='1' AND s1='0') THEN 
				Y <=d1;
			ELSE
				Y <=d0;
			END IF;
	END PROCESS; 

END Sel4_beh;
