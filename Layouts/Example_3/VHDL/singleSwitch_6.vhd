--  singleSwitch_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_6 is
		port(
			clock : in std_logic;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R59_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw09 : out singleSwitchStates
		);
	end entity singleSwitch_6;
architecture Behavioral of singleSwitch_6 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R54_command = RELEASE and R56_command = RELEASE and R58_command = RELEASE and R59_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R56_command = RESERVE or R58_command = RESERVE) and (R54_command = RELEASE and R59_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R56_command = RELEASE and R58_command = RELEASE) and (R54_command = RESERVE or R59_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R56_command = LOCK or R58_command = LOCK) and (R54_command = RELEASE and R59_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R56_command = RELEASE and R58_command = RELEASE) and (R54_command = LOCK or R59_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R54_command = RELEASE and R56_command = RELEASE and R58_command = RELEASE and R59_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw09 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw09 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw09 <= TRANSITION;
				end if;
			else
				if (R54_command = RESERVE or R56_command = RESERVE or R58_command = RESERVE or R59_command = RESERVE) then
					correspondence_Sw09 <= RESERVED;
				end if;
				if (R54_command = LOCK or R56_command = LOCK or R58_command = LOCK or R59_command = LOCK) then
					correspondence_Sw09 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;