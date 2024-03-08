--  singleSwitch_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_0 is
		port(
			clock : in std_logic;
			R23_command : in routeCommands;
			R38_command : in routeCommands;
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_68W02 : out singleSwitchStates
		);
	end entity singleSwitch_0;
architecture Behavioral of singleSwitch_0 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R23_command = RELEASE and R38_command = RELEASE and R39_command = RELEASE and R40_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R38_command = RESERVE or R39_command = RESERVE) and (R23_command = RELEASE and R40_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R38_command = RELEASE and R39_command = RELEASE) and (R23_command = RESERVE or R40_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R38_command = LOCK or R39_command = LOCK) and (R23_command = RELEASE and R40_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R38_command = RELEASE and R39_command = RELEASE) and (R23_command = LOCK or R40_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R23_command = RELEASE and R38_command = RELEASE and R39_command = RELEASE and R40_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_68W02 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_68W02 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_68W02 <= TRANSITION;
				end if;
			else
				if (R23_command = RESERVE or R38_command = RESERVE or R39_command = RESERVE or R40_command = RESERVE) then
					correspondence_68W02 <= RESERVED;
				end if;
				if (R23_command = LOCK or R38_command = LOCK or R39_command = LOCK or R40_command = LOCK) then
					correspondence_68W02 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;