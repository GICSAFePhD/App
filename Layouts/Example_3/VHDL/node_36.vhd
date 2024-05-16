--  node_36.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_36 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R17_command : in routeCommands;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			R41_command : in routeCommands;
			R44_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_36;
architecture Behavioral of node_36 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R17_command = RELEASE and R24_command = RELEASE and R25_command = RELEASE and R26_command = RELEASE and R41_command = RELEASE and R44_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R17_command = RESERVE or R24_command = RESERVE or R25_command = RESERVE or R26_command = RESERVE or R41_command = RESERVE or R44_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R17_command = LOCK or R24_command = LOCK or R25_command = LOCK or R26_command = LOCK or R41_command = LOCK or R44_command = LOCK) then
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