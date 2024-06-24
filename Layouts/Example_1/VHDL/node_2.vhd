--  node_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_2;
architecture Behavioral of node_2 is
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

	process(reset,R5_command,R10_command,R11_command,R18_command,R19_command,R21_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R5_command = RELEASE and R10_command = RELEASE and R11_command = RELEASE and R18_command = RELEASE and R19_command = RELEASE and R21_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R5_command = RESERVE or R10_command = RESERVE or R11_command = RESERVE or R18_command = RESERVE or R19_command = RESERVE or R21_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R5_command = LOCK or R10_command = LOCK or R11_command = LOCK or R18_command = LOCK or R19_command = LOCK or R21_command = LOCK) then
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