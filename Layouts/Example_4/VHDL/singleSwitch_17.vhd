--  singleSwitch_17.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_17 is
		port(
			clock : in std_logic;
			R13_command : in routeCommands;
			R56_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D16 : out singleSwitchStates
		);
	end entity singleSwitch_17;
architecture Behavioral of singleSwitch_17 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R13_command = RELEASE and R56_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R56_command = RESERVE or R69_command = RESERVE) and (R13_command = RELEASE and R68_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R56_command = RELEASE and R69_command = RELEASE) and (R13_command = RESERVE or R68_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R56_command = LOCK or R69_command = LOCK) and (R13_command = RELEASE and R68_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R56_command = RELEASE and R69_command = RELEASE) and (R13_command = LOCK or R68_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R13_command = RELEASE and R56_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D16 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D16 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D16 <= TRANSITION;
				end if;
			else
				if (R13_command = RESERVE or R56_command = RESERVE or R68_command = RESERVE or R69_command = RESERVE) then
					correspondence_D16 <= RESERVED;
				end if;
				if (R13_command = LOCK or R56_command = LOCK or R68_command = LOCK or R69_command = LOCK) then
					correspondence_D16 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;