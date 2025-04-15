LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Vector_Mul_tb IS
END Vector_Mul_tb;
 
ARCHITECTURE behavior OF Vector_Mul_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Vector_Multiplier
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
   uut: Vector_Multiplier PORT MAP (
          a => a,
          b => b,
          product => product
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		a <= "1101";
		b <= "1010";
		wait for 100 ns;	
		a <= "1111";
		b <= "0010";
		wait for 100 ns;	
		a <= "1111";
		b <= "1111";
      -- insert stimulus here 

      wait;
   end process;

END;
