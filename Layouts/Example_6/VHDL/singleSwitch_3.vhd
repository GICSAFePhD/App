--  singleSwitch_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_3 is
		port(
			clock : in std_logic;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw05 : out singleSwitchStates
		);
	end entity singleSwitch_3;
architecture Behavioral of singleSwitch_3 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R6_command = RELEASE and R18_command = RELEASE and R19_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R6_command = RESERVE or R19_command = RESERVE) and (R3_command = RELEASE and R18_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R6_command = RELEASE and R19_command = RELEASE) and (R3_command = RESERVE or R18_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R6_command = LOCK or R19_command = LOCK) and (R3_command = RELEASE and R18_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R6_command = RELEASE and R19_command = RELEASE) and (R3_command = LOCK or R18_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R6_command = RELEASE and R18_command = RELEASE and R19_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw05 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw05 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw05 <= TRANSITION;
				end if;
			else
				if (R3_command = RESERVE or R6_command = RESERVE or R18_command = RESERVE or R19_command = RESERVE) then
					correspondence_Sw05 <= RESERVED;
				end if;
				if (R3_command = LOCK or R6_command = LOCK or R18_command = LOCK or R19_command = LOCK) then
					correspondence_Sw05 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;