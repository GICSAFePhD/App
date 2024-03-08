--  node_38.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_38 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R9_command : in routeCommands;
			R15_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_38;
architecture Behavioral of node_38 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R9_command = RELEASE and R15_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R9_command = RESERVE or R15_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R9_command = LOCK or R15_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;