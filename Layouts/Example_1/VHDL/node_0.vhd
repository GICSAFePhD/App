--  node_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_0 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_0;
architecture Behavioral of node_0 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE and R12_command = RELEASE and R13_command = RELEASE and R17_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R8_command = RESERVE or R10_command = RESERVE or R11_command = RESERVE or R12_command = RESERVE or R13_command = RESERVE or R17_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R8_command = LOCK or R10_command = LOCK or R11_command = LOCK or R12_command = LOCK or R13_command = LOCK or R17_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;