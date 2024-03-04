--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N : natural := 45;
			N_SIGNALS : natural := 12;
			N_ROUTES : natural := 11;
			N_SINGLESWITCHES : natural := 3;
			N_TRACKCIRCUITS : natural := 7
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			signals : in signals_type;
			routes : in std_logic_vector(N_ROUTES-1 downto 0);
			singleSwitches : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			output : out std_logic_vector(38-1 downto 0);
			reset : in std_logic
		);
	end entity mediator;
architecture Behavioral of mediator is
begin
	process(clock,reset)
	begin
		if (clock = '1' and Clock'Event) then
			if (reset = '1') then
				output <= (others => '0');
				processed <= '0';
			else
				processed <= processing;
				if (processing = '1') then
					output(10 downto 0) <= routes;
					output(11) <= signals.msb(0);
					output(12) <= signals.lsb(0);
					output(13) <= signals.msb(1);
					output(14) <= signals.lsb(1);
					output(15) <= signals.msb(2);
					output(16) <= signals.lsb(2);
					output(17) <= signals.msb(3);
					output(18) <= signals.lsb(3);
					output(19) <= signals.msb(4);
					output(20) <= signals.lsb(4);
					output(21) <= signals.msb(5);
					output(22) <= signals.lsb(5);
					output(23) <= signals.msb(6);
					output(24) <= signals.lsb(6);
					output(25) <= signals.msb(7);
					output(26) <= signals.lsb(7);
					output(27) <= signals.msb(8);
					output(28) <= signals.lsb(8);
					output(29) <= signals.msb(9);
					output(30) <= signals.lsb(9);
					output(31) <= signals.msb(10);
					output(32) <= signals.lsb(10);
					output(33) <= signals.msb(11);
					output(34) <= signals.lsb(11);
					output(37 downto 35) <= singleSwitches;
				end if;
			end if;
		end if;
	end process;
end Behavioral;