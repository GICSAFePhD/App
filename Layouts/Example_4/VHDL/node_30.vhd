--  node_30.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_30 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R69_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_30;
architecture Behavioral of node_30 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R56_command = RELEASE and R58_command = RELEASE and R69_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R56_command = RESERVE or R58_command = RESERVE or R69_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R56_command = LOCK or R58_command = LOCK or R69_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;