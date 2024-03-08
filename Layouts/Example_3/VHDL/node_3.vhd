--  node_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			R26_command : in routeCommands;
			R38_command : in routeCommands;
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_3;
architecture Behavioral of node_3 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R23_command = RELEASE and R24_command = RELEASE and R26_command = RELEASE and R38_command = RELEASE and R39_command = RELEASE and R40_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R23_command = RESERVE or R24_command = RESERVE or R26_command = RESERVE or R38_command = RESERVE or R39_command = RESERVE or R40_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R23_command = LOCK or R24_command = LOCK or R26_command = LOCK or R38_command = LOCK or R39_command = LOCK or R40_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;