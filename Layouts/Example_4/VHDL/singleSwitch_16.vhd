--  singleSwitch_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_16 is
		port(
			clock : in std_logic;
			R13_command : in routeCommands;
			R52_command : in routeCommands;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D07 : out singleSwitchStates
		);
	end entity singleSwitch_16;
architecture Behavioral of singleSwitch_16 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R13_command = RELEASE and R52_command = RELEASE and R53_command = RELEASE and R54_command = RELEASE and R56_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R52_command = RESERVE or R53_command = RESERVE) and (R13_command = RELEASE and R54_command = RELEASE and R56_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R52_command = RELEASE and R53_command = RELEASE) and (R13_command = RESERVE or R54_command = RESERVE or R56_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R52_command = LOCK or R53_command = LOCK) and (R13_command = RELEASE and R54_command = RELEASE and R56_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R52_command = RELEASE and R53_command = RELEASE) and (R13_command = LOCK or R54_command = LOCK or R56_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R13_command = RELEASE and R52_command = RELEASE and R53_command = RELEASE and R54_command = RELEASE and R56_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D07 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D07 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D07 <= TRANSITION;
				end if;
			else
				if (R13_command = RESERVE or R52_command = RESERVE or R53_command = RESERVE or R54_command = RESERVE or R56_command = RESERVE) then
					correspondence_D07 <= RESERVED;
				end if;
				if (R13_command = LOCK or R52_command = LOCK or R53_command = LOCK or R54_command = LOCK or R56_command = LOCK) then
					correspondence_D07 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;