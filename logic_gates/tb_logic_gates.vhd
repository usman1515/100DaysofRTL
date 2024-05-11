library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_logic_gates is
end entity tb_logic_gates;

architecture behaviour of tb_logic_gates is
    -- declare IO signals for DUT
    signal in_sigA         : std_logic := '0';
    signal in_sigB         : std_logic := '0';
    signal out_sig_notA    : std_logic;
    signal out_sig_notB    : std_logic;
    signal out_sig_andC    : std_logic;
    signal out_sig_orC     : std_logic;
    signal out_sig_xorC    : std_logic;
    signal out_sig_nandC   : std_logic;
    signal out_sig_norC    : std_logic;
    signal out_sig_xnorC   : std_logic;

    -- declare DUT
    component logic_gates is
        port(
            in_dataA    : in std_logic;
            in_dataB    : in std_logic;
            out_notA    : out std_logic;
            out_notB    : out std_logic;
            out_andC    : out std_logic;
            out_orC     : out std_logic;
            out_xorC    : out std_logic;
            out_nandC   : out std_logic;
            out_norC    : out std_logic;
            out_xnorC   : out std_logic
        );
    end component logic_gates;

begin
    -- instantiate DUT and map ports
    INST_logic_gates : logic_gates
    port map (
        in_dataA    => in_sigA,
        in_dataB    => in_sigB,
        out_notA    => out_sig_notA,
        out_notB    => out_sig_notB,
        out_andC    => out_sig_andC,
        out_orC     => out_sig_orC,
        out_xorC    => out_sig_xorC,
        out_nandC   => out_sig_nandC,
        out_norC    => out_sig_norC,
        out_xnorC   => out_sig_xnorC
    );

    -- provide stimulii to the ports and observe outputs
    process is
        begin
            wait for 10 ns;
            in_sigA <= '0'; in_sigB <= '0';
            wait for 10 ns;
            in_sigA <= '0'; in_sigB <= '1';
            wait for 10 ns;
            in_sigA <= '1'; in_sigB <= '0';
            wait for 10 ns;
            in_sigA <= '1'; in_sigB <= '1';
            wait for 10 ns;
    end process;

end architecture behaviour;
