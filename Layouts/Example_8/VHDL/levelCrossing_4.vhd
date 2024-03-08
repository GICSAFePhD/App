--  levelCrossing_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_4 is
		port(
			clock : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne3 : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc03 : out levelCrossingStates
		);
	end entity levelCrossing_4;
architecture Behavioral of levelCrossing_4 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R1_command = RELEASE and R2_command = RELEASE) then
				command_aux <= ocupation_ne26 and ocupation_ne3;
			else
				if (R1_command = RESERVE or R2_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R1_command = LOCK or R2_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R1_command = RELEASE and R2_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Lc03 <= DOWN;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Lc03 <= UP;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Lc03 <= TRANSITION;
				end if;
			else
				if (R1_command = RESERVE or R2_command = RESERVE) then
					correspondence_Lc03 <= RESERVED;
				end if;
				if (R1_command = LOCK or R2_command = LOCK) then
					correspondence_Lc03 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;