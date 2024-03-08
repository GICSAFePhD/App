--  levelCrossing_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_0 is
		port(
			clock : in std_logic;
			ocupation_ne16 : in std_logic;
			ocupation_ne14 : in std_logic;
			ocupation_ne15 : in std_logic;
			ocupation_ne18 : in std_logic;
			ocupation_ne17 : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc01 : out levelCrossingStates
		);
	end entity levelCrossing_0;
architecture Behavioral of levelCrossing_0 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R5_command = RELEASE and R7_command = RELEASE and R8_command = RELEASE) then
				command_aux <= ocupation_ne16 and ocupation_ne14 and ocupation_ne15 and ocupation_ne18 and ocupation_ne17;
			else
				if (R4_command = RESERVE or R5_command = RESERVE or R7_command = RESERVE or R8_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R4_command = LOCK or R5_command = LOCK or R7_command = LOCK or R8_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R5_command = RELEASE and R7_command = RELEASE and R8_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Lc01 <= DOWN;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Lc01 <= UP;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Lc01 <= TRANSITION;
				end if;
			else
				if (R4_command = RESERVE or R5_command = RESERVE or R7_command = RESERVE or R8_command = RESERVE) then
					correspondence_Lc01 <= RESERVED;
				end if;
				if (R4_command = LOCK or R5_command = LOCK or R7_command = LOCK or R8_command = LOCK) then
					correspondence_Lc01 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;