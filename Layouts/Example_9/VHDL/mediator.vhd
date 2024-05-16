--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N : natural := 91;
			N_SIGNALS : natural := 25;
			N_ROUTES : natural := 27;
			N_LEVELCROSSINGS : natural := 3;
			N_SINGLESWITCHES : natural := 4;
			N_TRACKCIRCUITS : natural := 7
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			signals : in signals_type;
			routes : in std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings : in std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			output : out std_logic_vector(84-1 downto 0);
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
					output(26 downto 0) <= routes;
					output(27) <= signals.msb(0);
					output(28) <= signals.lsb(0);
					output(29) <= signals.msb(1);
					output(30) <= signals.lsb(1);
					output(31) <= signals.msb(2);
					output(32) <= signals.lsb(2);
					output(33) <= signals.msb(3);
					output(34) <= signals.lsb(3);
					output(35) <= signals.msb(4);
					output(36) <= signals.lsb(4);
					output(37) <= signals.msb(5);
					output(38) <= signals.lsb(5);
					output(39) <= signals.msb(6);
					output(40) <= signals.lsb(6);
					output(41) <= signals.msb(7);
					output(42) <= signals.lsb(7);
					output(43) <= signals.msb(8);
					output(44) <= signals.lsb(8);
					output(45) <= signals.msb(9);
					output(46) <= signals.lsb(9);
					output(47) <= signals.msb(10);
					output(48) <= signals.lsb(10);
					output(49) <= signals.msb(11);
					output(50) <= signals.lsb(11);
					output(51) <= signals.msb(12);
					output(52) <= signals.lsb(12);
					output(53) <= signals.msb(13);
					output(54) <= signals.lsb(13);
					output(55) <= signals.msb(14);
					output(56) <= signals.lsb(14);
					output(57) <= signals.msb(15);
					output(58) <= signals.lsb(15);
					output(59) <= signals.msb(16);
					output(60) <= signals.lsb(16);
					output(61) <= signals.msb(17);
					output(62) <= signals.lsb(17);
					output(63) <= signals.msb(18);
					output(64) <= signals.lsb(18);
					output(65) <= signals.msb(19);
					output(66) <= signals.lsb(19);
					output(67) <= signals.msb(20);
					output(68) <= signals.lsb(20);
					output(69) <= signals.msb(21);
					output(70) <= signals.lsb(21);
					output(71) <= signals.msb(22);
					output(72) <= signals.lsb(22);
					output(73) <= signals.msb(23);
					output(74) <= signals.lsb(23);
					output(75) <= signals.msb(24);
					output(76) <= signals.lsb(24);
					output(79 downto 77) <= levelCrossings;
					output(83 downto 80) <= singleSwitches;
				end if;
			end if;
		end if;
	end process;
end Behavioral;