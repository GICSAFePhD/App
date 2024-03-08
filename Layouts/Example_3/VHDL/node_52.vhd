--  node_52.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_52 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R59_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_52;
architecture Behavioral of node_52 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R54_command = RELEASE and R56_command = RELEASE and R58_command = RELEASE and R59_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R54_command = RESERVE or R56_command = RESERVE or R58_command = RESERVE or R59_command = RESERVE or R84_command = RESERVE or R85_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R54_command = LOCK or R56_command = LOCK or R58_command = LOCK or R59_command = LOCK or R84_command = LOCK or R85_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;