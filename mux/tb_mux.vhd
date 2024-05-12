library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_mux is
end entity tb_mux;

architecture behavioural of tb_mux is
    -- declare parameters
    constant DATA_WIDTH : integer := 8;
    constant T : time := 10 ns;
    constant MIN_VAL : integer := 0;
    constant MAX_VAL : integer := 255;
    constant VAL_RANGE : integer := MAX_VAL - MIN_VAL + 1;

    -- declare IO signals for the DUT
    signal in_dataA : std_logic_vector(DATA_WIDTH-1 downto 0) := x"00";
    signal in_dataB : std_logic_vector(DATA_WIDTH-1 downto 0) := x"00";
    signal in_sel   : std_logic := '0';
    signal out_data : std_logic_vector(DATA_WIDTH-1 downto 0);

    -- declare DUT
    component mux is
        -- generic (
        --     DATA_WIDTH : integer := 8
        -- );
        port(
            in_dataA    : in std_logic_vector(DATA_WIDTH-1 downto 0);
            in_dataB    : in std_logic_vector(DATA_WIDTH-1 downto 0);
            in_sel      : in std_logic;
            out_data    : out std_logic_vector(DATA_WIDTH-1 downto 0)
        );
    end component mux;

begin
    -- instantiate the DUT
    INST_mux: mux
    port map (
        in_dataA    => in_dataA,
        in_dataB    => in_dataB,
        in_sel      => in_sel,
        out_data    => out_data
    );

    -- give stimulii to input and observe outputs
    testbench: process is
    begin
        wait for T; in_dataA <= x"aa"; in_dataB <= x"ff"; in_sel <='0';
        wait for T; in_dataA <= x"bb"; in_dataB <= x"ee"; in_sel <='1';
        wait for T; in_dataA <= x"cc"; in_dataB <= x"dd"; in_sel <='0';
        wait for T; in_dataA <= x"dd"; in_dataB <= x"cc"; in_sel <='1';
        wait for T; in_dataA <= x"ee"; in_dataB <= x"bb"; in_sel <='0';
        wait for T; in_dataA <= x"ff"; in_dataB <= x"aa"; in_sel <='1';
        wait for T;
    end process testbench;

end architecture behavioural;
