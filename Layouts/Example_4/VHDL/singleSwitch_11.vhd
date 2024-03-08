--  singleSwitch_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_11 is
		port(
			clock : in std_logic;
			R21_command : in routeCommands;
			R89_command : in routeCommands;
			R90_command : in routeCommands;
			R91_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw04 : out singleSwitchStates
		);
	end entity singleSwitch_11;
architecture Behavioral of singleSwitch_11 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R21_command = RELEASE and R89_command = RELEASE and R90_command = RELEASE and R91_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R21_command = RESERVE or R90_command = RESERVE) and (R89_command = RELEASE and R91_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R21_command = RELEASE and R90_command = RELEASE) and (R89_command = RESERVE or R91_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R21_command = LOCK or R90_command = LOCK) and (R89_command = RELEASE and R91_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R21_command = RELEASE and R90_command = RELEASE) and (R89_command = LOCK or R91_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R21_command = RELEASE and R89_command = RELEASE and R90_command = RELEASE and R91_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw04 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw04 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw04 <= TRANSITION;
				end if;
			else
				if (R21_command = RESERVE or R89_command = RESERVE or R90_command = RESERVE or R91_command = RESERVE) then
					correspondence_Sw04 <= RESERVED;
				end if;
				if (R21_command = LOCK or R89_command = LOCK or R90_command = LOCK or R91_command = LOCK) then
					correspondence_Sw04 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;