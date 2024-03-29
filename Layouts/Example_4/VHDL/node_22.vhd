--  node_22.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_22 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R19_command : in routeCommands;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R32_command : in routeCommands;
			R33_command : in routeCommands;
			R34_command : in routeCommands;
			R35_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_22;
architecture Behavioral of node_22 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R19_command = RELEASE and R24_command = RELEASE and R25_command = RELEASE and R32_command = RELEASE and R33_command = RELEASE and R34_command = RELEASE and R35_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R19_command = RESERVE or R24_command = RESERVE or R25_command = RESERVE or R32_command = RESERVE or R33_command = RESERVE or R34_command = RESERVE or R35_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R19_command = LOCK or R24_command = LOCK or R25_command = LOCK or R32_command = LOCK or R33_command = LOCK or R34_command = LOCK or R35_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;