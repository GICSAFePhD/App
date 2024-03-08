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
			R43_command : in routeCommands;
			R45_command : in routeCommands;
			R47_command : in routeCommands;
			R50_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_10;
architecture Behavioral of node_10 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R43_command = RELEASE and R45_command = RELEASE and R47_command = RELEASE and R50_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R43_command = RESERVE or R45_command = RESERVE or R47_command = RESERVE or R50_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R43_command = LOCK or R45_command = LOCK or R47_command = LOCK or R50_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;