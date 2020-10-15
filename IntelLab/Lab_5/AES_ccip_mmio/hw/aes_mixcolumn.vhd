

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.AES_pkg.all;

entity AES_MixColumn is
    port(
        input       : in  t_AES_column;
        output      : out t_AES_column
    );
end AES_MixColumn;

-------------------------------------------------------------------------------
--! @brief  Architecture definition of AES_MixColumn
-------------------------------------------------------------------------------

architecture structure of AES_MixColumn is
    signal mulx2    : t_AES_column;
    signal mulx3    : t_AES_column;
begin

    m_gen : for i in 0 to 3 generate
        m2  : entity work.AES_mul(AES_mulx02)
            port map (  input  => input(i),
                        output => mulx2(i));
        m3  : entity work.AES_mul(AES_mulx03)
            port map (  input  => input(i),
                        output => mulx3(i));
    end generate;

    output(0) <= mulx2(0) xor mulx3(1) xor input(2) xor input(3);
    output(1) <= input(0) xor mulx2(1) xor mulx3(2) xor input(3);
    output(2) <= input(0) xor input(1) xor mulx2(2) xor mulx3(3);
    output(3) <= mulx3(0) xor input(1) xor input(2) xor mulx2(3);
end structure;