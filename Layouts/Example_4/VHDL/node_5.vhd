--  node_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_5 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R8_command : in routeCommands;
			R26_command : in routeCommands;
			R28_command : in routeCommands;
			R37_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_5;
architecture Behavioral of node_5 is
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

	process(reset,R8_command,R26_command,R28_command,R37_command,R75_command,R76_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R8_command = RELEASE and R26_command = RELEASE and R28_command = RELEASE and R37_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R8_command = RESERVE or R26_command = RESERVE or R28_command = RESERVE or R37_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R8_command = LOCK or R26_command = LOCK or R28_command = LOCK or R37_command = LOCK or R75_command = LOCK or R76_command = LOCK) then
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