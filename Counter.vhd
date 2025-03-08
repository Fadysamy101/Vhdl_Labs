library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter is 
    generic
    ( 
        Counter_Size : integer := 37 
    );
    
    port (
        clk           : in std_logic; 
        rst           : in std_logic; 
        enable        : in std_logic;
        counter_value : out std_logic_vector(Counter_Size-1 downto 0)
    );
end entity Counter; 

architecture A_Counter of Counter is
    signal counter_reg : unsigned(Counter_Size-1 downto 0) := (others => '0');

begin
    process(clk, rst,enable)
    begin
        if not rst = '1' then
            counter_reg <= (others => '0');
        elsif rising_edge(clk) then 
            if not enable = '1' then 
                counter_reg <= counter_reg + 1; 
            end if; 
        end if;
    end process;

    counter_value <= std_logic_vector(counter_reg);

end architecture A_Counter;
