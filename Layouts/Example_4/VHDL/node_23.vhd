--  node_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_23 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			R32_command : in routeCommands;
			R34_command : in routeCommands;
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			R59_command : in routeCommands;
			R82_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_23;
architecture Behavioral of node_23 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R25_command = RELEASE and R26_command = RELEASE and R32_command = RELEASE and R34_command = RELEASE and R39_command = RELEASE and R40_command = RELEASE and R59_command = RELEASE and R82_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R25_command = RESERVE or R26_command = RESERVE or R32_command = RESERVE or R34_command = RESERVE or R39_command = RESERVE or R40_command = RESERVE or R59_command = RESERVE or R82_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R25_command = LOCK or R26_command = LOCK or R32_command = LOCK or R34_command = LOCK or R39_command = LOCK or R40_command = LOCK or R59_command = LOCK or R82_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;