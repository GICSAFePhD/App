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
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R6_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_1;
architecture Behavioral of node_1 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R4_command = RELEASE and R6_command = RELEASE and R8_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE and R13_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R3_command = RESERVE or R4_command = RESERVE or R6_command = RESERVE or R8_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE or R13_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R3_command = LOCK or R4_command = LOCK or R6_command = LOCK or R8_command = LOCK or R9_command = LOCK or R10_command = LOCK or R13_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;