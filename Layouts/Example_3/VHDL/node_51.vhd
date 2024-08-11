--  node_51.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_51 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R14_command : in routeCommands;
			R35_command : in routeCommands;
			R36_command : in routeCommands;
			R37_command : in routeCommands;
			R66_command : in routeCommands;
			R83_command : in routeCommands;
			R88_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_51;
architecture Behavioral of node_51 is
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

	process(reset,R14_command,R35_command,R36_command,R37_command,R66_command,R83_command,R88_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R14_command = RELEASE and R35_command = RELEASE and R36_command = RELEASE and R37_command = RELEASE and R66_command = RELEASE and R83_command = RELEASE and R88_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R14_command = RESERVE or R35_command = RESERVE or R36_command = RESERVE or R37_command = RESERVE or R66_command = RESERVE or R83_command = RESERVE or R88_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R14_command = LOCK or R35_command = LOCK or R36_command = LOCK or R37_command = LOCK or R66_command = LOCK or R83_command = LOCK or R88_command = LOCK) then
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