--  node_20.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_20 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R18_command : in routeCommands;
			R23_command : in routeCommands;
			R30_command : in routeCommands;
			R31_command : in routeCommands;
			R34_command : in routeCommands;
			R51_command : in routeCommands;
			R64_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_20;
architecture Behavioral of node_20 is
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

	process(reset,R18_command,R23_command,R30_command,R31_command,R34_command,R51_command,R64_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R18_command = RELEASE and R23_command = RELEASE and R30_command = RELEASE and R31_command = RELEASE and R34_command = RELEASE and R51_command = RELEASE and R64_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R18_command = RESERVE or R23_command = RESERVE or R30_command = RESERVE or R31_command = RESERVE or R34_command = RESERVE or R51_command = RESERVE or R64_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R18_command = LOCK or R23_command = LOCK or R30_command = LOCK or R31_command = LOCK or R34_command = LOCK or R51_command = LOCK or R64_command = LOCK) then
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