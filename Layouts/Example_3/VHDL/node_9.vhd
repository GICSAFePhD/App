--  node_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_9 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R11_command : in routeCommands;
			R27_command : in routeCommands;
			R49_command : in routeCommands;
			R50_command : in routeCommands;
			R51_command : in routeCommands;
			R62_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_9;
architecture Behavioral of node_9 is
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

	process(reset,R11_command,R27_command,R49_command,R50_command,R51_command,R62_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R11_command = RELEASE and R27_command = RELEASE and R49_command = RELEASE and R50_command = RELEASE and R51_command = RELEASE and R62_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R11_command = RESERVE or R27_command = RESERVE or R49_command = RESERVE or R50_command = RESERVE or R51_command = RESERVE or R62_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R11_command = LOCK or R27_command = LOCK or R49_command = LOCK or R50_command = LOCK or R51_command = LOCK or R62_command = LOCK) then
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