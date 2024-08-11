--  node_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R79_command : in routeCommands;
			R80_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_3;
architecture Behavioral of node_3 is
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

	process(reset,R65_command,R66_command,R79_command,R80_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R65_command = RELEASE and R66_command = RELEASE and R79_command = RELEASE and R80_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R65_command = RESERVE or R66_command = RESERVE or R79_command = RESERVE or R80_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R65_command = LOCK or R66_command = LOCK or R79_command = LOCK or R80_command = LOCK) then
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