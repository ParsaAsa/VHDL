library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Vector_Multiplier is
	port(a, b: in STD_LOGIC_VECTOR(3 downto 0);
			product: out STD_LOGIC_VECTOR(7 downto 0));
end Vector_Multiplier;

architecture Behavioral of Vector_Multiplier is
	component Ripple_Adder is
	port (cout: out STD_LOGIC;
			sum: out STD_LOGIC_VECTOR(3 downto 0);
			a, b: in STD_LOGIC_VECTOR(3 downto 0);
			cin: in STD_LOGIC);
	end component;

	type matrix1 is array (3 downto 0, 3 downto 0) of STD_LOGIC;
	signal p: matrix1;
	
	signal sum0, sum1 : STD_LOGIC_VECTOR(3 downto 0);
	signal a1, a2, a3 : STD_LOGIC_VECTOR(3 downto 0);
   signal b1, b2, b3 : STD_LOGIC_VECTOR(3 downto 0);
	signal carries: STD_LOGIC_VECTOR (2 downto 0);
	
begin
	aBit: for i in 0 to 3 generate
		bBit: for j in 0 to 3 generate
			p(i, j) <= a(i) and b(j);
		end generate bBit;
	end generate aBit;
	
	product(0) <= p(0,0);
	
	a1 <= '0' & p(0,3) & p(0,2) & p(0,1);
   b1 <= p(1,3) & p(1,2) & p(1,1) & p(1,0);
	Adder1: Ripple_Adder port map (
    cout => carries(0), 
    sum => sum0,
    a => a1, 
    b => b1, 
    cin => '0');

	product(1) <= sum0(0);
	
	a2 <= carries(0) & sum0(3) & sum0(2) & sum0(1);
   b2 <= p(2,3) & p(2,2) & p(2,1) & p(2,0);
	 
	Adder2: Ripple_Adder port map (
    cout => carries(1), 
    sum => sum1,
    a => a2, 
    b => b2, 
    cin => '0');
	 
	 product(2) <= sum1(0);
	
	a3 <= carries(1) & sum1(3) & sum1(2) & sum1(1);
   b3 <= p(3,3) & p(3,2) & p(3,1) & p(3,0);
	 
	Adder3: Ripple_Adder port map (
    cout => product(7), 
    sum => product(6 downto 3), 
    a => a3, 
    b => b3, 
    cin => '0');
end Behavioral;

