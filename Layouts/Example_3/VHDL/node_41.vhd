--  node_41.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_41 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R20_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			R86_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_41;
architecture Behavioral of node_41 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R6_command = RELEASE and R20_command = RELEASE and R78_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE and R86_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R6_command = RESERVE or R20_command = RESERVE or R78_command = RESERVE or R84_command = RESERVE or R85_command = RESERVE or R86_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R6_command = LOCK or R20_command = LOCK or R78_command = LOCK or R84_command = LOCK or R85_command = LOCK or R86_command = LOCK) then
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