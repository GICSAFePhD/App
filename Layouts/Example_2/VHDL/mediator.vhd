--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N : natural := 44;
			N_SIGNALS : natural := 12;
			N_ROUTES : natural := 10;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 2;
			N_TRACKCIRCUITS : natural := 7
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			signals : in signals_type;
			routes : in std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings : in std_logic;
			singleSwitches : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			output : out std_logic_vector(37-1 downto 0);
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
					output(9 downto 0) <= routes;
					output(10) <= signals.msb(0);
					output(11) <= signals.lsb(0);
					output(12) <= signals.msb(1);
					output(13) <= signals.lsb(1);
					output(14) <= signals.msb(2);
					output(15) <= signals.lsb(2);
					output(16) <= signals.msb(3);
					output(17) <= signals.lsb(3);
					output(18) <= signals.msb(4);
					output(19) <= signals.lsb(4);
					output(20) <= signals.msb(5);
					output(21) <= signals.lsb(5);
					output(22) <= signals.msb(6);
					output(23) <= signals.lsb(6);
					output(24) <= signals.msb(7);
					output(25) <= signals.lsb(7);
					output(26) <= signals.msb(8);
					output(27) <= signals.lsb(8);
					output(28) <= signals.msb(9);
					output(29) <= signals.lsb(9);
					output(30) <= signals.msb(10);
					output(31) <= signals.lsb(10);
					output(32) <= signals.msb(11);
					output(33) <= signals.lsb(11);
					output(34) <= levelCrossings;
					output(36 downto 35) <= singleSwitches;
				end if;
			end if;
		end if;
	end process;
end Behavioral;