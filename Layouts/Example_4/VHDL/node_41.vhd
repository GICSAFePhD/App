--  node_41.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_41 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R24_command : in routeCommands;
			R33_command : in routeCommands;
			R79_command : in routeCommands;
			R80_command : in routeCommands;
			R81_command : in routeCommands;
			R84_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_41;
architecture Behavioral of node_41 is
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

	process(reset,R24_command,R33_command,R79_command,R80_command,R81_command,R84_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R24_command = RELEASE and R33_command = RELEASE and R79_command = RELEASE and R80_command = RELEASE and R81_command = RELEASE and R84_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R24_command = RESERVE or R33_command = RESERVE or R79_command = RESERVE or R80_command = RESERVE or R81_command = RESERVE or R84_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R24_command = LOCK or R33_command = LOCK or R79_command = LOCK or R80_command = LOCK or R81_command = LOCK or R84_command = LOCK) then
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