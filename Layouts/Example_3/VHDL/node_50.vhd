--  node_50.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_50 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R42_command : in routeCommands;
			R44_command : in routeCommands;
			R45_command : in routeCommands;
			R81_command : in routeCommands;
			R91_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_50;
architecture Behavioral of node_50 is
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

	process(reset,R3_command,R42_command,R44_command,R45_command,R81_command,R91_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R3_command = RELEASE and R42_command = RELEASE and R44_command = RELEASE and R45_command = RELEASE and R81_command = RELEASE and R91_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R3_command = RESERVE or R42_command = RESERVE or R44_command = RESERVE or R45_command = RESERVE or R81_command = RESERVE or R91_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R3_command = LOCK or R42_command = LOCK or R44_command = LOCK or R45_command = LOCK or R81_command = LOCK or R91_command = LOCK) then
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