library ieee;
use ieee.std_logic_1164.all;

entity Top_Module is
    port (
        clk           : in std_logic;
        rst_button    : in std_logic;  
        enable_button : in std_logic; 
       
        seg_display_2 : out std_logic_vector(6 downto 0); -- 100s
        seg_display_3 : out std_logic_vector(6 downto 0); -- 10s
        seg_display_4 : out std_logic_vector(6 downto 0)  -- 1s
    );
end entity Top_Module;

architecture Behavioral of Top_Module is
    signal rst_sync, enable_sync : std_logic;
    signal counter_value : std_logic_vector(36 downto 0);
    signal bcd_out : std_logic_vector(15 downto 0);

    -- Components
    component Synchronizer is
        port ( clk : in std_logic; async_in : in std_logic; sync_out : out std_logic );
    end component;

    component Counter is
        port ( clk : in std_logic; rst : in std_logic; enable : in std_logic; counter_value : out std_logic_vector(36 downto 0) );
    end component;

    component Binary_to_BCD is
        port ( binary_in : in std_logic_vector(11 downto 0); bcd_out : out std_logic_vector(15 downto 0) );
    end component;

    component SevenSegment is
        port ( hex_value : in std_logic_vector(3 downto 0); seg_out : out std_logic_vector(6 downto 0) );
    end component;

begin
   
    Reset_Sync : Synchronizer port map(clk, rst_button, rst_sync);
    Enb_Sync : Synchronizer port map(clk, enable_button, enable_sync);

    Counter_Inst : Counter port map(clk, rst_sync, enable_sync, counter_value);

   
    BCD_Conv : Binary_to_BCD port map(counter_value(36 downto 25), bcd_out);


    SevenSeg_2 : SevenSegment port map(bcd_out(11 downto 8), seg_display_2);
    SevenSeg_3 : SevenSegment port map(bcd_out(7 downto 4), seg_display_3);
    SevenSeg_4 : SevenSegment port map(bcd_out(3 downto 0), seg_display_4);

end architecture Behavioral;
