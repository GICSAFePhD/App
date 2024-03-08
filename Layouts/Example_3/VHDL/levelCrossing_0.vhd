--  levelCrossing_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_0 is
		port(
			clock : in std_logic;
			ocupation_ne95 : in std_logic;
			ocupation_ne9 : in std_logic;
			ocupation_ne59 : in std_logic;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
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
			if (R25_command = RELEASE and R26_command = RELEASE) then
				command_aux <= ocupation_ne95 and ocupation_ne9 and ocupation_ne59;
			else
				if (R25_command = RESERVE or R26_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R25_command = LOCK or R26_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R25_command = RELEASE and R26_command = RELEASE) then
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
				if (R25_command = RESERVE or R26_command = RESERVE) then
					correspondence_Lc01 <= RESERVED;
				end if;
				if (R25_command = LOCK or R26_command = LOCK) then
					correspondence_Lc01 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;