--  node_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_6;
architecture Behavioral of node_6 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R5_command = RELEASE and R11_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R5_command = RESERVE or R11_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R5_command = LOCK or R11_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;