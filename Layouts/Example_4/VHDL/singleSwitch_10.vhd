--  singleSwitch_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_10 is
		port(
			clock : in std_logic;
			R2_command : in routeCommands;
			R22_command : in routeCommands;
			R66_command : in routeCommands;
			R67_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D14 : out singleSwitchStates
		);
	end entity singleSwitch_10;
architecture Behavioral of singleSwitch_10 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R22_command = RELEASE and R66_command = RELEASE and R67_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R22_command = RESERVE or R66_command = RESERVE) and (R2_command = RELEASE and R67_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R22_command = RELEASE and R66_command = RELEASE) and (R2_command = RESERVE or R67_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R22_command = LOCK or R66_command = LOCK) and (R2_command = RELEASE and R67_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R22_command = RELEASE and R66_command = RELEASE) and (R2_command = LOCK or R67_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R22_command = RELEASE and R66_command = RELEASE and R67_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D14 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D14 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D14 <= TRANSITION;
				end if;
			else
				if (R2_command = RESERVE or R22_command = RESERVE or R66_command = RESERVE or R67_command = RESERVE) then
					correspondence_D14 <= RESERVED;
				end if;
				if (R2_command = LOCK or R22_command = LOCK or R66_command = LOCK or R67_command = LOCK) then
					correspondence_D14 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;