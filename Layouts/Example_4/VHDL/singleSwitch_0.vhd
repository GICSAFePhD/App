--  singleSwitch_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_0 is
		port(
			clock : in std_logic;
			R20_command : in routeCommands;
			R41_command : in routeCommands;
			R42_command : in routeCommands;
			R43_command : in routeCommands;
			R49_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D01 : out singleSwitchStates
		);
	end entity singleSwitch_0;
architecture Behavioral of singleSwitch_0 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R20_command = RELEASE and R41_command = RELEASE and R42_command = RELEASE and R43_command = RELEASE and R49_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R20_command = RESERVE or R42_command = RESERVE) and (R41_command = RELEASE and R43_command = RELEASE and R49_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R20_command = RELEASE and R42_command = RELEASE) and (R41_command = RESERVE or R43_command = RESERVE or R49_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R20_command = LOCK or R42_command = LOCK) and (R41_command = RELEASE and R43_command = RELEASE and R49_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R20_command = RELEASE and R42_command = RELEASE) and (R41_command = LOCK or R43_command = LOCK or R49_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R20_command = RELEASE and R41_command = RELEASE and R42_command = RELEASE and R43_command = RELEASE and R49_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D01 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D01 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D01 <= TRANSITION;
				end if;
			else
				if (R20_command = RESERVE or R41_command = RESERVE or R42_command = RESERVE or R43_command = RESERVE or R49_command = RESERVE) then
					correspondence_D01 <= RESERVED;
				end if;
				if (R20_command = LOCK or R41_command = LOCK or R42_command = LOCK or R43_command = LOCK or R49_command = LOCK) then
					correspondence_D01 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;