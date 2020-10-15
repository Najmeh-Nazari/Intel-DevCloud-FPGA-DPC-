

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.AES_pkg.all;

entity AES_MixColumns is
    port(
        input       : in  t_AES_state;
        output      : out t_AES_state
    );
end AES_MixColumns;

-------------------------------------------------------------------------------
--! @brief  Architecture definition of AES_MixColumns
-------------------------------------------------------------------------------

architecture basic of AES_MixColumns is
    type t_col_array is array (0 to 3) of t_AES_column;
    signal mc_in    : t_col_array;
    signal mc_out   : t_col_array;
begin
    gRow: for i in 0 to 3 generate
        gCol: for j in 0 to 3 generate
            mc_in(i)(j) <= input(j,i);
            output(j,i) <= mc_out(i)(j);
        end generate;

        mc: entity work.AES_MixColumn(structure)
            port map ( input  =>  mc_in(i),
                       output => mc_out(i));
    end generate;
end basic;