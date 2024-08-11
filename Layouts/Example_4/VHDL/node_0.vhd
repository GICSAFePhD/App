--  node_0.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R20_command : in routeCommands;
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			R41_command : in routeCommands;
			R60_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_0;
architecture Behavioral of node_0 is
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

	process(reset,R1_command,R20_command,R39_command,R40_command,R41_command,R60_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R1_command = RELEASE and R20_command = RELEASE and R39_command = RELEASE and R40_command = RELEASE and R41_command = RELEASE and R60_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R1_command = RESERVE or R20_command = RESERVE or R39_command = RESERVE or R40_command = RESERVE or R41_command = RESERVE or R60_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R1_command = LOCK or R20_command = LOCK or R39_command = LOCK or R40_command = LOCK or R41_command = LOCK or R60_command = LOCK) then
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