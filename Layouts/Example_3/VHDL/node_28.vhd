--  node_28.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_28 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_28;
architecture Behavioral of node_28 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R71_command = RELEASE and R72_command = RELEASE and R73_command = RELEASE and R75_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R71_command = RESERVE or R72_command = RESERVE or R73_command = RESERVE or R75_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R71_command = LOCK or R72_command = LOCK or R73_command = LOCK or R75_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;