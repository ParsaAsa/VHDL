
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ripple_Adder is
	port (cout: out STD_LOGIC;
			sum: out STD_LOGIC_VECTOR(7 downto 0);
			a, b: in STD_LOGIC_VECTOR(7 downto 0);
			cin: in STD_LOGIC);
end Ripple_Adder;

architecture Behavioral of Ripple_Adder is
	component FA is
	port (a, b, cin: in STD_LOGIC;
			s, cout: out STD_LOGIC);
end component;
	signal couts: STD_LOGIC_VECTOR (7 downto 0);
begin
	instance_FA: FA port map (a=>a(0), b=>b(0), cin=>cin, s=>sum(0), cout=>couts(0));
	generator: for i in 1 to 7 generate
	instance_FA: FA port map (a=>a(i), b=>b(i), cin=>couts(i-1), s=>sum(i), cout=>couts(i));
	end generate generator;
	cout <= couts(7);
end Behavioral;

