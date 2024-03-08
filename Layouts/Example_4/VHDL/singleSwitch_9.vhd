--  singleSwitch_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_9 is
		port(
			clock : in std_logic;
			R43_command : in routeCommands;
			R45_command : in routeCommands;
			R46_command : in routeCommands;
			R49_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D03 : out singleSwitchStates
		);
	end entity singleSwitch_9;
architecture Behavioral of singleSwitch_9 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R43_command = RELEASE and R45_command = RELEASE and R46_command = RELEASE and R49_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R43_command = RESERVE or R45_command = RESERVE) and (R46_command = RELEASE and R49_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R43_command = RELEASE and R45_command = RELEASE) and (R46_command = RESERVE or R49_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R43_command = LOCK or R45_command = LOCK) and (R46_command = RELEASE and R49_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R43_command = RELEASE and R45_command = RELEASE) and (R46_command = LOCK or R49_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R43_command = RELEASE and R45_command = RELEASE and R46_command = RELEASE and R49_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D03 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D03 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D03 <= TRANSITION;
				end if;
			else
				if (R43_command = RESERVE or R45_command = RESERVE or R46_command = RESERVE or R49_command = RESERVE) then
					correspondence_D03 <= RESERVED;
				end if;
				if (R43_command = LOCK or R45_command = LOCK or R46_command = LOCK or R49_command = LOCK) then
					correspondence_D03 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;