library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
	port (RD, RESET, CLK: in STD_LOGIC;
			Addr: in STD_LOGIC_VECTOR(3 downto 0);
			DATA_OUT: out STD_LOGIC_VECTOR(7 downto 0));
end ROM;

architecture Behavioral of ROM is
	type ROM_matrix is array (15 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
	constant ROM_sig: ROM_matrix := (0 => ("10101111"),
											 1 => ("11110000"),
											 2 => ("00000001"),
											 3 => ("11111110"),
												others => (others => '0'));
	signal out_sig: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
	process (CLK, RESET)
	
	begin
		if (RESET = '0') then
			out_sig <= "00000000";
		else
			if (RD = '1') then
				out_sig <= ROM_sig (to_integer(unsigned(Addr)));
			end if;
		end if;
	end process;
	
	DATA_OUT <= out_sig;
end Behavioral;

