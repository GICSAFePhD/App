--  node_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_7;
architecture Behavioral of node_7 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R3_command = RELEASE and R13_command = RELEASE and R17_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R3_command = RESERVE or R13_command = RESERVE or R17_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R3_command = LOCK or R13_command = LOCK or R17_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;