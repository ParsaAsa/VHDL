library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
	port (a, b, cin: in STD_LOGIC;
			s, cout: out STD_LOGIC);
end FA;

architecture Behavioral of FA is
	component HA is
	port (a, b: in STD_LOGIC;
			sum, cout: out STD_LOGIC);
end component;
signal midSUM: STD_LOGIC;
signal midCOUT: STD_LOGIC;
signal mid: STD_LOGIC;

begin
	instance_1: HA port map (a=>a, b=>b, sum=>midSUM, cout=>midCOUT);
	instance_2: HA port map (a=>midSUM, b=>cin, sum=>s, cout=>mid);
	cout <= midCOUT or  mid;
end Behavioral;

