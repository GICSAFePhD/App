--  node_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R26_command : in routeCommands;
			R28_command : in routeCommands;
			R39_command : in routeCommands;
			R80_command : in routeCommands;
			R81_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_5;
architecture Behavioral of node_5 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R26_command = RELEASE and R28_command = RELEASE and R39_command = RELEASE and R80_command = RELEASE and R81_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R8_command = RESERVE or R26_command = RESERVE or R28_command = RESERVE or R39_command = RESERVE or R80_command = RESERVE or R81_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R8_command = LOCK or R26_command = LOCK or R28_command = LOCK or R39_command = LOCK or R80_command = LOCK or R81_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;