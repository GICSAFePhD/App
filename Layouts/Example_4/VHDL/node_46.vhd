--  node_46.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_46 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R89_command : in routeCommands;
			R91_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_46;
architecture Behavioral of node_46 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R89_command = RELEASE and R91_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R89_command = RESERVE or R91_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R89_command = LOCK or R91_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;