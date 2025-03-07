library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity synchronizer is 
port 
( async_in: in std_logic;
  sync_out:out  std_logic;
	clk : in std_logic  

);
end entity synchronizer;


architecture A_Sync  of synchronizer is 

 signal flop1,flop2 :std_logic:= '0';  
begin
	process(clk)
	begin
   if rising_edge(clk) then
	 flop1<=async_in;
	 flop2<=flop1;	 
	end if;
	process(flop2)
begin
   sync_out <= flop2;
end process;
	end process;

end architecture A_Sync ;  
