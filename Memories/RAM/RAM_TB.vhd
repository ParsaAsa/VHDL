LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RAM_TB IS
END RAM_TB;
 
ARCHITECTURE behavior OF RAM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         WR : IN  std_logic;
         RD : IN  std_logic;
         RESET : IN  std_logic;
         CLK : IN  std_logic;
         Addr : IN  std_logic_vector(3 downto 0);
         DATA_IN : IN  std_logic_vector(7 downto 0);
         DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal WR : std_logic := '0';
   signal RD : std_logic := '0';
   signal RESET : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Addr : std_logic_vector(3 downto 0) := (others => '0');
   signal DATA_IN : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          WR => WR,
          RD => RD,
          RESET => RESET,
          CLK => CLK,
          Addr => Addr,
          DATA_IN => DATA_IN,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '0';
		wait for 20 ns;
		reset <= '1';
		RD <= '0';
		Addr <= "0100";
		DATA_IN <= "11001111";
		WR <= '1';
		wait for 20 ns;
		Addr <= "0110";
		DATA_IN <= "11000011";
		wait for 20 ns;
		Addr <= "0011";
		DATA_IN <= "00001111";
		wait for 20 ns;
		RD <= '1';
		Addr <= "0100";
		wait for 20 ns;
		Addr <= "0110";
		wait for 20 ns;
      wait;
   end process;

END;
