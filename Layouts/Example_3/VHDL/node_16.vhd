--  node_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_16 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_16;
architecture Behavioral of node_16 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R4_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R4_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;