--  singleSwitch_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_3 is
		port(
			clock : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw04 : out singleSwitchStates
		);
	end entity singleSwitch_3;
architecture Behavioral of singleSwitch_3 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R8_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R7_command = RESERVE or R15_command = RESERVE) and (R8_command = RELEASE and R16_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R7_command = RELEASE and R15_command = RELEASE) and (R8_command = RESERVE or R16_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R7_command = LOCK or R15_command = LOCK) and (R8_command = RELEASE and R16_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R7_command = RELEASE and R15_command = RELEASE) and (R8_command = LOCK or R16_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R8_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE) then
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
				if (R7_command = RESERVE or R8_command = RESERVE or R15_command = RESERVE or R16_command = RESERVE) then
					correspondence_Sw04 <= RESERVED;
				end if;
				if (R7_command = LOCK or R8_command = LOCK or R15_command = LOCK or R16_command = LOCK) then
					correspondence_Sw04 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;