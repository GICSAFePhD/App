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
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R12_command : in routeCommands;
			R17_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_6;
architecture Behavioral of node_6 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R9_command = RELEASE and R12_command = RELEASE and R17_command = RELEASE and R21_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R8_command = RESERVE or R9_command = RESERVE or R12_command = RESERVE or R17_command = RESERVE or R21_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R8_command = LOCK or R9_command = LOCK or R12_command = LOCK or R17_command = LOCK or R21_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;