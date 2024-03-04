--  node_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_4;
architecture Behavioral of node_4 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R6_command = RELEASE and R7_command = RELEASE and R15_command = RELEASE and R18_command = RELEASE and R19_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R3_command = RESERVE or R6_command = RESERVE or R7_command = RESERVE or R15_command = RESERVE or R18_command = RESERVE or R19_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R3_command = LOCK or R6_command = LOCK or R7_command = LOCK or R15_command = LOCK or R18_command = LOCK or R19_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;