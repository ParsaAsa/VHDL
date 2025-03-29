LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Normal_Multiplier_TB IS
END Normal_Multiplier_TB;
 
ARCHITECTURE behavior OF Normal_Multiplier_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Normal_Multiplier
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         product : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal product : std_logic_vector(7 downto 0);
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Normal_Multiplier PORT MAP (
          a => a,
          b => b,
          product => product
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		a <= "1001";
		b <= "1111";
		wait for 20 ns;	
		a <= "1111";
		b <= "1111";
		wait for 20 ns;	
		a <= "1001";
		b <= "0010";
      wait;
   end process;

END;
