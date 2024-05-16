--  node_21.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R30_command : in routeCommands;
			R34_command : in routeCommands;
			R35_command : in routeCommands;
			R36_command : in routeCommands;
			R51_command : in routeCommands;
			R64_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_21;
architecture Behavioral of node_21 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R30_command = RELEASE and R34_command = RELEASE and R35_command = RELEASE and R36_command = RELEASE and R51_command = RELEASE and R64_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R30_command = RESERVE or R34_command = RESERVE or R35_command = RESERVE or R36_command = RESERVE or R51_command = RESERVE or R64_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R30_command = LOCK or R34_command = LOCK or R35_command = LOCK or R36_command = LOCK or R51_command = LOCK or R64_command = LOCK) then
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