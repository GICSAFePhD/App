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
			R24_command : in routeCommands;
			R33_command : in routeCommands;
			R79_command : in routeCommands;
			R80_command : in routeCommands;
			R81_command : in routeCommands;
			R84_command : in routeCommands;
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
				if (R24_command = RELEASE and R33_command = RELEASE and R79_command = RELEASE and R80_command = RELEASE and R81_command = RELEASE and R84_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R24_command = RESERVE or R33_command = RESERVE or R79_command = RESERVE or R80_command = RESERVE or R81_command = RESERVE or R84_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R24_command = LOCK or R33_command = LOCK or R79_command = LOCK or R80_command = LOCK or R81_command = LOCK or R84_command = LOCK) then
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