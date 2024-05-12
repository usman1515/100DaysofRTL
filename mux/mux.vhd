library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is
    generic (
        DATA_WIDTH : integer := 8 
    );
    port (
        in_dataA    : in std_logic_vector(DATA_WIDTH-1 downto 0);
        in_dataB    : in std_logic_vector(DATA_WIDTH-1 downto 0);
        in_sel      : in std_logic;
        out_data    : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity mux;

architecture rtl of mux is
    
begin
    -- mux_behav: process(all) -- works only on VHDL 2008
    mux_behav1: process(in_sel)
    begin
        if in_sel = '0' then
            out_data <= in_dataA;
        else
            out_data <= in_dataB;
        end if;
    end process mux_behav1;
 
    -- mux_behav2: process(in_sel)
    -- begin
    --     out_data <= (in_sel = '0') when in_dataA else in_dataB;
    -- end process mux_behav2;

end architecture rtl;

