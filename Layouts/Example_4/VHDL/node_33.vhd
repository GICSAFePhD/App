--  node_33.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_33 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R16_command : in routeCommands;
			R60_command : in routeCommands;
			R74_command : in routeCommands;
			R76_command : in routeCommands;
			R77_command : in routeCommands;
			R82_command : in routeCommands;
			R83_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_33;
architecture Behavioral of node_33 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R16_command = RELEASE and R60_command = RELEASE and R74_command = RELEASE and R76_command = RELEASE and R77_command = RELEASE and R82_command = RELEASE and R83_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R6_command = RESERVE or R16_command = RESERVE or R60_command = RESERVE or R74_command = RESERVE or R76_command = RESERVE or R77_command = RESERVE or R82_command = RESERVE or R83_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R6_command = LOCK or R16_command = LOCK or R60_command = LOCK or R74_command = LOCK or R76_command = LOCK or R77_command = LOCK or R82_command = LOCK or R83_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;