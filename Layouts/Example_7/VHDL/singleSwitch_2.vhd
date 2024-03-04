--  singleSwitch_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_2 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw19 : out singleSwitchStates
		);
	end entity singleSwitch_2;
architecture Behavioral of singleSwitch_2 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R5_command = RESERVE or R11_command = RESERVE) and (R9_command = RELEASE and R10_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R5_command = RELEASE and R11_command = RELEASE) and (R9_command = RESERVE or R10_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R5_command = LOCK or R11_command = LOCK) and (R9_command = RELEASE and R10_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R5_command = RELEASE and R11_command = RELEASE) and (R9_command = LOCK or R10_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw19 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw19 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw19 <= TRANSITION;
				end if;
			else
				if (R5_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE or R11_command = RESERVE) then
					correspondence_Sw19 <= RESERVED;
				end if;
				if (R5_command = LOCK or R9_command = LOCK or R10_command = LOCK or R11_command = LOCK) then
					correspondence_Sw19 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;