LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TestBench IS
END TestBench;

ARCHITECTURE TBarch of TestBench IS
	COMPONENT Sel4 IS
		PORT (d3,d2,d1,d0: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				s1,s0: IN std_logic;
				Y: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
				
	END COMPONENT;
	
	SIGNAL d3_s, d2_s, d1_s, d0_s, Y_s : std_logic_vector (3 DOWNTO 0) := "0000"; 
	SIGNAL s1_s, s0_s: std_logic := '0';
	
	BEGIN
		uut: Sel4 PORT MAP(d3 => d3_s,d2 => d2_s,d1=>d1_s,d0=>d0_s,s1=>s1_s,s0=>s0_s,Y=>Y_s);
		

		
		PROCESS
		BEGIN	
			d3_s<= "0000"; d2_s<="0001"; d1_s<="0010";d0_s<="0011";s1_s<='0';s0_s<='0';
			WAIT FOR 10 ns;
			d3_s<= "0000"; d2_s<="0001"; d1_s<="0010";d0_s<="0011";s1_s<='0';s0_s<='1';
			WAIT FOR 10 ns;
			d3_s<= "0000"; d2_s<="0001"; d1_s<="0010";d0_s<="0011";s1_s<='1';s0_s<='0';
			WAIT FOR 10 ns;
			d3_s<= "0000"; d2_s<="0001"; d1_s<="0010";d0_s<="0011";s1_s<='1';s0_s<='1';
			WAIT FOR 10 ns;
			WAIT;
		END PROCESS;
	END TBarch;
