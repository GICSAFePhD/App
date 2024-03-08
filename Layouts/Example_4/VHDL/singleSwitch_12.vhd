--  singleSwitch_12.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_12 is
		port(
			clock : in std_logic;
			R11_command : in routeCommands;
			R44_command : in routeCommands;
			R47_command : in routeCommands;
			R50_command : in routeCommands;
			R51_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D04 : out singleSwitchStates
		);
	end entity singleSwitch_12;
architecture Behavioral of singleSwitch_12 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R11_command = RELEASE and R44_command = RELEASE and R47_command = RELEASE and R50_command = RELEASE and R51_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R47_command = RESERVE or R50_command = RESERVE) and (R11_command = RELEASE and R44_command = RELEASE and R51_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R47_command = RELEASE and R50_command = RELEASE) and (R11_command = RESERVE or R44_command = RESERVE or R51_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R47_command = LOCK or R50_command = LOCK) and (R11_command = RELEASE and R44_command = RELEASE and R51_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R47_command = RELEASE and R50_command = RELEASE) and (R11_command = LOCK or R44_command = LOCK or R51_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R11_command = RELEASE and R44_command = RELEASE and R47_command = RELEASE and R50_command = RELEASE and R51_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D04 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D04 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D04 <= TRANSITION;
				end if;
			else
				if (R11_command = RESERVE or R44_command = RESERVE or R47_command = RESERVE or R50_command = RESERVE or R51_command = RESERVE) then
					correspondence_D04 <= RESERVED;
				end if;
				if (R11_command = LOCK or R44_command = LOCK or R47_command = LOCK or R50_command = LOCK or R51_command = LOCK) then
					correspondence_D04 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;