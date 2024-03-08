--  node_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R41_command : in routeCommands;
			R43_command : in routeCommands;
			R45_command : in routeCommands;
			R46_command : in routeCommands;
			R49_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_7;
architecture Behavioral of node_7 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R41_command = RELEASE and R43_command = RELEASE and R45_command = RELEASE and R46_command = RELEASE and R49_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R41_command = RESERVE or R43_command = RESERVE or R45_command = RESERVE or R46_command = RESERVE or R49_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R41_command = LOCK or R43_command = LOCK or R45_command = LOCK or R46_command = LOCK or R49_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;