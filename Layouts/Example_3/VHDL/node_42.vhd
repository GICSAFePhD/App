--  node_42.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_42 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R12_command : in routeCommands;
			R20_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_42;
architecture Behavioral of node_42 is
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

	process(reset,R6_command,R12_command,R20_command,R78_command,R84_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R6_command = RELEASE and R12_command = RELEASE and R20_command = RELEASE and R78_command = RELEASE and R84_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R6_command = RESERVE or R12_command = RESERVE or R20_command = RESERVE or R78_command = RESERVE or R84_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R6_command = LOCK or R12_command = LOCK or R20_command = LOCK or R78_command = LOCK or R84_command = LOCK) then
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