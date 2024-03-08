--  node_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_20 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R11_command : in routeCommands;
			R13_command : in routeCommands;
			R62_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_20;
architecture Behavioral of node_20 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R11_command = RELEASE and R13_command = RELEASE and R62_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R11_command = RESERVE or R13_command = RESERVE or R62_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R11_command = LOCK or R13_command = LOCK or R62_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;