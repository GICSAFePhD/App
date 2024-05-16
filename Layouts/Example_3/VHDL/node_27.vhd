--  node_27.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_27 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R70_command : in routeCommands;
			R80_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_27;
architecture Behavioral of node_27 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R5_command = RELEASE and R6_command = RELEASE and R70_command = RELEASE and R80_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R5_command = RESERVE or R6_command = RESERVE or R70_command = RESERVE or R80_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R5_command = LOCK or R6_command = LOCK or R70_command = LOCK or R80_command = LOCK) then
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