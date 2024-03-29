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
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_5;
architecture Behavioral of node_5 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R4_command = RELEASE and R5_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R4_command = RESERVE or R5_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE or R11_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R4_command = LOCK or R5_command = LOCK or R9_command = LOCK or R10_command = LOCK or R11_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;