--  node_51.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_51 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R14_command : in routeCommands;
			R35_command : in routeCommands;
			R36_command : in routeCommands;
			R37_command : in routeCommands;
			R66_command : in routeCommands;
			R83_command : in routeCommands;
			R88_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_51;
architecture Behavioral of node_51 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R14_command = RELEASE and R35_command = RELEASE and R36_command = RELEASE and R37_command = RELEASE and R66_command = RELEASE and R83_command = RELEASE and R88_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R14_command = RESERVE or R35_command = RESERVE or R36_command = RESERVE or R37_command = RESERVE or R66_command = RESERVE or R83_command = RESERVE or R88_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R14_command = LOCK or R35_command = LOCK or R36_command = LOCK or R37_command = LOCK or R66_command = LOCK or R83_command = LOCK or R88_command = LOCK) then
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