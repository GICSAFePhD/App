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
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			R33_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_34;
architecture Behavioral of node_34 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R15_command = RELEASE and R16_command = RELEASE and R33_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R15_command = RESERVE or R16_command = RESERVE or R33_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R15_command = LOCK or R16_command = LOCK or R33_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;