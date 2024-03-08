--  singleSwitch_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_4 is
		port(
			clock : in std_logic;
			R65_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			R86_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw01 : out singleSwitchStates
		);
	end entity singleSwitch_4;
architecture Behavioral of singleSwitch_4 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R65_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE and R86_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R84_command = RESERVE or R85_command = RESERVE) and (R65_command = RELEASE and R86_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R84_command = RELEASE and R85_command = RELEASE) and (R65_command = RESERVE or R86_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R84_command = LOCK or R85_command = LOCK) and (R65_command = RELEASE and R86_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R84_command = RELEASE and R85_command = RELEASE) and (R65_command = LOCK or R86_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R65_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE and R86_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw01 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw01 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw01 <= TRANSITION;
				end if;
			else
				if (R65_command = RESERVE or R84_command = RESERVE or R85_command = RESERVE or R86_command = RESERVE) then
					correspondence_Sw01 <= RESERVED;
				end if;
				if (R65_command = LOCK or R84_command = LOCK or R85_command = LOCK or R86_command = LOCK) then
					correspondence_Sw01 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;