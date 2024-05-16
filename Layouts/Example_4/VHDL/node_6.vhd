--  node_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R10_command : in routeCommands;
			R17_command : in routeCommands;
			R27_command : in routeCommands;
			R29_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R71_command : in routeCommands;
			R73_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_6;
architecture Behavioral of node_6 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R10_command = RELEASE and R17_command = RELEASE and R27_command = RELEASE and R29_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R73_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R10_command = RESERVE or R17_command = RESERVE or R27_command = RESERVE or R29_command = RESERVE or R68_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R71_command = RESERVE or R73_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R10_command = LOCK or R17_command = LOCK or R27_command = LOCK or R29_command = LOCK or R68_command = LOCK or R69_command = LOCK or R70_command = LOCK or R71_command = LOCK or R73_command = LOCK) then
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