
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Ripple_Adder_tb IS
END Ripple_Adder_tb;
 
ARCHITECTURE behavior OF Ripple_Adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Ripple_Adder
    PORT(
         cout : OUT  std_logic;
         sum : OUT  std_logic_vector(7 downto 0);
         a : IN  std_logic_vector(7 downto 0);
         b : IN  std_logic_vector(7 downto 0);
         cin : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal b : std_logic_vector(7 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal cout : std_logic;
   signal sum : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ripple_Adder PORT MAP (
          cout => cout,
          sum => sum,
          a => a,
          b => b,
          cin => cin
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	
		cin <= '0';
		a <= "00010111";
		b <= "10010000";
		wait for 20 ns;	
		cin <= '0';
		a <= "11111111";
		b <= "00001001";
      wait;
   end process;

END;
