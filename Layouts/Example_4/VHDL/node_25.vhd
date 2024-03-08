--  node_25.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_25 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R11_command : in routeCommands;
			R48_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_25;
architecture Behavioral of node_25 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R11_command = RELEASE and R48_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R11_command = RESERVE or R48_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R11_command = LOCK or R48_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;