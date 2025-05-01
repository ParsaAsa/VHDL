library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CAM_TB is
end CAM_TB;

architecture Behavioral of CAM_TB is
    component CAM
        port (WR, RD, RESET, CLK: in STD_LOGIC;
              Addr: in STD_LOGIC_VECTOR(3 downto 0);
              DATA_IN: in STD_LOGIC_VECTOR(7 downto 0);
              DATA_OUT: out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    signal CLK, RESET, WR, RD: STD_LOGIC := '0';
    signal Addr: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal DATA_IN: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal DATA_OUT: STD_LOGIC_VECTOR(3 downto 0);

    constant CLK_PERIOD: time := 10 ns;
begin
    uut: CAM port map (
        WR => WR,
        RD => RD,

        RESET => RESET,
        CLK => CLK,
        Addr => Addr,
        DATA_IN => DATA_IN,
        DATA_OUT => DATA_OUT
    );

    -- Clock generation
    clk_process: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the CAM
        RESET <= '1';
        wait for CLK_PERIOD;
        RESET <= '0';
        wait for CLK_PERIOD;
        RESET <= '1';
        
        -- Test 1: Write data to address 5
        wait for CLK_PERIOD;
        Addr <= "0101";  -- Address 5
        DATA_IN <= "10101010";
        WR <= '1';
        wait for CLK_PERIOD;
        WR <= '0';
        
        -- Test 2: Read back the data we just wrote
        wait for CLK_PERIOD;
        DATA_IN <= "10101010";
        RD <= '1';
        wait for CLK_PERIOD;
        assert DATA_OUT = "0101" report "Test 2 failed" severity error;
        RD <= '0';
        
        -- Test 3: Try to read non-existent data
        wait for CLK_PERIOD;
        DATA_IN <= "11111111";
        RD <= '1';
        wait for CLK_PERIOD;
        assert DATA_OUT = "0000" report "Test 3 failed" severity error;
        RD <= '0';
        
        -- Test 4: Write to another address (10)
        wait for CLK_PERIOD;
        Addr <= "1010";  -- Address 10
        DATA_IN <= "11001100";
        WR <= '1';
        wait for CLK_PERIOD;
        WR <= '0';
		  
		  -- Test 5: Read back both entries
        wait for CLK_PERIOD;
        DATA_IN <= "10101010";
        RD <= '1';
        wait for CLK_PERIOD;
        assert DATA_OUT = "0101" report "Test 5a failed" severity error;
        
        DATA_IN <= "11001100";
        wait for CLK_PERIOD;
        assert DATA_OUT = "1010" report "Test 5b failed" severity error;
        RD <= '0';
		  
		  -- End of tests
        wait for CLK_PERIOD;
        report "CAM testbench completed";
        wait;
    end process;
end Behavioral;