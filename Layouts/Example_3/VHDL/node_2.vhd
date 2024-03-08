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
			R2_command : in routeCommands;
			R23_command : in routeCommands;
			R40_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_2;
architecture Behavioral of node_2 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R23_command = RELEASE and R40_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R2_command = RESERVE or R23_command = RESERVE or R40_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R2_command = LOCK or R23_command = LOCK or R40_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;