--  node_12.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_12 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R67_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R77_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_12;
architecture Behavioral of node_12 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R56_command = RELEASE and R58_command = RELEASE and R67_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R77_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R5_command = RESERVE or R56_command = RESERVE or R58_command = RESERVE or R67_command = RESERVE or R68_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R77_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R5_command = LOCK or R56_command = LOCK or R58_command = LOCK or R67_command = LOCK or R68_command = LOCK or R69_command = LOCK or R70_command = LOCK or R77_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;