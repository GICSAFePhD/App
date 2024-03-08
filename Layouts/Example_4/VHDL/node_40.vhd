--  node_40.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_40 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R60_command : in routeCommands;
			R62_command : in routeCommands;
			R82_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_40;
architecture Behavioral of node_40 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R60_command = RELEASE and R62_command = RELEASE and R82_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R60_command = RESERVE or R62_command = RESERVE or R82_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R60_command = LOCK or R62_command = LOCK or R82_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;