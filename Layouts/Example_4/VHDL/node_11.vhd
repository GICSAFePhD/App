--  node_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R11_command : in routeCommands;
			R42_command : in routeCommands;
			R45_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R85_command : in routeCommands;
			R86_command : in routeCommands;
			R87_command : in routeCommands;
			R89_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_11;
architecture Behavioral of node_11 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R11_command = RELEASE and R42_command = RELEASE and R45_command = RELEASE and R46_command = RELEASE and R47_command = RELEASE and R85_command = RELEASE and R86_command = RELEASE and R87_command = RELEASE and R89_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R11_command = RESERVE or R42_command = RESERVE or R45_command = RESERVE or R46_command = RESERVE or R47_command = RESERVE or R85_command = RESERVE or R86_command = RESERVE or R87_command = RESERVE or R89_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R11_command = LOCK or R42_command = LOCK or R45_command = LOCK or R46_command = LOCK or R47_command = LOCK or R85_command = LOCK or R86_command = LOCK or R87_command = LOCK or R89_command = LOCK) then
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