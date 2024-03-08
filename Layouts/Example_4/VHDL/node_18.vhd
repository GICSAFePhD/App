--  node_18.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_18 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R77_command : in routeCommands;
			R79_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_18;
architecture Behavioral of node_18 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R7_command = RELEASE and R77_command = RELEASE and R79_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R6_command = RESERVE or R7_command = RESERVE or R77_command = RESERVE or R79_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R6_command = LOCK or R7_command = LOCK or R77_command = LOCK or R79_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;