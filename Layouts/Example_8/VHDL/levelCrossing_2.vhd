--  levelCrossing_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_2 is
		port(
			clock : in std_logic;
			ocupation_ne23 : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne27 : in std_logic;
			R4_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc09 : out levelCrossingStates
		);
	end entity levelCrossing_2;
architecture Behavioral of levelCrossing_2 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE) then
				command_aux <= ocupation_ne23 and ocupation_ne25 and ocupation_ne27;
			else
				if (R4_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R4_command = LOCK or R9_command = LOCK or R10_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Lc09 <= DOWN;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Lc09 <= UP;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Lc09 <= TRANSITION;
				end if;
			else
				if (R4_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE) then
					correspondence_Lc09 <= RESERVED;
				end if;
				if (R4_command = LOCK or R9_command = LOCK or R10_command = LOCK) then
					correspondence_Lc09 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;