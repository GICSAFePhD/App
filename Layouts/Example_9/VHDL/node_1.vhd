--  node_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity node_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			R17_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end entity node_1;
architecture Behavioral of node_1 is
	signal commandState : routeCommands;
begin

	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				commandState <= RELEASE;
			else
				if (R2_command = RELEASE and R4_command = RELEASE and R7_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE and R17_command = RELEASE and R20_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE and R27_command = RELEASE) then
					commandState <= RELEASE;
				else
					if (R2_command = RESERVE or R4_command = RESERVE or R7_command = RESERVE or R15_command = RESERVE or R16_command = RESERVE or R17_command = RESERVE or R20_command = RESERVE or R21_command = RESERVE or R22_command = RESERVE or R27_command = RESERVE) then
						commandState <= RESERVE;
					end if;
					if (R2_command = LOCK or R4_command = LOCK or R7_command = LOCK or R15_command = LOCK or R16_command = LOCK or R17_command = LOCK or R20_command = LOCK or R21_command = LOCK or R22_command = LOCK or R27_command = LOCK) then
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