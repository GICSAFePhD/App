--  node_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R40_command : in routeCommands;
			R59_command : in routeCommands;
			R61_command : in routeCommands;
			R62_command : in routeCommands;
			R82_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_4;
architecture Behavioral of node_4 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R40_command = RELEASE and R59_command = RELEASE and R61_command = RELEASE and R62_command = RELEASE and R82_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R40_command = RESERVE or R59_command = RESERVE or R61_command = RESERVE or R62_command = RESERVE or R82_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R40_command = LOCK or R59_command = LOCK or R61_command = LOCK or R62_command = LOCK or R82_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;