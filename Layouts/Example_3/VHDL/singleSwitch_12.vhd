--  singleSwitch_12.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_12 is
		port(
			clock : in std_logic;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw11 : out singleSwitchStates
		);
	end entity singleSwitch_12;
architecture Behavioral of singleSwitch_12 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R71_command = RELEASE and R72_command = RELEASE and R73_command = RELEASE and R75_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R71_command = RESERVE or R72_command = RESERVE) and (R73_command = RELEASE and R75_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R71_command = RELEASE and R72_command = RELEASE) and (R73_command = RESERVE or R75_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R71_command = LOCK or R72_command = LOCK) and (R73_command = RELEASE and R75_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R71_command = RELEASE and R72_command = RELEASE) and (R73_command = LOCK or R75_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R71_command = RELEASE and R72_command = RELEASE and R73_command = RELEASE and R75_command = RELEASE) then
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
				if (R71_command = RESERVE or R72_command = RESERVE or R73_command = RESERVE or R75_command = RESERVE) then
					correspondence_Sw11 <= RESERVED;
				end if;
				if (R71_command = LOCK or R72_command = LOCK or R73_command = LOCK or R75_command = LOCK) then
					correspondence_Sw11 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;