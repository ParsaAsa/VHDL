library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Carry_LookAhead_Adder is
	port (cin: in STD_LOGIC;
			a, b: in STD_LOGIC_VECTOR (3 downto 0);
			cout: out STD_LOGIC;
			sum: out STD_LOGIC_VECTOR (3 downto 0));
end Carry_LookAhead_Adder;

architecture Behavioral of Carry_LookAhead_Adder is
	signal Cin_sig: STD_LOGIC_VECTOR (3 downto 0);
	signal temp: STD_LOGIC;
	component FA is
	port (a, b, cin: in STD_LOGIC;
			s, cout: out STD_LOGIC);
	end component;
begin

	Cin_sig(0) <= cin;
	Cin_generator: for i in 1 to 3 generate
		Cin_sig(i) <= (Cin_sig(i-1) and a(i-1)) or (Cin_sig(i-1) and b(i-1)) or (a(i-1) and b(i-1));
	end generate Cin_generator;
	
	Comp_gen: for i in 0 to 3 generate
		instance_FA: FA port map (a=>a(i), b=>b(i), cin=>cin_sig(i), s=>sum(i), cout=>open);
	end generate Comp_gen;
	
	cout <= (Cin_sig(3) and a(3)) or (Cin_sig(3) and b(3)) or (a(3) and b(3));
	end Behavioral;

