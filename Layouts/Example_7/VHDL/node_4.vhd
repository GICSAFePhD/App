--  node_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_4;
architecture Behavioral of node_4 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R6_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R6_command = LOCK or R9_command = LOCK or R10_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;