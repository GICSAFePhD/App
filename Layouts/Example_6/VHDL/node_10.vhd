--  node_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_10 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R20_command : in routeCommands;
			R22_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_10;
architecture Behavioral of node_10 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R20_command = RELEASE and R22_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R5_command = RESERVE or R20_command = RESERVE or R22_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R5_command = LOCK or R20_command = LOCK or R22_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;