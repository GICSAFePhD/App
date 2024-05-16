--  node_13.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R11_command : in routeCommands;
			R42_command : in routeCommands;
			R47_command : in routeCommands;
			R59_command : in routeCommands;
			R60_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_13;
architecture Behavioral of node_13 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R11_command = RELEASE and R42_command = RELEASE and R47_command = RELEASE and R59_command = RELEASE and R60_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R11_command = RESERVE or R42_command = RESERVE or R47_command = RESERVE or R59_command = RESERVE or R60_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R11_command = LOCK or R42_command = LOCK or R47_command = LOCK or R59_command = LOCK or R60_command = LOCK) then
						commandState <= LOCK;
					end if;
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