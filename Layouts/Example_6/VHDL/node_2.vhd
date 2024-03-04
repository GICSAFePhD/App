--  node_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_2;
architecture Behavioral of node_2 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R7_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE and R14_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R7_command = RESERVE or R10_command = RESERVE or R11_command = RESERVE or R14_command = RESERVE or R15_command = RESERVE or R16_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R7_command = LOCK or R10_command = LOCK or R11_command = LOCK or R14_command = LOCK or R15_command = LOCK or R16_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;