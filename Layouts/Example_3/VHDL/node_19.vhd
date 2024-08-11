--  node_19.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_19 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R21_command : in routeCommands;
			R28_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R48_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_19;
architecture Behavioral of node_19 is
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

	process(reset,R21_command,R28_command,R46_command,R47_command,R48_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R21_command = RELEASE and R28_command = RELEASE and R46_command = RELEASE and R47_command = RELEASE and R48_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R21_command = RESERVE or R28_command = RESERVE or R46_command = RESERVE or R47_command = RESERVE or R48_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R21_command = LOCK or R28_command = LOCK or R46_command = LOCK or R47_command = LOCK or R48_command = LOCK) then
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