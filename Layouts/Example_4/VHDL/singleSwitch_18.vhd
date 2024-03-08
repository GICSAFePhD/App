--  singleSwitch_18.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_18 is
		port(
			clock : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R14_command : in routeCommands;
			R72_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_D19 : out singleSwitchStates
		);
	end entity singleSwitch_18;
architecture Behavioral of singleSwitch_18 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R5_command = RELEASE and R14_command = RELEASE and R72_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R5_command = RESERVE or R14_command = RESERVE) and (R4_command = RELEASE and R72_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R5_command = RELEASE and R14_command = RELEASE) and (R4_command = RESERVE or R72_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R5_command = LOCK or R14_command = LOCK) and (R4_command = RELEASE and R72_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R5_command = RELEASE and R14_command = RELEASE) and (R4_command = LOCK or R72_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R5_command = RELEASE and R14_command = RELEASE and R72_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_D19 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_D19 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_D19 <= TRANSITION;
				end if;
			else
				if (R4_command = RESERVE or R5_command = RESERVE or R14_command = RESERVE or R72_command = RESERVE) then
					correspondence_D19 <= RESERVED;
				end if;
				if (R4_command = LOCK or R5_command = LOCK or R14_command = LOCK or R72_command = LOCK) then
					correspondence_D19 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;