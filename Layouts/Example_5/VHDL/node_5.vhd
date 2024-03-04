--  node_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R7_command : in routeCommands;
			R13_command : in routeCommands;
			R15_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_5;
architecture Behavioral of node_5 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R7_command = RELEASE and R13_command = RELEASE and R15_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R5_command = RESERVE or R7_command = RESERVE or R13_command = RESERVE or R15_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R5_command = LOCK or R7_command = LOCK or R13_command = LOCK or R15_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;