--  node_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_8 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R20_command : in routeCommands;
			R22_command : in routeCommands;
			R42_command : in routeCommands;
			R66_command : in routeCommands;
			R67_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_8;
architecture Behavioral of node_8 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R2_command = RELEASE and R20_command = RELEASE and R22_command = RELEASE and R42_command = RELEASE and R66_command = RELEASE and R67_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R2_command = RESERVE or R20_command = RESERVE or R22_command = RESERVE or R42_command = RESERVE or R66_command = RESERVE or R67_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R2_command = LOCK or R20_command = LOCK or R22_command = LOCK or R42_command = LOCK or R66_command = LOCK or R67_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;