--  singleSwitch_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_2 is
		port(
			clock : in std_logic;
			R3_command : in routeCommands;
			R42_command : in routeCommands;
			R44_command : in routeCommands;
			R45_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_69W04 : out singleSwitchStates
		);
	end entity singleSwitch_2;
architecture Behavioral of singleSwitch_2 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R42_command = RELEASE and R44_command = RELEASE and R45_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R3_command = RESERVE or R45_command = RESERVE) and (R42_command = RELEASE and R44_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R3_command = RELEASE and R45_command = RELEASE) and (R42_command = RESERVE or R44_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R3_command = LOCK or R45_command = LOCK) and (R42_command = RELEASE and R44_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R3_command = RELEASE and R45_command = RELEASE) and (R42_command = LOCK or R44_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R42_command = RELEASE and R44_command = RELEASE and R45_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_69W04 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_69W04 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_69W04 <= TRANSITION;
				end if;
			else
				if (R3_command = RESERVE or R42_command = RESERVE or R44_command = RESERVE or R45_command = RESERVE) then
					correspondence_69W04 <= RESERVED;
				end if;
				if (R3_command = LOCK or R42_command = LOCK or R44_command = LOCK or R45_command = LOCK) then
					correspondence_69W04 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;