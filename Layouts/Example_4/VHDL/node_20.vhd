--  node_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_20 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R18_command : in routeCommands;
			R23_command : in routeCommands;
			R30_command : in routeCommands;
			R31_command : in routeCommands;
			R36_command : in routeCommands;
			R55_command : in routeCommands;
			R69_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_20;
architecture Behavioral of node_20 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R18_command = RELEASE and R23_command = RELEASE and R30_command = RELEASE and R31_command = RELEASE and R36_command = RELEASE and R55_command = RELEASE and R69_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R18_command = RESERVE or R23_command = RESERVE or R30_command = RESERVE or R31_command = RESERVE or R36_command = RESERVE or R55_command = RESERVE or R69_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R18_command = LOCK or R23_command = LOCK or R30_command = LOCK or R31_command = LOCK or R36_command = LOCK or R55_command = LOCK or R69_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;