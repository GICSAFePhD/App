--  node_39.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_39 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R9_command : in routeCommands;
			R19_command : in routeCommands;
			R34_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_39;
architecture Behavioral of node_39 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R9_command = RELEASE and R19_command = RELEASE and R34_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R9_command = RESERVE or R19_command = RESERVE or R34_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R9_command = LOCK or R19_command = LOCK or R34_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;