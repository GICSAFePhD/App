--  node_48.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_48 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R65_command : in routeCommands;
			R81_command : in routeCommands;
			R82_command : in routeCommands;
			R89_command : in routeCommands;
			R90_command : in routeCommands;
			R91_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_48;
architecture Behavioral of node_48 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R65_command = RELEASE and R81_command = RELEASE and R82_command = RELEASE and R89_command = RELEASE and R90_command = RELEASE and R91_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R65_command = RESERVE or R81_command = RESERVE or R82_command = RESERVE or R89_command = RESERVE or R90_command = RESERVE or R91_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R65_command = LOCK or R81_command = LOCK or R82_command = LOCK or R89_command = LOCK or R90_command = LOCK or R91_command = LOCK) then
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