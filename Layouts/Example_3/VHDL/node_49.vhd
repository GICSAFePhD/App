--  node_49.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_49 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R14_command : in routeCommands;
			R87_command : in routeCommands;
			R88_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_49;
architecture Behavioral of node_49 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R14_command = RELEASE and R87_command = RELEASE and R88_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R14_command = RESERVE or R87_command = RESERVE or R88_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R14_command = LOCK or R87_command = LOCK or R88_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;