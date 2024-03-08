--  node_34.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_34 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R74_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			R78_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_34;
architecture Behavioral of node_34 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R74_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE and R78_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R74_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE or R78_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R74_command = LOCK or R75_command = LOCK or R76_command = LOCK or R78_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;