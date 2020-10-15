

library ieee;
use ieee.std_logic_1164.all;

use work.AES_pkg.all;

entity AES_invmap is  
    port (
        ii :   in  t_AES_state;
        oo :   out std_logic_vector(AES_BLOCK_SIZE-1 downto 0)
    );
end AES_invmap;

-------------------------------------------------------------------------------
--! @brief  Architecture definition of AES_invmap
-------------------------------------------------------------------------------
architecture structure of AES_invmap is   
begin
    gRow: for i in 0 to 3 generate
        gCol: for j in 0 to 3 generate
            oo(AES_BLOCK_SIZE-(j*8+i*AES_WORD_SIZE)-1 downto AES_BLOCK_SIZE-(j*8+i*AES_WORD_SIZE)-8)  <=  ii(j,i);
        end generate;
    end generate;
end structure;