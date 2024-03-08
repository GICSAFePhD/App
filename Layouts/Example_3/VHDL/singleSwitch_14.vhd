--  singleSwitch_14.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_14 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			R86_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw41 : out singleSwitchStates
		);
	end entity singleSwitch_14;
architecture Behavioral of singleSwitch_14 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R78_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE and R86_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R84_command = RESERVE or R85_command = RESERVE) and (R6_command = RELEASE and R78_command = RELEASE and R86_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R84_command = RELEASE and R85_command = RELEASE) and (R6_command = RESERVE or R78_command = RESERVE or R86_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R84_command = LOCK or R85_command = LOCK) and (R6_command = RELEASE and R78_command = RELEASE and R86_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R84_command = RELEASE and R85_command = RELEASE) and (R6_command = LOCK or R78_command = LOCK or R86_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R78_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE and R86_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw41 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw41 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw41 <= TRANSITION;
				end if;
			else
				if (R6_command = RESERVE or R78_command = RESERVE or R84_command = RESERVE or R85_command = RESERVE or R86_command = RESERVE) then
					correspondence_Sw41 <= RESERVED;
				end if;
				if (R6_command = LOCK or R78_command = LOCK or R84_command = LOCK or R85_command = LOCK or R86_command = LOCK) then
					correspondence_Sw41 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;