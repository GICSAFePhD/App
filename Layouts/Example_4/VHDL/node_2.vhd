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
			R4_command : in routeCommands;
			R34_command : in routeCommands;
			R36_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R67_command : in routeCommands;
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
				if (R4_command = RELEASE and R34_command = RELEASE and R36_command = RELEASE and R65_command = RELEASE and R66_command = RELEASE and R67_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R4_command = RESERVE or R34_command = RESERVE or R36_command = RESERVE or R65_command = RESERVE or R66_command = RESERVE or R67_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R4_command = LOCK or R34_command = LOCK or R36_command = LOCK or R65_command = LOCK or R66_command = LOCK or R67_command = LOCK) then
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