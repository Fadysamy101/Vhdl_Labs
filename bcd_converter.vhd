library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Binary_to_BCD is
    Port ( 
        clk      : in  STD_LOGIC;  
        binary_in : in  STD_LOGIC_VECTOR (11 downto 0);
        bcd_out   : out STD_LOGIC_VECTOR (15 downto 0) 
    );
end Binary_to_BCD;

architecture Behavioral of Binary_to_BCD is
begin
    process(clk)
        variable temp : UNSIGNED(27 downto 0);
        variable bcd  : UNSIGNED(15 downto 0) := (others => '0');
    begin
        if rising_edge(clk) then  
            bcd := (others => '0');
            temp(11 downto 0) := UNSIGNED(binary_in);
            temp(27 downto 12) := (others => '0');

            for i in 0 to 11 loop
                if bcd(3 downto 0) > 4 then
                    bcd(3 downto 0) := bcd(3 downto 0) + 3;
                end if;
                if bcd(7 downto 4) > 4 then
                    bcd(7 downto 4) := bcd(7 downto 4) + 3;
                end if;
                if bcd(11 downto 8) > 4 then
                    bcd(11 downto 8) := bcd(11 downto 8) + 3;
                end if;
                if bcd(15 downto 12) > 4 then
                    bcd(15 downto 12) := bcd(15 downto 12) + 3;
                end if;

                -- Shift left
                bcd := bcd(14 downto 0) & temp(11);
                temp := temp(26 downto 0) & '0';
            end loop;

            bcd_out <= STD_LOGIC_VECTOR(bcd); 
        end if;
    end process;
end Behavioral;
