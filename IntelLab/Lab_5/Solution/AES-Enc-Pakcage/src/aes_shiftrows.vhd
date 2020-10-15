

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.AES_pkg.all;

entity AES_ShiftRows is
    port(
        input 		: in  t_AES_state;
        output 		: out t_AES_state
    );
end AES_ShiftRows;

-------------------------------------------------------------------------------
--! @brief  Architecture definition of AES_ShiftRows
-------------------------------------------------------------------------------

architecture basic of AES_ShiftRows is
begin
    gRow: for i in 0 to 3 generate
        gCol: for j in 0 to 3 generate
            output(j,i) <= input(j,(i+j) mod 4);
        end generate;
    end generate;
end basic;