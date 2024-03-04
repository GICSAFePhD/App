--  singleSwitch_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_1 is
		port(
			clock : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw14 : out singleSwitchStates
		);
	end entity singleSwitch_1;
architecture Behavioral of singleSwitch_1 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R3_command = RELEASE and R7_command = RELEASE and R8_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R3_command = RESERVE or R8_command = RESERVE) and (R2_command = RELEASE and R7_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R3_command = RELEASE and R8_command = RELEASE) and (R2_command = RESERVE or R7_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R3_command = LOCK or R8_command = LOCK) and (R2_command = RELEASE and R7_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R3_command = RELEASE and R8_command = RELEASE) and (R2_command = LOCK or R7_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R3_command = RELEASE and R7_command = RELEASE and R8_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw14 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw14 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw14 <= TRANSITION;
				end if;
			else
				if (R2_command = RESERVE or R3_command = RESERVE or R7_command = RESERVE or R8_command = RESERVE) then
					correspondence_Sw14 <= RESERVED;
				end if;
				if (R2_command = LOCK or R3_command = LOCK or R7_command = LOCK or R8_command = LOCK) then
					correspondence_Sw14 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;