--  node_14.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_14 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R13_command : in routeCommands;
			R52_command : in routeCommands;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			R65_command : in routeCommands;
			R86_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_14;
architecture Behavioral of node_14 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R13_command = RELEASE and R52_command = RELEASE and R53_command = RELEASE and R54_command = RELEASE and R56_command = RELEASE and R63_command = RELEASE and R64_command = RELEASE and R65_command = RELEASE and R86_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R13_command = RESERVE or R52_command = RESERVE or R53_command = RESERVE or R54_command = RESERVE or R56_command = RESERVE or R63_command = RESERVE or R64_command = RESERVE or R65_command = RESERVE or R86_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R13_command = LOCK or R52_command = LOCK or R53_command = LOCK or R54_command = LOCK or R56_command = LOCK or R63_command = LOCK or R64_command = LOCK or R65_command = LOCK or R86_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;