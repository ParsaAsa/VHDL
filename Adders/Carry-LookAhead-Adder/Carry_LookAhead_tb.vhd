--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Carry_LookAhead_tb IS
END Carry_LookAhead_tb;
 
ARCHITECTURE behavior OF Carry_LookAhead_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Carry_LookAhead_Adder
    PORT(
         cin : IN  std_logic;
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         cout : OUT  std_logic;
         sum : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal cin : std_logic := '0';
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal cout : std_logic;
   signal sum : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Carry_LookAhead_Adder PORT MAP (
          cin => cin,
          a => a,
          b => b,
          cout => cout,
          sum => sum
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		a <= "1000";
		b <= "0011";
		wait for 20 ns;
      a <= "1101";
		b <= "1011";
		wait for 20 ns;

      wait;
   end process;

END;
