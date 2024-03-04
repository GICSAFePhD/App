--  node_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_9 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_9;
architecture Behavioral of node_9 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R5_command = RELEASE and R8_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R4_command = RESERVE or R5_command = RESERVE or R8_command = RESERVE or R21_command = RESERVE or R22_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R4_command = LOCK or R5_command = LOCK or R8_command = LOCK or R21_command = LOCK or R22_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;