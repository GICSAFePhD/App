--  node_14.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R13_command : in routeCommands;
			R48_command : in routeCommands;
			R49_command : in routeCommands;
			R50_command : in routeCommands;
			R52_command : in routeCommands;
			R81_command : in routeCommands;
			R82_command : in routeCommands;
			R83_command : in routeCommands;
			R84_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_14;
architecture Behavioral of node_14 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R13_command = RELEASE and R48_command = RELEASE and R49_command = RELEASE and R50_command = RELEASE and R52_command = RELEASE and R81_command = RELEASE and R82_command = RELEASE and R83_command = RELEASE and R84_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R13_command = RESERVE or R48_command = RESERVE or R49_command = RESERVE or R50_command = RESERVE or R52_command = RESERVE or R81_command = RESERVE or R82_command = RESERVE or R83_command = RESERVE or R84_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R13_command = LOCK or R48_command = LOCK or R49_command = LOCK or R50_command = LOCK or R52_command = LOCK or R81_command = LOCK or R82_command = LOCK or R83_command = LOCK or R84_command = LOCK) then
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