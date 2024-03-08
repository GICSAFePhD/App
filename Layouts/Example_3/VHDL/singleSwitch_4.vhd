--  singleSwitch_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_4 is
		port(
			clock : in std_logic;
			R27_command : in routeCommands;
			R48_command : in routeCommands;
			R50_command : in routeCommands;
			R51_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_70W02 : out singleSwitchStates
		);
	end entity singleSwitch_4;
architecture Behavioral of singleSwitch_4 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R27_command = RELEASE and R48_command = RELEASE and R50_command = RELEASE and R51_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R27_command = RESERVE or R48_command = RESERVE or R50_command = RESERVE) and (R51_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R27_command = RELEASE and R48_command = RELEASE and R50_command = RELEASE) and (R51_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R27_command = LOCK or R48_command = LOCK or R50_command = LOCK) and (R51_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R27_command = RELEASE and R48_command = RELEASE and R50_command = RELEASE) and (R51_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R27_command = RELEASE and R48_command = RELEASE and R50_command = RELEASE and R51_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_70W02 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_70W02 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_70W02 <= TRANSITION;
				end if;
			else
				if (R27_command = RESERVE or R48_command = RESERVE or R50_command = RESERVE or R51_command = RESERVE) then
					correspondence_70W02 <= RESERVED;
				end if;
				if (R27_command = LOCK or R48_command = LOCK or R50_command = LOCK or R51_command = LOCK) then
					correspondence_70W02 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;