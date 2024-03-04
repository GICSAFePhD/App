--  singleSwitch_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_4 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw08 : out singleSwitchStates
		);
	end entity singleSwitch_4;
architecture Behavioral of singleSwitch_4 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R8_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R8_command = RESERVE or R21_command = RESERVE) and (R5_command = RELEASE and R22_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R8_command = RELEASE and R21_command = RELEASE) and (R5_command = RESERVE or R22_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R8_command = LOCK or R21_command = LOCK) and (R5_command = RELEASE and R22_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R8_command = RELEASE and R21_command = RELEASE) and (R5_command = LOCK or R22_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R8_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw08 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw08 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw08 <= TRANSITION;
				end if;
			else
				if (R5_command = RESERVE or R8_command = RESERVE or R21_command = RESERVE or R22_command = RESERVE) then
					correspondence_Sw08 <= RESERVED;
				end if;
				if (R5_command = LOCK or R8_command = LOCK or R21_command = LOCK or R22_command = LOCK) then
					correspondence_Sw08 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;