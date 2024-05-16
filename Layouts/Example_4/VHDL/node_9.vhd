--  node_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R61_command : in routeCommands;
			R88_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_9;
architecture Behavioral of node_9 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R21_command = RELEASE and R22_command = RELEASE and R61_command = RELEASE and R88_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R21_command = RESERVE or R22_command = RESERVE or R61_command = RESERVE or R88_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R21_command = LOCK or R22_command = LOCK or R61_command = LOCK or R88_command = LOCK) then
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