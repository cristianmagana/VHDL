----------------------------------------------------------------------
-- EECS31L Assignment4 DCT
-- Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Cristian 
-- Student Last Name : Magana
-- Student ID : ------------
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity DCT_beh is
        port (
                Clk :           in std_logic;
                Start :         in std_logic;
                Din :           in INTEGER;
                Done :          out std_logic;
                Dout :          out INTEGER
              );
end DCT_beh;

architecture behavioral of DCT_beh is

begin
        process
                type RF is array ( 0 to 7, 0 to 7 ) of INTEGER;
                --------------------------------------------------
                --you may modify below variables or declare new ones  
                --for the behavioral model
                --------------------------------------------------				
                variable i, j, k        : INTEGER;
                variable InBlock        : RF;
                variable COSBlock       : RF;
                variable TempBlock      : RF;
                variable OutBlock       : RF;
                variable A, B, P, Sum   : INTEGER; 

        begin
                -------------------------------
                -- Initialize parameter matrix
                -------------------------------
                COSBlock := ( 
        ( 125,  122,    115,    103,    88,     69,     47,     24  ),
        ( 125,  103,    47,     -24,    -88,    -122,   -115,   -69  ),
        ( 125,  69,     -47,    -122,   -88,    24,     115,    103  ),
        ( 125,  24,     -115,   -69,    88,     103,    -47,    -122  ),
        ( 125,  -24,    -115,   69,     88,     -103,   -47,    122  ),
        ( 125,  -69,    -47,    122,    -88,    -24,    115,    103  ),
        ( 125,  -103,   47,     24,     -88,    122,    -115,   69  ),
        ( 125,  -122,   115,    -103,   88,     -69,    47,     -24  )
                        );
        ---HANDSHAKING---            
        wait until Start = '1';
        Done <= '0';

        ---READ INPUT DATA---
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                wait until Clk = '1';
                InBlock(i,j):= Din;
            end loop;
        end loop;


        ---Burger * CosBlock---
        Sum := 0;
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                Sum := 0;
                for k in 0 to 7 loop
                    A := CosBlock(i,k);
                    B := InBlock(k,j);
                    P := A * B;
                    if(k=0) then
                        Sum := 0;
                    end if;
                    Sum := Sum + P;                       
                    if(k = 7) then
                        TempBlock( i, j ) := Sum;
                    end if;
                end loop;
            end loop;
        end loop;


        --- (Burger*CosBlock)* (Burger*CosBlock)^T---
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                Sum :=0;
                for k in 0 to 7 loop
                    A := COSBlock(j,k);
                    B := TempBlock(i,j);
                    P := A * B;
                    if(k=0) then
                        Sum := 0;
                    end if;
                    Sum := Sum + P;
                    if( k = 7 ) then
                            OutBlock( i, j ) := Sum;
                    end if;
                end loop;
            end loop;
        end loop;

        wait until Clk = '1';
        Done <= '1';

        ---------OUTPUT------
        for i in 0 to 7 loop
            for j in 0 to 7 loop
                wait until Clk = '1';
                Done <= '0';
                Dout <= OutBlock( i, j );
            end loop;
        end loop;
end process;
   

end behavioral;
