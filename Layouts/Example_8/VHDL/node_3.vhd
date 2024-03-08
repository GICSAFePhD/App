--  node_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_3;
architecture Behavioral of node_3 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R1_command = RELEASE and R2_command = RELEASE and R11_command = RELEASE and R12_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R1_command = RESERVE or R2_command = RESERVE or R11_command = RESERVE or R12_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R1_command = LOCK or R2_command = LOCK or R11_command = LOCK or R12_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;