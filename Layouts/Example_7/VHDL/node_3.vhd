--  node_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_3;
architecture Behavioral of node_3 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R3_command = RELEASE and R7_command = RELEASE and R8_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R2_command = RESERVE or R3_command = RESERVE or R7_command = RESERVE or R8_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R2_command = LOCK or R3_command = LOCK or R7_command = LOCK or R8_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;