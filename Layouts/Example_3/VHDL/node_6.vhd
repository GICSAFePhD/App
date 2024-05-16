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
			R41_command : in routeCommands;
			R43_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
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
				if (R41_command = RELEASE and R43_command = RELEASE and R63_command = RELEASE and R64_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R41_command = RESERVE or R43_command = RESERVE or R63_command = RESERVE or R64_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R41_command = LOCK or R43_command = LOCK or R63_command = LOCK or R64_command = LOCK) then
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