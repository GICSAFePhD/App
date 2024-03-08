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
			R70_command : in routeCommands;
			R71_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_3;
architecture Behavioral of node_3 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R70_command = RELEASE and R71_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R70_command = RESERVE or R71_command = RESERVE or R84_command = RESERVE or R85_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R70_command = LOCK or R71_command = LOCK or R84_command = LOCK or R85_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;