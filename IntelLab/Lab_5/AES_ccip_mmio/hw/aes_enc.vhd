

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.aes_pkg.all;

entity AES_Enc is
    generic (
        G_RNDS      : integer := AES_ROUNDS);
    port(
        clk         : in  std_logic;
        rst         : in  std_logic;
        din         : in  std_logic_vector(AES_BLOCK_SIZE-1 downto 0);
        key         : in  std_logic_vector(AES_BLOCK_SIZE-1 downto 0);
        dout        : out std_logic_vector(AES_BLOCK_SIZE-1 downto 0);

        init        : in  std_logic;
        start       : in  std_logic;
        ready       : out std_logic;
        done        : out std_logic;
        done_init   : out std_logic
    );
end AES_Enc;

-------------------------------------------------------------------------------
--! @brief  Architecture definition of AES_Enc
-------------------------------------------------------------------------------

architecture structure of AES_Enc is
    signal sel_fkey : std_logic;
    signal en_fkey  : std_logic;
    signal en_rkey  : std_logic;
    signal wr_rkey  : std_logic;
    signal round    : std_logic_vector(3 downto 0);
    signal sel_in   : std_logic;
    signal en_in    : std_logic;

    signal key_state        : t_AES_state;
    signal din_state        : t_AES_state;
    signal dout_state       : t_AES_state;
begin
    u_map_key: entity work.AES_map(structure)
    port map ( ii => key, 
               oo => key_state);
               
    u_map_din: entity work.AES_map(structure)
    port map ( ii => din, 
               oo => din_state);
               
    u_invmap: entity work.AES_invmap(structure)
    port map ( ii => dout_state, 
               oo => dout);

    u_dp: entity work.AES_Enc_Datapath(structure)
    port map (  clk         => clk,
                rst         => rst,
                --! Data
                din         => din_state,
                key         => key_state,
                dout        => dout_state,
                --! Control
                sel_fkey    => sel_fkey,
                en_fkey     => en_fkey,
                wr_rkey     => wr_rkey,
                en_rkey     => en_rkey,
                round       => round,
                sel_in      => sel_in,
                en_in       => en_in);

    u_ctrl: entity work.AES_Enc_Control(behav)
    generic map (G_RNDS     => G_RNDS)
    port map (  clk         => clk,
                rst         => rst,
                --! External
                init        => init,
                start       => start,
                ready       => ready,
                done        => done,
                done_init   => done_init,
                --! Internal
                sel_fkey    => sel_fkey,
                en_fkey     => en_fkey,
                wr_rkey     => wr_rkey,
                en_rkey     => en_rkey,
                round       => round,
                sel_in      => sel_in,
                en_in       => en_in);

end structure;