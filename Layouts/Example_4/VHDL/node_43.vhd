--  node_43.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_43 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R65_command : in routeCommands;
			R86_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_43;
architecture Behavioral of node_43 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R65_command = RELEASE and R86_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R65_command = RESERVE or R86_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R65_command = LOCK or R86_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;