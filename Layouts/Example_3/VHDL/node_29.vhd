--  node_29.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_29 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_29;
architecture Behavioral of node_29 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R73_command = RELEASE and R75_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R73_command = RESERVE or R75_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R73_command = LOCK or R75_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;