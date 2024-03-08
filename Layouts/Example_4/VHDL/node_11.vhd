--  node_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_11 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R11_command : in routeCommands;
			R44_command : in routeCommands;
			R47_command : in routeCommands;
			R50_command : in routeCommands;
			R51_command : in routeCommands;
			R87_command : in routeCommands;
			R88_command : in routeCommands;
			R89_command : in routeCommands;
			R91_command : in routeCommands;
			state : out nodeStates
		);
	end entity node_11;
architecture Behavioral of node_11 is
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R11_command = RELEASE and R44_command = RELEASE and R47_command = RELEASE and R50_command = RELEASE and R51_command = RELEASE and R87_command = RELEASE and R88_command = RELEASE and R89_command = RELEASE and R91_command = RELEASE) then
				if ocupation = '1' then
					state <= FREE;
				else
					state <= OCCUPIED;
				end if;
			else
				if (R11_command = RESERVE or R44_command = RESERVE or R47_command = RESERVE or R50_command = RESERVE or R51_command = RESERVE or R87_command = RESERVE or R88_command = RESERVE or R89_command = RESERVE or R91_command = RESERVE) then
					state <= RESERVED;
				end if;
				if (R11_command = LOCK or R44_command = LOCK or R47_command = LOCK or R50_command = LOCK or R51_command = LOCK or R87_command = LOCK or R88_command = LOCK or R89_command = LOCK or R91_command = LOCK) then
					state <= LOCKED;
				end if;
			end if;
		else
		end if;
	end process;
end Behavioral;