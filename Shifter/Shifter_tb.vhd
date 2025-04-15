LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Shifter_tb IS
END Shifter_tb;
 
ARCHITECTURE behavior OF Shifter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shifter
    PORT(
         Parallel_IN : IN  std_logic_vector(3 downto 0);
         LR : IN  std_logic_vector(1 downto 0);
         reset : IN  std_logic;
         clk : IN  std_logic;
         Load : IN  std_logic;
         reg_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Parallel_IN : std_logic_vector(3 downto 0) := (others => '0');
   signal LR : std_logic_vector(1 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal Load : std_logic := '0';

 	--Outputs
   signal reg_out : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shifter PORT MAP (
          Parallel_IN => Parallel_IN,
          LR => LR,
          reset => reset,
          clk => clk,
          Load => Load,
          reg_out => reg_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- Test reset (active low)
        reset <= '0';
        wait for 100ns;
        reset <= '1';
        wait for 100ns;
		  
		  -- Test Load
        Parallel_IN <= "1101";
        Load <= '0';
        wait for 100ns;
        Load <= '1';
        wait for 100ns;
		  Load <= '0';
        wait for 100ns;
		  
        -- Test Logical Left Shift (LR = "00")
        LR <= "00";
        Parallel_IN <= "1011";
		  Load <= '1';
        wait for 100ns;
		  Load <= '0';
        wait for 100ns;
		  
		  -- Test Logical Right Shift (LR = "01")
        LR <= "01";
        Parallel_IN <= "1011";
		  Load <= '1';
        wait for 100ns;
		  Load <= '0';
        wait for 100ns;
		  
        -- Test Arithmetic Left Shift (LR = "10")
        LR <= "10";
        Parallel_IN <= "1011";
		  Load <= '1';
        wait for 100ns;
		  Load <= '0';
        wait for 100ns;

        -- Test Arithmetic Right Shift (LR = "11")
        LR <= "11";
        Parallel_IN <= "1011";
		  Load <= '1';
        wait for 50ns;
		  Load <= '0';
        wait for 50ns;
		  
        -- End simulation
        wait;
   end process;

END;
