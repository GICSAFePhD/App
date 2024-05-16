--  flipFlop.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity flipFlop is
		port(
			clock : in std_logic;
			reset : in std_logic;
			Q : out std_logic
		);
	end entity flipFlop;
architecture Behavioral of flipFlop is
	signal Q_aux : std_logic;
begin
	flip_flop : process(clock)
	begin
		if (reset = '1') then
			Q_aux <= '0';
		elsif(rising_edge(clock)) then
			Q_aux <= not Q_aux;
		end if;
	end process;
	Q <= Q_aux;
end Behavioral;