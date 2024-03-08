--  singleSwitch_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_10 is
		port(
			clock : in std_logic;
			R60_command : in routeCommands;
			R61_command : in routeCommands;
			R62_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_71W01 : out singleSwitchStates
		);
	end entity singleSwitch_10;
architecture Behavioral of singleSwitch_10 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R60_command = RELEASE and R61_command = RELEASE and R62_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R60_command = RESERVE or R62_command = RESERVE) and (R61_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R60_command = RELEASE and R62_command = RELEASE) and (R61_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R60_command = LOCK or R62_command = LOCK) and (R61_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R60_command = RELEASE and R62_command = RELEASE) and (R61_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R60_command = RELEASE and R61_command = RELEASE and R62_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_71W01 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_71W01 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_71W01 <= TRANSITION;
				end if;
			else
				if (R60_command = RESERVE or R61_command = RESERVE or R62_command = RESERVE) then
					correspondence_71W01 <= RESERVED;
				end if;
				if (R60_command = LOCK or R61_command = LOCK or R62_command = LOCK) then
					correspondence_71W01 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;