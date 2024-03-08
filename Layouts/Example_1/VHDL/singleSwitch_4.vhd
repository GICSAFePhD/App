--  singleSwitch_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_4 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			R19_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw13 : out singleSwitchStates
		);
	end entity singleSwitch_4;
architecture Behavioral of singleSwitch_4 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R19_command = RELEASE and R20_command = RELEASE and R21_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R6_command = RESERVE or R20_command = RESERVE) and (R19_command = RELEASE and R21_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R6_command = RELEASE and R20_command = RELEASE) and (R19_command = RESERVE or R21_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R6_command = LOCK or R20_command = LOCK) and (R19_command = RELEASE and R21_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R6_command = RELEASE and R20_command = RELEASE) and (R19_command = LOCK or R21_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R19_command = RELEASE and R20_command = RELEASE and R21_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw13 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw13 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw13 <= TRANSITION;
				end if;
			else
				if (R6_command = RESERVE or R19_command = RESERVE or R20_command = RESERVE or R21_command = RESERVE) then
					correspondence_Sw13 <= RESERVED;
				end if;
				if (R6_command = LOCK or R19_command = LOCK or R20_command = LOCK or R21_command = LOCK) then
					correspondence_Sw13 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;