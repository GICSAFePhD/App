--  node_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_6;
architecture Behavioral of node_6 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R1_command = RELEASE and R8_command = RELEASE and R9_command = RELEASE and R10_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R1_command = RESERVE or R8_command = RESERVE or R9_command = RESERVE or R10_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R1_command = LOCK or R8_command = LOCK or R9_command = LOCK or R10_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;