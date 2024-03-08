--  levelCrossing_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_3 is
		port(
			clock : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne23 : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc05 : out levelCrossingStates
		);
	end entity levelCrossing_3;
architecture Behavioral of levelCrossing_3 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R6_command = RELEASE) then
				command_aux <= ocupation_ne25 and ocupation_ne23;
			else
				if (R5_command = RESERVE or R6_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R5_command = LOCK or R6_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R6_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Lc05 <= DOWN;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Lc05 <= UP;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Lc05 <= TRANSITION;
				end if;
			else
				if (R5_command = RESERVE or R6_command = RESERVE) then
					correspondence_Lc05 <= RESERVED;
				end if;
				if (R5_command = LOCK or R6_command = LOCK) then
					correspondence_Lc05 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;