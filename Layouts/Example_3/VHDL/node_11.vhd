--  node_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_11 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R52_command : in routeCommands;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R55_command : in routeCommands;
			R73_command : in routeCommands;
			R74_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_11;
architecture Behavioral of node_11 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R8_command = RELEASE and R52_command = RELEASE and R53_command = RELEASE and R54_command = RELEASE and R55_command = RELEASE and R73_command = RELEASE and R74_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R7_command = RESERVE or R8_command = RESERVE or R52_command = RESERVE or R53_command = RESERVE or R54_command = RESERVE or R55_command = RESERVE or R73_command = RESERVE or R74_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R7_command = LOCK or R8_command = LOCK or R52_command = LOCK or R53_command = LOCK or R54_command = LOCK or R55_command = LOCK or R73_command = LOCK or R74_command = LOCK or R75_command = LOCK or R76_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;