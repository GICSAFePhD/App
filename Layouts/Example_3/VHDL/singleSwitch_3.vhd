--  singleSwitch_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_3 is
		port(
			clock : in std_logic;
			R36_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R89_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw06 : out singleSwitchStates
		);
	end entity singleSwitch_3;
architecture Behavioral of singleSwitch_3 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R36_command = RELEASE and R63_command = RELEASE and R64_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R63_command = RESERVE or R64_command = RESERVE) and (R36_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R63_command = RELEASE and R64_command = RELEASE) and (R36_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R89_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R63_command = LOCK or R64_command = LOCK) and (R36_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R63_command = RELEASE and R64_command = RELEASE) and (R36_command = LOCK or R65_command = LOCK or R66_command = LOCK or R89_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R36_command = RELEASE and R63_command = RELEASE and R64_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw06 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw06 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw06 <= TRANSITION;
				end if;
			else
				if (R36_command = RESERVE or R63_command = RESERVE or R64_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R89_command = RESERVE) then
					correspondence_Sw06 <= RESERVED;
				end if;
				if (R36_command = LOCK or R63_command = LOCK or R64_command = LOCK or R65_command = LOCK or R66_command = LOCK or R89_command = LOCK) then
					correspondence_Sw06 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;