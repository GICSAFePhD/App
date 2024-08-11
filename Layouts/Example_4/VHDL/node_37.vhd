--  node_37.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_37 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R27_command : in routeCommands;
			R28_command : in routeCommands;
			R68_command : in routeCommands;
			R76_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_37;
architecture Behavioral of node_37 is
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

	process(reset,R27_command,R28_command,R68_command,R76_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R27_command = RELEASE and R28_command = RELEASE and R68_command = RELEASE and R76_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R27_command = RESERVE or R28_command = RESERVE or R68_command = RESERVE or R76_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R27_command = LOCK or R28_command = LOCK or R68_command = LOCK or R76_command = LOCK) then
					commandState <= LOCK;
				end if;
			end if;
		end if;
	end process;

	process(commandState)
	begin
		case commandState is
			when RELEASE => -- AUTOMATIC
				lock_state <= RELEASED;
			when RESERVE => -- DONT CHANGE
				lock_state <= RESERVED;
			when LOCK => -- DONT CHANGE
				lock_state <= LOCKED;
			when others =>
				lock_state <= LOCKED;
		end case;
	end process;
end Behavioral;