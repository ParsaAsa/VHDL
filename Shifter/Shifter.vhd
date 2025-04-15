library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shifter is
	port (Parallel_IN: in STD_LOGIC_VECTOR(3 downto 0);
		LR: in STD_LOGIC_VECTOR(1 downto 0);
		reset, clk, Load: in STD_LOGIC;
		reg_out: out STD_LOGIC_VECTOR(3 downto 0));
end Shifter;

architecture Behavioral of Shifter is
	signal parallel_sig: STD_LOGIC_VECTOR (3 downto 0);
	
begin
	
	process (clk, reset)
	begin
		if (reset = '0') then
			parallel_sig <= "0000";
		elsif (rising_edge(clk)) then
			if (Load = '0') then
				if (LR = "00") then --Logic left
					Parallel_sig <= Parallel_sig(2 downto 0) & '0';
				elsif (LR = "01") then --Logic right
					Parallel_sig <= '0' & parallel_sig(3 downto 1);
				elsif (LR = "10") then --Arithmetic  left
					Parallel_sig <= Parallel_sig(2 downto 0) & '0';
				elsif (LR = "11") then --Arithmetic right
					Parallel_sig <= Parallel_sig(3) & parallel_sig(3 downto 1);
				end if;
			elsif (Load = '1') then
				parallel_sig <= Parallel_IN;
			end if;
		end if;
	end process;
	
	reg_out <= parallel_sig;
		
end Behavioral;

