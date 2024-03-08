--  node_32.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_32 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R76_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_32;
architecture Behavioral of node_32 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R76_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R8_command = RESERVE or R76_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R8_command = LOCK or R76_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;