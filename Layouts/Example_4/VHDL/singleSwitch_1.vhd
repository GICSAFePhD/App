--  singleSwitch_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_1 is
		port(
			clock : in std_logic;
			R55_command : in routeCommands;
			R57_command : in routeCommands;
			R58_command : in routeCommands;
			R69_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D08 : out singleSwitchStates
		);
	end entity singleSwitch_1;
architecture Behavioral of singleSwitch_1 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R55_command = RELEASE and R57_command = RELEASE and R58_command = RELEASE and R69_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R55_command = RESERVE or R57_command = RESERVE) and (R58_command = RELEASE and R69_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R55_command = RELEASE and R57_command = RELEASE) and (R58_command = RESERVE or R69_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R55_command = LOCK or R57_command = LOCK) and (R58_command = RELEASE and R69_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R55_command = RELEASE and R57_command = RELEASE) and (R58_command = LOCK or R69_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R55_command = RELEASE and R57_command = RELEASE and R58_command = RELEASE and R69_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D08 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D08 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D08 <= TRANSITION;
				end if;
			else
				if (R55_command = RESERVE or R57_command = RESERVE or R58_command = RESERVE or R69_command = RESERVE) then
					correspondence_D08 <= RESERVED;
				end if;
				if (R55_command = LOCK or R57_command = LOCK or R58_command = LOCK or R69_command = LOCK) then
					correspondence_D08 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;