--  singleSwitch_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_5 is
		port(
			clock : in std_logic;
			R59_command : in routeCommands;
			R61_command : in routeCommands;
			R62_command : in routeCommands;
			R82_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D10 : out singleSwitchStates
		);
	end entity singleSwitch_5;
architecture Behavioral of singleSwitch_5 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R59_command = RELEASE and R61_command = RELEASE and R62_command = RELEASE and R82_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R59_command = RESERVE or R61_command = RESERVE) and (R62_command = RELEASE and R82_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R59_command = RELEASE and R61_command = RELEASE) and (R62_command = RESERVE or R82_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R59_command = LOCK or R61_command = LOCK) and (R62_command = RELEASE and R82_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R59_command = RELEASE and R61_command = RELEASE) and (R62_command = LOCK or R82_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R59_command = RELEASE and R61_command = RELEASE and R62_command = RELEASE and R82_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D10 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D10 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D10 <= TRANSITION;
				end if;
			else
				if (R59_command = RESERVE or R61_command = RESERVE or R62_command = RESERVE or R82_command = RESERVE) then
					correspondence_D10 <= RESERVED;
				end if;
				if (R59_command = LOCK or R61_command = LOCK or R62_command = LOCK or R82_command = LOCK) then
					correspondence_D10 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;