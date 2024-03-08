--  singleSwitch_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_8 is
		port(
			clock : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R73_command : in routeCommands;
			R74_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw12 : out singleSwitchStates
		);
	end entity singleSwitch_8;
architecture Behavioral of singleSwitch_8 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R8_command = RELEASE and R73_command = RELEASE and R74_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R7_command = RESERVE or R74_command = RESERVE) and (R8_command = RELEASE and R73_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R8_command = RESERVE or R73_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R7_command = LOCK or R74_command = LOCK) and (R8_command = RELEASE and R73_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R7_command = RELEASE and R74_command = RELEASE) and (R8_command = LOCK or R73_command = LOCK or R75_command = LOCK or R76_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R8_command = RELEASE and R73_command = RELEASE and R74_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw12 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw12 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw12 <= TRANSITION;
				end if;
			else
				if (R7_command = RESERVE or R8_command = RESERVE or R73_command = RESERVE or R74_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE) then
					correspondence_Sw12 <= RESERVED;
				end if;
				if (R7_command = LOCK or R8_command = LOCK or R73_command = LOCK or R74_command = LOCK or R75_command = LOCK or R76_command = LOCK) then
					correspondence_Sw12 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;