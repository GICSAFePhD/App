--  node_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_23 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R15_command : in routeCommands;
			R33_command : in routeCommands;
			R36_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R89_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_23;
architecture Behavioral of node_23 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R15_command = RELEASE and R33_command = RELEASE and R36_command = RELEASE and R63_command = RELEASE and R64_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R89_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R15_command = RESERVE or R33_command = RESERVE or R36_command = RESERVE or R63_command = RESERVE or R64_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R89_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R15_command = LOCK or R33_command = LOCK or R36_command = LOCK or R63_command = LOCK or R64_command = LOCK or R65_command = LOCK or R66_command = LOCK or R89_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;