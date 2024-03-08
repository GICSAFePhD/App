--  node_47.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_47 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R78_command : in routeCommands;
			R79_command : in routeCommands;
			R80_command : in routeCommands;
			R86_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_47;
architecture Behavioral of node_47 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R78_command = RELEASE and R79_command = RELEASE and R80_command = RELEASE and R86_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R6_command = RESERVE or R78_command = RESERVE or R79_command = RESERVE or R80_command = RESERVE or R86_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R6_command = LOCK or R78_command = LOCK or R79_command = LOCK or R80_command = LOCK or R86_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;