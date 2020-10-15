

library ieee;
use ieee.std_logic_1164.all;

package AES_pkg is
	-- aes constants
	constant AES_SBOX_SIZE				: integer :=  8;
	constant AES_WORD_SIZE				: integer := 32;
	constant AES_BLOCK_SIZE				: integer :=128;
	constant AES_KEY_SIZE				: integer :=128;
    constant AES_ROUNDS                 : integer := 10;

    type t_AES_state     is array (0 to 3, 0 to 3) of std_logic_vector( 7 downto 0);
    type t_AES_column    is array (0 to 3)         of std_logic_vector( 7 downto 0);    
end AES_pkg;