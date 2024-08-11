--  node_40.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_40 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R22_command : in routeCommands;
			R31_command : in routeCommands;
			R32_command : in routeCommands;
			R37_command : in routeCommands;
			R90_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_40;
architecture Behavioral of node_40 is
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

	process(reset,R22_command,R31_command,R32_command,R37_command,R90_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R22_command = RELEASE and R31_command = RELEASE and R32_command = RELEASE and R37_command = RELEASE and R90_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R22_command = RESERVE or R31_command = RESERVE or R32_command = RESERVE or R37_command = RESERVE or R90_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R22_command = LOCK or R31_command = LOCK or R32_command = LOCK or R37_command = LOCK or R90_command = LOCK) then
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