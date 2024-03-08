--  levelCrossing_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_5 is
		port(
			clock : in std_logic;
			ocupation_ne100 : in std_logic;
			ocupation_ne992 : in std_logic;
			ocupation_ne101 : in std_logic;
			R32_command : in routeCommands;
			R34_command : in routeCommands;
			R35_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc06 : out levelCrossingStates
		);
	end entity levelCrossing_5;
architecture Behavioral of levelCrossing_5 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R32_command = RELEASE and R34_command = RELEASE and R35_command = RELEASE) then
				command_aux <= ocupation_ne100 and ocupation_ne992 and ocupation_ne101;
			else
				if (R32_command = RESERVE or R34_command = RESERVE or R35_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R32_command = LOCK or R34_command = LOCK or R35_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R32_command = RELEASE and R34_command = RELEASE and R35_command = RELEASE) then
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
				if (R32_command = RESERVE or R34_command = RESERVE or R35_command = RESERVE) then
					correspondence_Lc06 <= RESERVED;
				end if;
				if (R32_command = LOCK or R34_command = LOCK or R35_command = LOCK) then
					correspondence_Lc06 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;