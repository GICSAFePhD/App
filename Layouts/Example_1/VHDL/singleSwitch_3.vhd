--  singleSwitch_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_3 is
		port(
			clock : in std_logic;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw07 : out singleSwitchStates
		);
	end entity singleSwitch_3;
architecture Behavioral of singleSwitch_3 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R12_command = RELEASE and R13_command = RELEASE and R17_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R13_command = RESERVE or R17_command = RESERVE) and (R8_command = RELEASE and R12_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R13_command = RELEASE and R17_command = RELEASE) and (R8_command = RESERVE or R12_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R13_command = LOCK or R17_command = LOCK) and (R8_command = RELEASE and R12_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R13_command = RELEASE and R17_command = RELEASE) and (R8_command = LOCK or R12_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R12_command = RELEASE and R13_command = RELEASE and R17_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw07 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw07 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw07 <= TRANSITION;
				end if;
			else
				if (R8_command = RESERVE or R12_command = RESERVE or R13_command = RESERVE or R17_command = RESERVE) then
					correspondence_Sw07 <= RESERVED;
				end if;
				if (R8_command = LOCK or R12_command = LOCK or R13_command = LOCK or R17_command = LOCK) then
					correspondence_Sw07 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;