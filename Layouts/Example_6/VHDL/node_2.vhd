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
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
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
				if (R7_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE and R14_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R7_command = RESERVE or R10_command = RESERVE or R11_command = RESERVE or R14_command = RESERVE or R15_command = RESERVE or R16_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R7_command = LOCK or R10_command = LOCK or R11_command = LOCK or R14_command = LOCK or R15_command = LOCK or R16_command = LOCK) then
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