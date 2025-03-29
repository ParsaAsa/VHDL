library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Normal_Multiplier is
	port(a, b: in STD_LOGIC_VECTOR(3 downto 0);
			product: out STD_LOGIC_VECTOR(7 downto 0));
end Normal_Multiplier;

architecture Behavioral of Normal_Multiplier is

	component FA is
	port (a, b, cin: in STD_LOGIC;
			s, cout: out STD_LOGIC);
	end component;
	
	component HA is
	port (a, b: in STD_LOGIC;
			sum, cout: out STD_LOGIC);
	end component;
	
	type matrix1 is array (3 downto 0, 3 downto 0) of STD_LOGIC;
	signal p: matrix1;
	
	type matrix2 is array (2 downto 0, 3 downto 0) of STD_LOGIC;
	signal carries: matrix2;
	signal sums: matrix2;
	
begin
	aBit: for i in 0 to 3 generate
		bBit: for j in 0 to 3 generate
			p(i, j) <= a(i) and b(j);
		end generate bBit;
	end generate aBit;
	
	product(0) <= p(0,0);
	
	ins1: HA port map (a=>p(1,0), b=>p(0,1), sum=>product(1), cout=>carries(0,0));
	ins2: FA port map (a=>p(1,1), b=>p(0,2), cin=>carries(0,0), s=>sums(0,1), cout=>carries(0,1));
	ins3: FA port map (a=>p(1,2), b=>p(0,3), cin=>carries(0,1), s=>sums(0,2), cout=>carries(0,2));
	ins4: HA port map (a=>p(1,3), b=>carries(0,2), sum=>sums(0,3), cout=>carries(0,3));
	
	--This part can be in a generator for multiplying more bits
	ins5: HA port map (a=>p(2,0), b=>sums(0,1), sum=>product(2), cout=>carries(1,0));
	Gen1: for i in 1 to 2 generate
		ins6: FA port map (a=>p(2,i), b=>sums(0,i+1), cin=>carries(1,i-1), s=>sums(1,i), cout=>carries(1,i));
	end generate Gen1;
	ins7: FA port map (a=>p(2,3), b=>carries(0,3), cin=>carries(1,2), s=>sums(1,3), cout=>carries(1,3));
	
	ins8: HA port map (a=>p(3,0), b=>sums(1,1), sum=>product(3), cout=>carries(2,0));
	Gen2: for i in 1 to 2 generate
		ins9: FA port map (a=>p(3,i), b=>sums(1,i+1), cin=>carries(2,i-1), s=>product(i+3), cout=>carries(2,i));
	end generate Gen2;
	ins10: FA port map (a=>p(3,3), b=>carries(1,3), cin=>carries(2,2), s=>product(6), cout=>product(7));
	
end Behavioral;

