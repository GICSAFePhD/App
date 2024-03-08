--  node_21.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_21 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R29_command : in routeCommands;
			R30_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_21;
architecture Behavioral of node_21 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R29_command = RELEASE and R30_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R29_command = RESERVE or R30_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R29_command = LOCK or R30_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;