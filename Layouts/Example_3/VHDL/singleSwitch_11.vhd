--  singleSwitch_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_11 is
		port(
			clock : in std_logic;
			R4_command : in routeCommands;
			R61_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_71W02 : out singleSwitchStates
		);
	end entity singleSwitch_11;
architecture Behavioral of singleSwitch_11 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R61_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R61_command = RESERVE) and (R4_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R61_command = RELEASE) and (R4_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R61_command = LOCK) and (R4_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R61_command = RELEASE) and (R4_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R61_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_71W02 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_71W02 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_71W02 <= TRANSITION;
				end if;
			else
				if (R4_command = RESERVE or R61_command = RESERVE) then
					correspondence_71W02 <= RESERVED;
				end if;
				if (R4_command = LOCK or R61_command = LOCK) then
					correspondence_71W02 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;