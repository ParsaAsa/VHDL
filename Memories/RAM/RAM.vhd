library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
	port (WR, RD, RESET, CLK: in STD_LOGIC;
			Addr: in STD_LOGIC_VECTOR(3 downto 0);
			DATA_IN: in STD_LOGIC_VECTOR(7 downto 0);
			DATA_OUT: out STD_LOGIC_VECTOR(7 downto 0));
end RAM;

architecture Behavioral of RAM is
	type RAM_matrix is array (15 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
	signal RAM_sig: RAM_matrix := (others => (others => '0'));
	signal out_sig: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
	process (clk, RESET)
	
	begin
		if (RESET = '0') then
			RAM_sig <= (others => (others => '0'));
			out_sig <= "00000000";
		else
			if (RD = '1') then
				out_sig <= RAM_sig (to_integer(unsigned(Addr)));
			else
				out_sig <= "00000000";
				if (WR = '1') then
					RAM_sig(to_integer(unsigned(Addr))) <= DATA_IN;
				end if;
			end if;
		end if;
	end process;
	
	DATA_OUT <= out_sig;
end Behavioral;

