--  singleSwitch_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_1 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw11 : out singleSwitchStates
		);
	end entity singleSwitch_1;
architecture Behavioral of singleSwitch_1 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE and R13_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R6_command = RESERVE or R9_command = RESERVE) and (R10_command = RELEASE and R13_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R6_command = RELEASE and R9_command = RELEASE) and (R10_command = RESERVE or R13_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R6_command = LOCK or R9_command = LOCK) and (R10_command = RELEASE and R13_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R6_command = RELEASE and R9_command = RELEASE) and (R10_command = LOCK or R13_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE and R13_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw11 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw11 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw11 <= TRANSITION;
				end if;
			else
				if (R6_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE or R13_command = RESERVE) then
					correspondence_Sw11 <= RESERVED;
				end if;
				if (R6_command = LOCK or R9_command = LOCK or R10_command = LOCK or R13_command = LOCK) then
					correspondence_Sw11 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;