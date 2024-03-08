--  singleSwitch_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_0 is
		port(
			clock : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw01 : out singleSwitchStates
		);
	end entity singleSwitch_0;
architecture Behavioral of singleSwitch_0 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R3_command = RELEASE and R4_command = RELEASE and R5_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R2_command = RESERVE or R4_command = RESERVE) and (R3_command = RELEASE and R5_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R2_command = RELEASE and R4_command = RELEASE) and (R3_command = RESERVE or R5_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R2_command = LOCK or R4_command = LOCK) and (R3_command = RELEASE and R5_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R2_command = RELEASE and R4_command = RELEASE) and (R3_command = LOCK or R5_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R3_command = RELEASE and R4_command = RELEASE and R5_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw01 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw01 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw01 <= TRANSITION;
				end if;
			else
				if (R2_command = RESERVE or R3_command = RESERVE or R4_command = RESERVE or R5_command = RESERVE) then
					correspondence_Sw01 <= RESERVED;
				end if;
				if (R2_command = LOCK or R3_command = LOCK or R4_command = LOCK or R5_command = LOCK) then
					correspondence_Sw01 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;