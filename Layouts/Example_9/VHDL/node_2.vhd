--  node_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			R18_command : in routeCommands;
			R20_command : in routeCommands;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_2;
architecture Behavioral of node_2 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R6_command = RELEASE and R7_command = RELEASE and R12_command = RELEASE and R18_command = RELEASE and R20_command = RELEASE and R23_command = RELEASE and R24_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R6_command = RESERVE or R7_command = RESERVE or R12_command = RESERVE or R18_command = RESERVE or R20_command = RESERVE or R23_command = RESERVE or R24_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R6_command = LOCK or R7_command = LOCK or R12_command = LOCK or R18_command = LOCK or R20_command = LOCK or R23_command = LOCK or R24_command = LOCK) then
						commandState <= LOCK;
					end if;
				end if;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				locking <= RELEASED;
			when RESERVE => -- DONT CHANGE
				locking <= RESERVED;
			when LOCK => -- DONT CHANGE
				locking <= LOCKED;
			when others =>
				locking <= LOCKED;
		end case;
	end process;

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (ocupation = '1') then
				state <= FREE;
			else
				state <= OCCUPIED;
			end if;
		end if;
	end process;
end Behavioral;