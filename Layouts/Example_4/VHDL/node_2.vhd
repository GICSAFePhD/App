--  node_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R36_command : in routeCommands;
			R38_command : in routeCommands;
			R70_command : in routeCommands;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_2;
architecture Behavioral of node_2 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R36_command = RELEASE and R38_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R72_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R4_command = RESERVE or R36_command = RESERVE or R38_command = RESERVE or R70_command = RESERVE or R71_command = RESERVE or R72_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R4_command = LOCK or R36_command = LOCK or R38_command = LOCK or R70_command = LOCK or R71_command = LOCK or R72_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;