

library ieee;
use ieee.std_logic_1164.all;

use work.AES_pkg.all;

entity AES_map is  
    port (
        ii :   in  std_logic_vector(AES_BLOCK_SIZE-1 downto 0);
        oo :   out t_AES_state
    );
end AES_map;

-------------------------------------------------------------------------------
--! @brief  Architecture definition of AES_map
-------------------------------------------------------------------------------
architecture structure of AES_map is   
begin
    gRow: for i in 0 to 3 generate
        gCol: for j in 0 to 3 generate
            oo(j,i)  <= ii(AES_BLOCK_SIZE-(j*8+i*AES_WORD_SIZE)-1 downto AES_BLOCK_SIZE-(j*8+i*AES_WORD_SIZE)-8); 
        end generate;
    end generate;
end structure;