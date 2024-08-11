--  node_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_11 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R52_command : in routeCommands;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R55_command : in routeCommands;
			R73_command : in routeCommands;
			R74_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_11;
architecture Behavioral of node_11 is
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

	process(reset,R7_command,R8_command,R52_command,R53_command,R54_command,R55_command,R73_command,R74_command,R75_command,R76_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R7_command = RELEASE and R8_command = RELEASE and R52_command = RELEASE and R53_command = RELEASE and R54_command = RELEASE and R55_command = RELEASE and R73_command = RELEASE and R74_command = RELEASE and R75_command = RELEASE and R76_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R7_command = RESERVE or R8_command = RESERVE or R52_command = RESERVE or R53_command = RESERVE or R54_command = RESERVE or R55_command = RESERVE or R73_command = RESERVE or R74_command = RESERVE or R75_command = RESERVE or R76_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R7_command = LOCK or R8_command = LOCK or R52_command = LOCK or R53_command = LOCK or R54_command = LOCK or R55_command = LOCK or R73_command = LOCK or R74_command = LOCK or R75_command = LOCK or R76_command = LOCK) then
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