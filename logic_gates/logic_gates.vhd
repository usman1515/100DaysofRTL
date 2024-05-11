library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logic_gates is
    -- declare parameters
    -- generic();
    -- declare ports
    port(
        in_dataA    : in std_logic;
        in_dataB    : in std_logic;
        out_notA    : out std_logic;
        out_notB    : out std_logic;
        out_andC    : out std_logic;
        out_nandC   : out std_logic;
        out_orC     : out std_logic;
        out_norC    : out std_logic;
        out_xorC    : out std_logic;
        out_xnorC   : out std_logic
    );
end entity logic_gates;

architecture rtl of logic_gates is
    -- declare wires and reg here
begin
    -- create rtl here
    out_notA    <= not in_dataA;
    out_notB    <= not in_dataB;
    out_andC    <= in_dataA and in_dataB;
    out_nandC   <= in_dataA nand in_dataB;
    out_orC     <= in_dataA or in_dataB;
    out_norC    <= in_dataA nor in_dataB;
    out_xorC    <= in_dataA xor in_dataB;
    out_xnorC   <= in_dataA xnor in_dataB;
end architecture rtl;
