--  node_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_16 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R13_command : in routeCommands;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_16;
architecture Behavioral of node_16 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R13_command = RELEASE and R54_command = RELEASE and R56_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R13_command = RESERVE or R54_command = RESERVE or R56_command = RESERVE or R68_command = RESERVE or R69_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R13_command = LOCK or R54_command = LOCK or R56_command = LOCK or R68_command = LOCK or R69_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;