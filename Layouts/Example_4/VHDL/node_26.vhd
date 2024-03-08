--  node_26.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_26 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R44_command : in routeCommands;
			R46_command : in routeCommands;
			R49_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_26;
architecture Behavioral of node_26 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R44_command = RELEASE and R46_command = RELEASE and R49_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R44_command = RESERVE or R46_command = RESERVE or R49_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R44_command = LOCK or R46_command = LOCK or R49_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;