--  node_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_10 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R57_command : in routeCommands;
			R59_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_10;
architecture Behavioral of node_10 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R53_command = RELEASE and R54_command = RELEASE and R57_command = RELEASE and R59_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R53_command = RESERVE or R54_command = RESERVE or R57_command = RESERVE or R59_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R53_command = LOCK or R54_command = LOCK or R57_command = LOCK or R59_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;