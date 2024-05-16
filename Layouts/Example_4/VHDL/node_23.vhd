--  node_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			R32_command : in routeCommands;
			R37_command : in routeCommands;
			R38_command : in routeCommands;
			R55_command : in routeCommands;
			R77_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_23;
architecture Behavioral of node_23 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R25_command = RELEASE and R26_command = RELEASE and R32_command = RELEASE and R37_command = RELEASE and R38_command = RELEASE and R55_command = RELEASE and R77_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R25_command = RESERVE or R26_command = RESERVE or R32_command = RESERVE or R37_command = RESERVE or R38_command = RESERVE or R55_command = RESERVE or R77_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R25_command = LOCK or R26_command = LOCK or R32_command = LOCK or R37_command = LOCK or R38_command = LOCK or R55_command = LOCK or R77_command = LOCK) then
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