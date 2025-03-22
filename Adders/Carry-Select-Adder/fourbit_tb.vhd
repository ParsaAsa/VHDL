LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourbit_tb IS
END fourbit_tb;
 
ARCHITECTURE behavior OF fourbit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FourBit_Carry_Select_Adder
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         cin : IN  std_logic;
         cout : OUT  std_logic;
         sum : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal cout : std_logic;
   signal sum : std_logic_vector(3 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FourBit_Carry_Select_Adder PORT MAP (
          a => a,
          b => b,
          cin => cin,
          cout => cout,
          sum => sum
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 20 ns.
      wait for 20 ns;	
		a <= "1110";
		b <= "1000";
		cin <= '1';
		wait for 20 ns;	
		a <= "1111";
		b <= "0000";
		cin <= '0';
      wait for 20 ns;	
		a <= "1111";
		b <= "0001";
		cin <= '0';
      wait;
   end process;

END;
