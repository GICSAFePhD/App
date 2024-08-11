--  node_52.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_52 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R59_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_52;
architecture Behavioral of node_52 is
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

	process(reset,R54_command,R56_command,R58_command,R59_command,R84_command,R85_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R54_command = RELEASE and R56_command = RELEASE and R58_command = RELEASE and R59_command = RELEASE and R84_command = RELEASE and R85_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R54_command = RESERVE or R56_command = RESERVE or R58_command = RESERVE or R59_command = RESERVE or R84_command = RESERVE or R85_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R54_command = LOCK or R56_command = LOCK or R58_command = LOCK or R59_command = LOCK or R84_command = LOCK or R85_command = LOCK) then
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