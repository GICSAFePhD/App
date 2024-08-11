--  node_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_16 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R13_command : in routeCommands;
			R50_command : in routeCommands;
			R52_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_16;
architecture Behavioral of node_16 is
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

	process(reset,R13_command,R50_command,R52_command,R63_command,R64_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R13_command = RELEASE and R50_command = RELEASE and R52_command = RELEASE and R63_command = RELEASE and R64_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R13_command = RESERVE or R50_command = RESERVE or R52_command = RESERVE or R63_command = RESERVE or R64_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R13_command = LOCK or R50_command = LOCK or R52_command = LOCK or R63_command = LOCK or R64_command = LOCK) then
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