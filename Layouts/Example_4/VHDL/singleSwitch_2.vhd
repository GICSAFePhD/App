--  singleSwitch_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_2 is
		port(
			clock : in std_logic;
			R36_command : in routeCommands;
			R37_command : in routeCommands;
			R38_command : in routeCommands;
			R55_command : in routeCommands;
			R69_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D05 : out singleSwitchStates
		);
	end entity singleSwitch_2;
architecture Behavioral of singleSwitch_2 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R36_command = RELEASE and R37_command = RELEASE and R38_command = RELEASE and R55_command = RELEASE and R69_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R36_command = RESERVE or R38_command = RESERVE) and (R37_command = RELEASE and R55_command = RELEASE and R69_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R36_command = RELEASE and R38_command = RELEASE) and (R37_command = RESERVE or R55_command = RESERVE or R69_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R36_command = LOCK or R38_command = LOCK) and (R37_command = RELEASE and R55_command = RELEASE and R69_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R36_command = RELEASE and R38_command = RELEASE) and (R37_command = LOCK or R55_command = LOCK or R69_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R36_command = RELEASE and R37_command = RELEASE and R38_command = RELEASE and R55_command = RELEASE and R69_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D05 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D05 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D05 <= TRANSITION;
				end if;
			else
				if (R36_command = RESERVE or R37_command = RESERVE or R38_command = RESERVE or R55_command = RESERVE or R69_command = RESERVE) then
					correspondence_D05 <= RESERVED;
				end if;
				if (R36_command = LOCK or R37_command = LOCK or R38_command = LOCK or R55_command = LOCK or R69_command = LOCK) then
					correspondence_D05 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;