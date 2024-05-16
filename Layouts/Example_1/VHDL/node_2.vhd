--  node_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_2;
architecture Behavioral of node_2 is
	signal commandState : routeCommands := RELEASE;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE and R18_command = RELEASE and R19_command = RELEASE and R21_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R5_command = RESERVE or R10_command = RESERVE or R11_command = RESERVE or R18_command = RESERVE or R19_command = RESERVE or R21_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R5_command = LOCK or R10_command = LOCK or R11_command = LOCK or R18_command = LOCK or R19_command = LOCK or R21_command = LOCK) then
					commandState <= LOCK;
				end if;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				locking <= RELEASED;
			when RESERVE => -- DONT CHANGE
				locking <= RESERVED;
			when LOCK => -- DONT CHANGE
				locking <= LOCKED;
			when others =>
				locking <= LOCKED;
		end case;
	end process;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (ocupation = '1') then
				state <= FREE;
			else
				state <= OCCUPIED;
			end if;
		end if;
	end process;
end Behavioral;