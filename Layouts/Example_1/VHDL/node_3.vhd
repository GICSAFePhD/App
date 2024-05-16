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
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_3;
architecture Behavioral of node_3 is
	signal commandState : routeCommands := RELEASE;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (R8_command = RELEASE and R12_command = RELEASE and R13_command = RELEASE and R17_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R8_command = RESERVE or R12_command = RESERVE or R13_command = RESERVE or R17_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R8_command = LOCK or R12_command = LOCK or R13_command = LOCK or R17_command = LOCK) then
					commandState <= LOCK;
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