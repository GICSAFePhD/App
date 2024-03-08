--  node_35.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_35 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R59_command : in routeCommands;
			R61_command : in routeCommands;
			R75_command : in routeCommands;
			R78_command : in routeCommands;
			R79_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_35;
architecture Behavioral of node_35 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R59_command = RELEASE and R61_command = RELEASE and R75_command = RELEASE and R78_command = RELEASE and R79_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R7_command = RESERVE or R59_command = RESERVE or R61_command = RESERVE or R75_command = RESERVE or R78_command = RESERVE or R79_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R7_command = LOCK or R59_command = LOCK or R61_command = LOCK or R75_command = LOCK or R78_command = LOCK or R79_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;