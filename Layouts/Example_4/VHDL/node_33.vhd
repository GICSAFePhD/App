--  node_33.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_33 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R16_command : in routeCommands;
			R56_command : in routeCommands;
			R69_command : in routeCommands;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			R77_command : in routeCommands;
			R78_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_33;
architecture Behavioral of node_33 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R6_command = RELEASE and R16_command = RELEASE and R56_command = RELEASE and R69_command = RELEASE and R71_command = RELEASE and R72_command = RELEASE and R77_command = RELEASE and R78_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R6_command = RESERVE or R16_command = RESERVE or R56_command = RESERVE or R69_command = RESERVE or R71_command = RESERVE or R72_command = RESERVE or R77_command = RESERVE or R78_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R6_command = LOCK or R16_command = LOCK or R56_command = LOCK or R69_command = LOCK or R71_command = LOCK or R72_command = LOCK or R77_command = LOCK or R78_command = LOCK) then
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