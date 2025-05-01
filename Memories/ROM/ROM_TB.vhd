
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ROM_TB IS
END ROM_TB;
 
ARCHITECTURE behavior OF ROM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ROM
    PORT(
         RD : IN  std_logic;
         RESET : IN  std_logic;
         CLK : IN  std_logic;
         Addr : IN  std_logic_vector(3 downto 0);
         DATA_OUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RD : std_logic := '0';
   signal RESET : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Addr : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal DATA_OUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ROM PORT MAP (
          RD => RD,
          RESET => RESET,
          CLK => CLK,
          Addr => Addr,
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
		RESET <= '0';
		
		wait for 20 ns;
		RESET <= '1';
		Addr <= "0001";
		wait for 20 ns;
		RD <= '1';
		Addr <= "0001";
		wait for 20 ns;
		Addr <= "0011";
		wait for 20 ns;
		Addr <= "0010";
		wait for 20 ns;

      wait;
   end process;

END;
