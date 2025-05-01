library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CAM is
	port (WR, RD, RESET, CLK: in STD_LOGIC;
			Addr: in STD_LOGIC_VECTOR(3 downto 0);
			DATA_IN: in STD_LOGIC_VECTOR(7 downto 0);
			DATA_OUT: out STD_LOGIC_VECTOR(3 downto 0));
end CAM;

architecture Behavioral of CAM is
	type CAM_matrix is array (15 downto 0) of STD_LOGIC_VECTOR(8 downto 0);
	signal CAM_sig: CAM_matrix := (others => (others => '0'));
	signal out_sig: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin
	
	process (CLK, RESET)
	begin
		if (RESET = '0') then
			CAM_sig <= (others => (others => '0'));
			out_sig <= "0000";
		else
			if (RD = '1') then
				for i in 1 to 15 loop
					if (CAM_sig(i)(8) = '1' and CAM_sig(i)(7 downto 0) = DATA_IN) then
						out_sig <= STD_LOGIC_vector(to_unsigned(i,4));
						exit;
					end if;
					out_sig <= "0000";
				end loop;
			else
				out_sig <= "0000";
				if (WR = '1') then
					for i in 1 to 15 loop
					if (CAM_sig(i)(8) = '0') then
						CAM_sig(i)(7 downto 0) <= DATA_IN;
						exit;
					end if;
				end loop;
				end if;
			end if;
		end if;
	end process;
	
	DATA_OUT <= out_sig;
end Behavioral;

