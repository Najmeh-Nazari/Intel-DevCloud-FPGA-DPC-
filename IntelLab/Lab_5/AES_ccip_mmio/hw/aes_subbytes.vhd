

library ieee;
use ieee.std_logic_1164.all;

use work.AES_pkg.all;

entity AES_SubBytes is
    port(
        input       : in  t_AES_state;
        output      : out t_AES_state
    );
end AES_SubBytes;

-------------------------------------------------------------------------------
--! @brief  Architecture definition of AES_SubBytes
-------------------------------------------------------------------------------

architecture basic of AES_SubBytes is
begin
    gRow: for i in 0 to 3 generate
        gCol: for j in 0 to 3 generate
            sbox: entity work.AES_Sbox(distributed_rom)
                port map ( input  =>  input(j,i),
                           output => output(j,i));
        end generate;
    end generate;
end basic;