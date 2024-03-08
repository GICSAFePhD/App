--  node_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R27_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R48_command : in routeCommands;
			R50_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_7;
architecture Behavioral of node_7 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R27_command = RELEASE and R46_command = RELEASE and R47_command = RELEASE and R48_command = RELEASE and R50_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R27_command = RESERVE or R46_command = RESERVE or R47_command = RESERVE or R48_command = RESERVE or R50_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R27_command = LOCK or R46_command = LOCK or R47_command = LOCK or R48_command = LOCK or R50_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;