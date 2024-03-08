--  singleSwitch_13.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity singleSwitch_13 is
		port(
			clock : in std_logic;
			R87_command : in routeCommands;
			R88_command : in routeCommands;
			R89_command : in routeCommands;
			R91_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw03 : out singleSwitchStates
		);
	end entity singleSwitch_13;
architecture Behavioral of singleSwitch_13 is
signal command_aux : std_logic;
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R87_command = RELEASE and R88_command = RELEASE and R89_command = RELEASE and R91_command = RELEASE) then
				command_aux <= indication;
			else
				if ((R87_command = RESERVE or R88_command = RESERVE) and (R89_command = RELEASE and R91_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R87_command = RELEASE and R88_command = RELEASE) and (R89_command = RESERVE or R91_command = RESERVE)) then
					command_aux <= '1';
				end if;
				if ((R87_command = LOCK or R88_command = LOCK) and (R89_command = RELEASE and R91_command = RELEASE)) then
					command_aux <= '0';
				end if;
				if ((R87_command = RELEASE and R88_command = RELEASE) and (R89_command = LOCK or R91_command = LOCK)) then
					command_aux <= '1';
				end if;
			end if;
		end if;
	end process;
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R87_command = RELEASE and R88_command = RELEASE and R89_command = RELEASE and R91_command = RELEASE) then
				if (command_aux = '0' and indication = '0') then
					correspondence_Sw03 <= NORMAL;
				end if;
				if (command_aux = '1' and indication = '1') then
					correspondence_Sw03 <= REVERSE;
				end if;
				if ((command_aux = '0' and indication = '1') or (command_aux = '1' and indication = '0')) then
					correspondence_Sw03 <= TRANSITION;
				end if;
			else
				if (R87_command = RESERVE or R88_command = RESERVE or R89_command = RESERVE or R91_command = RESERVE) then
					correspondence_Sw03 <= RESERVED;
				end if;
				if (R87_command = LOCK or R88_command = LOCK or R89_command = LOCK or R91_command = LOCK) then
					correspondence_Sw03 <= LOCKED;
				end if;
			end if;
		end if;
	end process;
	command <= command_aux;
end Behavioral;