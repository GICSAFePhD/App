--  singleSwitch_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_9 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R67_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R77_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw04 : out singleSwitchStates
		);
	end entity singleSwitch_9;
architecture Behavioral of singleSwitch_9 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R67_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R77_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R67_command = RESERVE or R68_command = RESERVE) and (R5_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R77_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R67_command = RELEASE and R68_command = RELEASE) and (R5_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R77_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R67_command = LOCK or R68_command = LOCK) and (R5_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R77_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R67_command = RELEASE and R68_command = RELEASE) and (R5_command = LOCK or R69_command = LOCK or R70_command = LOCK or R77_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R67_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R77_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw04 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw04 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw04 <= TRANSITION;
				end if;
			else
				if (R5_command = RESERVE or R67_command = RESERVE or R68_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R77_command = RESERVE) then
					correspondence_Sw04 <= RESERVED;
				end if;
				if (R5_command = LOCK or R67_command = LOCK or R68_command = LOCK or R69_command = LOCK or R70_command = LOCK or R77_command = LOCK) then
					correspondence_Sw04 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;