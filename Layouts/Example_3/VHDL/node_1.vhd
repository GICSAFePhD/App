--  node_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_1 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R10_command : in routeCommands;
			R32_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_1;
architecture Behavioral of node_1 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R10_command = RELEASE and R32_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R10_command = RESERVE or R32_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R10_command = LOCK or R32_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;