--  singleSwitch_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_5 is
		port(
			clock : in std_logic;
			R28_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R48_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_70W01 : out singleSwitchStates
		);
	end entity singleSwitch_5;
architecture Behavioral of singleSwitch_5 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R28_command = RELEASE and R46_command = RELEASE and R47_command = RELEASE and R48_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R28_command = RESERVE) and (R46_command = RELEASE and R47_command = RELEASE and R48_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R28_command = RELEASE) and (R46_command = RESERVE or R47_command = RESERVE or R48_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R28_command = LOCK) and (R46_command = RELEASE and R47_command = RELEASE and R48_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R28_command = RELEASE) and (R46_command = LOCK or R47_command = LOCK or R48_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R28_command = RELEASE and R46_command = RELEASE and R47_command = RELEASE and R48_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_70W01 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_70W01 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_70W01 <= TRANSITION;
				end if;
			else
				if (R28_command = RESERVE or R46_command = RESERVE or R47_command = RESERVE or R48_command = RESERVE) then
					correspondence_70W01 <= RESERVED;
				end if;
				if (R28_command = LOCK or R46_command = LOCK or R47_command = LOCK or R48_command = LOCK) then
					correspondence_70W01 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;