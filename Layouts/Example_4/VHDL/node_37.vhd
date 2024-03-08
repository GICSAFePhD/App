--  node_37.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_37 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R27_command : in routeCommands;
			R28_command : in routeCommands;
			R73_command : in routeCommands;
			R81_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_37;
architecture Behavioral of node_37 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R27_command = RELEASE and R28_command = RELEASE and R73_command = RELEASE and R81_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R27_command = RESERVE or R28_command = RESERVE or R73_command = RESERVE or R81_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R27_command = LOCK or R28_command = LOCK or R73_command = LOCK or R81_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;