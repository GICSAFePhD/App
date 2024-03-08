--  singleSwitch_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_7 is
		port(
			clock : in std_logic;
			R8_command : in routeCommands;
			R28_command : in routeCommands;
			R80_command : in routeCommands;
			R81_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D20 : out singleSwitchStates
		);
	end entity singleSwitch_7;
architecture Behavioral of singleSwitch_7 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R28_command = RELEASE and R80_command = RELEASE and R81_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R28_command = RESERVE or R81_command = RESERVE) and (R8_command = RELEASE and R80_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R28_command = RELEASE and R81_command = RELEASE) and (R8_command = RESERVE or R80_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R28_command = LOCK or R81_command = LOCK) and (R8_command = RELEASE and R80_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R28_command = RELEASE and R81_command = RELEASE) and (R8_command = LOCK or R80_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R28_command = RELEASE and R80_command = RELEASE and R81_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D20 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D20 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D20 <= TRANSITION;
				end if;
			else
				if (R8_command = RESERVE or R28_command = RESERVE or R80_command = RESERVE or R81_command = RESERVE) then
					correspondence_D20 <= RESERVED;
				end if;
				if (R8_command = LOCK or R28_command = LOCK or R80_command = LOCK or R81_command = LOCK) then
					correspondence_D20 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;