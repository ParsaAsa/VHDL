LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY eightbit_tb IS
END eightbit_tb;
 
ARCHITECTURE behavior OF eightbit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EightBit_Carry_Select_Adder
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         b : IN  std_logic_vector(7 downto 0);
         cin : IN  std_logic;
         cout : OUT  std_logic;
         sum : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal b : std_logic_vector(7 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal cout : std_logic;
   signal sum : std_logic_vector(7 downto 0);
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EightBit_Carry_Select_Adder PORT MAP (
          a => a,
          b => b,
          cin => cin,
          cout => cout,
          sum => sum
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		a <= "00100111";
		b <= "11100001";
		cin <= '1';
		wait for 100 ns;	
		a <= "00011111";
		b <= "11100000";
		cin <= '1';
		wait for 100 ns;	
		a <= "00101111";
		b <= "11001001";
		cin <= '0';
      wait;
   end process;

END;
