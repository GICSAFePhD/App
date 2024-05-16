--  node_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_3;
architecture Behavioral of node_3 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R3_command = RELEASE and R4_command = RELEASE and R11_command = RELEASE and R12_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R3_command = RESERVE or R4_command = RESERVE or R11_command = RESERVE or R12_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R3_command = LOCK or R4_command = LOCK or R11_command = LOCK or R12_command = LOCK) then
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