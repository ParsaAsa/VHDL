library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FourBit_Carry_Select_Adder is
	port (a, b: in STD_LOGIC_VECTOR (3 downto 0);
			cin: in STD_LOGIC;
			cout: out STD_LOGIC;
			sum: out STD_LOGIC_VECTOR (3 downto 0));
end FourBit_Carry_Select_Adder;

architecture Behavioral of FourBit_Carry_Select_Adder is
	signal sum1: STD_LOGIC_VECTOR (3 downto 0);
	signal carry0: STD_LOGIC_VECTOR (3 downto 0);
	signal sum0: STD_LOGIC_VECTOR (3 downto 0);
	signal carry1: STD_LOGIC_VECTOR (3 downto 0);
	component FA is
	port (a, b, cin: in STD_LOGIC;
			s, cout: out STD_LOGIC);
	end component;
begin
	instance00: FA port map (a=>a(0), b=>b(0), cin=>'0', s=>sum0(0), cout=>carry0(0));
	instance10: FA port map (a=>a(0), b=>b(0), cin=>'1', s=>sum1(0), cout=>carry1(0));
	
	gen0: for i in 1 to 3 generate
		instance01: FA port map (a=>a(i), b=>b(i), cin=>carry0(i-1), s=>sum0(i), cout=>carry0(i));
	end generate gen0;
	gen1: for i in 1 to 3 generate
		instance11: FA port map (a=>a(i), b=>b(i), cin=>carry1(i-1), s=>sum1(i), cout=>carry1(i));
	end generate gen1;
	process (cin, sum0, sum1, carry0, carry1)
	begin
		if cin = '0' then
			sum <= sum0;
			cout <= carry0(3);
		else
			sum <= sum1;
			cout <= carry1(3);
		end if;
	end process;
	
end Behavioral;

