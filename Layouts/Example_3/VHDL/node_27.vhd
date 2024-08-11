--  node_27.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_27 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R70_command : in routeCommands;
			R80_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_27;
architecture Behavioral of node_27 is
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

	process(reset,R5_command,R6_command,R70_command,R80_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R5_command = RELEASE and R6_command = RELEASE and R70_command = RELEASE and R80_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R5_command = RESERVE or R6_command = RESERVE or R70_command = RESERVE or R80_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R5_command = LOCK or R6_command = LOCK or R70_command = LOCK or R80_command = LOCK) then
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