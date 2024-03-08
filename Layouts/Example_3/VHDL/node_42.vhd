--  node_42.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_42 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R12_command : in routeCommands;
			R20_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_42;
architecture Behavioral of node_42 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R6_command = RELEASE and R12_command = RELEASE and R20_command = RELEASE and R78_command = RELEASE and R84_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R6_command = RESERVE or R12_command = RESERVE or R20_command = RESERVE or R78_command = RESERVE or R84_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R6_command = LOCK or R12_command = LOCK or R20_command = LOCK or R78_command = LOCK or R84_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;