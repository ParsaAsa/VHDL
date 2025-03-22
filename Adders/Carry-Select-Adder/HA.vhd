
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HA is
	port (a, b: in STD_LOGIC;
			sum, cout: out STD_LOGIC);
end HA;

architecture Behavioral of HA is

begin
	sum <= a xor b;
	cout <= a and b;

end Behavioral;

