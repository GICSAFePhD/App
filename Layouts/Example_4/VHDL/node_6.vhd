--  node_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_6 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R10_command : in routeCommands;
			R17_command : in routeCommands;
			R27_command : in routeCommands;
			R29_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R71_command : in routeCommands;
			R73_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_6;
architecture Behavioral of node_6 is
	signal commandState : routeCommands := RELEASE;
	signal lock_state : objectLock := RELEASED;
	signal track_state : nodeStates := FREE;
begin
	-- Assign the last 2 bits of track_i to lock_state
	--lock_state <= objectLock'val(to_integer(unsigned(hex_to_slv(track_i)(0 to 1))));
	-- Assign the first 2 bits of track_i to track_state
	track_state <= nodeStates'val(to_integer(unsigned(hex_to_slv(track_i)(2 to 3))));
	-- Update track_i based on the values of track_state and lock_state
	track_o <= slv_to_hex(std_logic_vector(to_unsigned(objectLock'pos(lock_state), 2) & to_unsigned(nodeStates'pos(track_state), 2)));

	process(reset,R10_command,R17_command,R27_command,R29_command,R68_command,R69_command,R70_command,R71_command,R73_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R10_command = RELEASE and R17_command = RELEASE and R27_command = RELEASE and R29_command = RELEASE and R68_command = RELEASE and R69_command = RELEASE and R70_command = RELEASE and R71_command = RELEASE and R73_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R10_command = RESERVE or R17_command = RESERVE or R27_command = RESERVE or R29_command = RESERVE or R68_command = RESERVE or R69_command = RESERVE or R70_command = RESERVE or R71_command = RESERVE or R73_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R10_command = LOCK or R17_command = LOCK or R27_command = LOCK or R29_command = LOCK or R68_command = LOCK or R69_command = LOCK or R70_command = LOCK or R71_command = LOCK or R73_command = LOCK) then
					commandState <= LOCK;
				end if;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is

				lock_state <= RELEASED;

				lock_state <= RESERVED;

				lock_state <= LOCKED;

				lock_state <= LOCKED;
		end case;
	end process;
end Behavioral;