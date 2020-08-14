#VHDL

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY TestBench IS
END TestBench;

ARCHITECTURE tb of TestBench IS
	COMPONENT FourBit_FourToOne IS 
       PORT (Xi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
             Yi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
             Wi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
             Zi: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
             Si, Sx: IN std_logic;
             F: OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    
    SIGNAL A, B, C,D, Fx: std_logic_vector (3 downto 0);
    SIGNAL Ci,Cx: std_logic;
BEGIN
          uut: FourBit_FourToOne PORT MAP (Xi => A, Yi => B, Wi => C, Zi => D, F => Fx, Si => Ci, Sx => Cx); 

       tb: process
        BEGIN
            A <= "0000"; B <= "0011"; C<= "1100"; D<="1000"; CI <= '0'; CX<= '0';
            WAIT FOR 9.6 NS;
            A <= "0000"; B <= "0011"; C<= "1100"; D<="1000";CI <= '0'; CX<= '1';
            WAIT FOR 9.6 NS;
            A <= "0000"; B <= "0011"; C<= "1100"; D<="1000"; CI <= '1'; CX<= '0';
            WAIT FOR 9.6 NS;
            A <= "0000"; B <= "0011"; C<= "1100"; D<="1000"; CI <= '1'; CX<= '1';
            WAIT FOR 9.6 NS;
			WAIT;
		END PROCESS;
	END tb;
