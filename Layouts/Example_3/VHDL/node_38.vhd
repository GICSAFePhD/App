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
			R18_command : in routeCommands;
			R31_command : in routeCommands;
			R37_command : in routeCommands;
			R90_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_38;
architecture Behavioral of node_38 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R18_command = RELEASE and R31_command = RELEASE and R37_command = RELEASE and R90_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R18_command = RESERVE or R31_command = RESERVE or R37_command = RESERVE or R90_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R18_command = LOCK or R31_command = LOCK or R37_command = LOCK or R90_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;