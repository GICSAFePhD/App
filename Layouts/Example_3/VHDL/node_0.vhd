--  node_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R38_command : in routeCommands;
			R39_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_0;
architecture Behavioral of node_0 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R1_command = RELEASE and R38_command = RELEASE and R39_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R1_command = RESERVE or R38_command = RESERVE or R39_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R1_command = LOCK or R38_command = LOCK or R39_command = LOCK) then
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