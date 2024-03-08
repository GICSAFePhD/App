--  singleSwitch_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_1 is
		port(
			clock : in std_logic;
			R9_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw06 : out singleSwitchStates
		);
	end entity singleSwitch_1;
architecture Behavioral of singleSwitch_1 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R9_command = RELEASE and R14_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R14_command = RESERVE or R15_command = RESERVE) and (R9_command = RELEASE and R16_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R14_command = RELEASE and R15_command = RELEASE) and (R9_command = RESERVE or R16_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R14_command = LOCK or R15_command = LOCK) and (R9_command = RELEASE and R16_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R14_command = RELEASE and R15_command = RELEASE) and (R9_command = LOCK or R16_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R9_command = RELEASE and R14_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw06 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw06 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw06 <= TRANSITION;
				end if;
			else
				if (R9_command = RESERVE or R14_command = RESERVE or R15_command = RESERVE or R16_command = RESERVE) then
					correspondence_Sw06 <= RESERVED;
				end if;
				if (R9_command = LOCK or R14_command = LOCK or R15_command = LOCK or R16_command = LOCK) then
					correspondence_Sw06 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;