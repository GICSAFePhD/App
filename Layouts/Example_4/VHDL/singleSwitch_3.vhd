--  singleSwitch_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_3 is
		port(
			clock : in std_logic;
			R4_command : in routeCommands;
			R70_command : in routeCommands;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D18 : out singleSwitchStates
		);
	end entity singleSwitch_3;
architecture Behavioral of singleSwitch_3 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R72_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R70_command = RESERVE or R71_command = RESERVE) and (R4_command = RELEASE and R72_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R70_command = RELEASE and R71_command = RELEASE) and (R4_command = RESERVE or R72_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R70_command = LOCK or R71_command = LOCK) and (R4_command = RELEASE and R72_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R70_command = RELEASE and R71_command = RELEASE) and (R4_command = LOCK or R72_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R72_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D18 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D18 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D18 <= TRANSITION;
				end if;
			else
				if (R4_command = RESERVE or R70_command = RESERVE or R71_command = RESERVE or R72_command = RESERVE) then
					correspondence_D18 <= RESERVED;
				end if;
				if (R4_command = LOCK or R70_command = LOCK or R71_command = LOCK or R72_command = LOCK) then
					correspondence_D18 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;