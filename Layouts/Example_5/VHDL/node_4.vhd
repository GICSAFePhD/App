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
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_4;
architecture Behavioral of node_4 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R6_command = RELEASE and R13_command = RELEASE and R14_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R5_command = RESERVE or R6_command = RESERVE or R13_command = RESERVE or R14_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R5_command = LOCK or R6_command = LOCK or R13_command = LOCK or R14_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;