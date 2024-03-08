--  levelCrossing_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity levelCrossing_5 is
		port(
			clock : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne3 : in std_logic;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc04 : out levelCrossingStates
		);
	end entity levelCrossing_5;
architecture Behavioral of levelCrossing_5 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R11_command = RELEASE) then
				command_aux <= ocupation_ne26 and ocupation_ne3;
			else
				if (R2_command = RESERVE or R11_command = RESERVE) then
					command_aux <= '0';
				end if;
				if (R2_command = LOCK or R11_command = LOCK) then
					command_aux <= '0';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R11_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Lc04 <= DOWN;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Lc04 <= UP;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Lc04 <= TRANSITION;
				end if;
			else
				if (R2_command = RESERVE or R11_command = RESERVE) then
					correspondence_Lc04 <= RESERVED;
				end if;
				if (R2_command = LOCK or R11_command = LOCK) then
					correspondence_Lc04 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;