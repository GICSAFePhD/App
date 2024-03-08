--  node_50.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_50 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R42_command : in routeCommands;
			R44_command : in routeCommands;
			R45_command : in routeCommands;
			R81_command : in routeCommands;
			R91_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_50;
architecture Behavioral of node_50 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R42_command = RELEASE and R44_command = RELEASE and R45_command = RELEASE and R81_command = RELEASE and R91_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R3_command = RESERVE or R42_command = RESERVE or R44_command = RESERVE or R45_command = RESERVE or R81_command = RESERVE or R91_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R3_command = LOCK or R42_command = LOCK or R44_command = LOCK or R45_command = LOCK or R81_command = LOCK or R91_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;