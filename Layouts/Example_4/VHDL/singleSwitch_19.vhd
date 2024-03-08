--  singleSwitch_19.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_19 is
		port(
			clock : in std_logic;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R15_command : in routeCommands;
			R80_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D21 : out singleSwitchStates
		);
	end entity singleSwitch_19;
architecture Behavioral of singleSwitch_19 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R9_command = RELEASE and R15_command = RELEASE and R80_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R9_command = RESERVE or R15_command = RESERVE) and (R8_command = RELEASE and R80_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R9_command = RELEASE and R15_command = RELEASE) and (R8_command = RESERVE or R80_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R9_command = LOCK or R15_command = LOCK) and (R8_command = RELEASE and R80_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R9_command = RELEASE and R15_command = RELEASE) and (R8_command = LOCK or R80_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R9_command = RELEASE and R15_command = RELEASE and R80_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D21 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D21 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D21 <= TRANSITION;
				end if;
			else
				if (R8_command = RESERVE or R9_command = RESERVE or R15_command = RESERVE or R80_command = RESERVE) then
					correspondence_D21 <= RESERVED;
				end if;
				if (R8_command = LOCK or R9_command = LOCK or R15_command = LOCK or R80_command = LOCK) then
					correspondence_D21 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;