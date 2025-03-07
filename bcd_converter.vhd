library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Binary_to_BCD is
    Port ( 
        binary_in : in  STD_LOGIC_VECTOR (11 downto 0);
        bcd_out   : out STD_LOGIC_VECTOR (15 downto 0)  -- 4 BCD digits (4 bits each)
    );
end Binary_to_BCD;

architecture Behavioral of Binary_to_BCD is
begin
    process(binary_in)
        variable temp : STD_LOGIC_VECTOR(27 downto 0);
        variable bcd  : UNSIGNED(15 downto 0) := (others => '0');
    begin
        -- Initialize with zeros
        bcd := (others => '0');
        
        -- Set the initial binary value in a temporary variable
        temp(11 downto 0) := binary_in;
        temp(27 downto 12) := (others => '0');
        
        -- Double dabble algorithm (shift and add 3)
        for i in 0 to 11 loop
            -- Check if any BCD digit is greater than 4
            -- If so, add 3 to that digit
            
            -- Check first BCD digit (ones place)
            if bcd(3 downto 0) > 4 then
                bcd(3 downto 0) := bcd(3 downto 0) + 3;
            end if;
            
            -- Check second BCD digit (tens place)
            if bcd(7 downto 4) > 4 then
                bcd(7 downto 4) := bcd(7 downto 4) + 3;
            end if;
            
            -- Check third BCD digit (hundreds place)
            if bcd(11 downto 8) > 4 then
                bcd(11 downto 8) := bcd(11 downto 8) + 3;
            end if;
            
            -- Check fourth BCD digit (thousands place)
            if bcd(15 downto 12) > 4 then
                bcd(15 downto 12) := bcd(15 downto 12) + 3;
            end if;
            
            -- Shift everything left by 1 bit
            bcd := bcd(14 downto 0) & unsigned(temp(11 downto 11));
            temp := temp(26 downto 0) & '0';
        end loop;
        
        -- Output the result
        bcd_out <= STD_LOGIC_VECTOR(bcd);
    end process;
end Behavioral;