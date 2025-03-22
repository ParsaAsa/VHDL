library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EightBit_Carry_Select_Adder is
	port (a, b: in STD_LOGIC_VECTOR (7 downto 0);
			cin: in STD_LOGIC;
			cout: out STD_LOGIC;
			sum: out STD_LOGIC_VECTOR (7 downto 0));
end EightBit_Carry_Select_Adder;
	
architecture Behavioral of EightBit_Carry_Select_Adder is
	signal sum1: STD_LOGIC_VECTOR (7 downto 0);
	signal carry0: STD_LOGIC_VECTOR (1 downto 0);
	signal sum0: STD_LOGIC_VECTOR (7 downto 0);
	signal carry1: STD_LOGIC_VECTOR (1 downto 0);
	
	component FourBit_Carry_Select_Adder is
	port (a, b: in STD_LOGIC_VECTOR (3 downto 0);
			cin: in STD_LOGIC;
			cout: out STD_LOGIC;
			sum: out STD_LOGIC_VECTOR (3 downto 0));
	end component;
begin
	instance00: FourBit_Carry_Select_Adder 
	port map(a => a(3 downto 0), b => b(3 downto 0), cin => '0', cout => carry0(0), sum => sum0(3 downto 0));
	instance01: FourBit_Carry_Select_Adder 
	port map(a => a(7 downto 4), b => b(7 downto 4), cin => carry0(0), cout => carry0(1), sum => sum0(7 downto 4));
	instance10: FourBit_Carry_Select_Adder 
	port map(a => a(3 downto 0), b => b(3 downto 0), cin => '1', cout => carry1(0), sum => sum1(3 downto 0));
	instance11: FourBit_Carry_Select_Adder 
	port map(a => a(7 downto 4), b => b(7 downto 4), cin => carry1(0), cout => carry1(1), sum => sum1(7 downto 4));
	
	
	process (cin, sum0, sum1, carry0, carry1)
	begin
		if cin = '0' then
			sum <= sum0;
			cout <= carry0(1);
		else
			sum <= sum1;
			cout <= carry1(1);
		end if;
	end process;
end Behavioral;

