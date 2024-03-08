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
			R28_command : in routeCommands;
			R49_command : in routeCommands;
			R51_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_8;
architecture Behavioral of node_8 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R28_command = RELEASE and R49_command = RELEASE and R51_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R28_command = RESERVE or R49_command = RESERVE or R51_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R28_command = LOCK or R49_command = LOCK or R51_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;