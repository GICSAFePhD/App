--  levelCrossing_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_1 is
		port(
			clock : in std_logic;
			ocupation_ne14 : in std_logic;
			ocupation_ne9 : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc06 : out levelCrossingStates
		);
	end entity levelCrossing_1;
architecture Behavioral of levelCrossing_1 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R8_command = RELEASE) then
				command_aux <= ocupation_ne14 and ocupation_ne9;
			else
				if (R7_command = RESERVE or R8_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R7_command = LOCK or R8_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R8_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Lc06 <= DOWN;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Lc06 <= UP;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Lc06 <= TRANSITION;
				end if;
			else
				if (R7_command = RESERVE or R8_command = RESERVE) then
					correspondence_Lc06 <= RESERVED;
				end if;
				if (R7_command = LOCK or R8_command = LOCK) then
					correspondence_Lc06 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;