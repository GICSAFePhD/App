--  node_35.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_35 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R55_command : in routeCommands;
			R57_command : in routeCommands;
			R70_command : in routeCommands;
			R73_command : in routeCommands;
			R74_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_35;
architecture Behavioral of node_35 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R7_command = RELEASE and R55_command = RELEASE and R57_command = RELEASE and R70_command = RELEASE and R73_command = RELEASE and R74_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R7_command = RESERVE or R55_command = RESERVE or R57_command = RESERVE or R70_command = RESERVE or R73_command = RESERVE or R74_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R7_command = LOCK or R55_command = LOCK or R57_command = LOCK or R70_command = LOCK or R73_command = LOCK or R74_command = LOCK) then
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