--  node_42.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_42 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_42;
architecture Behavioral of node_42 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R63_command = RELEASE and R64_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R63_command = RESERVE or R64_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R63_command = LOCK or R64_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;