--  singleSwitch_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_20 is
		port(
			clock : in std_logic;
			R16_command : in routeCommands;
			R60_command : in routeCommands;
			R82_command : in routeCommands;
			R83_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D24 : out singleSwitchStates
		);
	end entity singleSwitch_20;
architecture Behavioral of singleSwitch_20 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R16_command = RELEASE and R60_command = RELEASE and R82_command = RELEASE and R83_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R60_command = RESERVE or R82_command = RESERVE) and (R16_command = RELEASE and R83_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R60_command = RELEASE and R82_command = RELEASE) and (R16_command = RESERVE or R83_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R60_command = LOCK or R82_command = LOCK) and (R16_command = RELEASE and R83_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R60_command = RELEASE and R82_command = RELEASE) and (R16_command = LOCK or R83_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R16_command = RELEASE and R60_command = RELEASE and R82_command = RELEASE and R83_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D24 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D24 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D24 <= TRANSITION;
				end if;
			else
				if (R16_command = RESERVE or R60_command = RESERVE or R82_command = RESERVE or R83_command = RESERVE) then
					correspondence_D24 <= RESERVED;
				end if;
				if (R16_command = LOCK or R60_command = LOCK or R82_command = LOCK or R83_command = LOCK) then
					correspondence_D24 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;