--  node_24.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_24 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R36_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R89_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_24;
architecture Behavioral of node_24 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R36_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R36_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R89_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R36_command = LOCK or R65_command = LOCK or R66_command = LOCK or R89_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;