--  node_33.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_33 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R16_command : in routeCommands;
			R56_command : in routeCommands;
			R69_command : in routeCommands;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			R77_command : in routeCommands;
			R78_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_33;
architecture Behavioral of node_33 is
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

	process(reset,R6_command,R16_command,R56_command,R69_command,R71_command,R72_command,R77_command,R78_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R6_command = RELEASE and R16_command = RELEASE and R56_command = RELEASE and R69_command = RELEASE and R71_command = RELEASE and R72_command = RELEASE and R77_command = RELEASE and R78_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R6_command = RESERVE or R16_command = RESERVE or R56_command = RESERVE or R69_command = RESERVE or R71_command = RESERVE or R72_command = RESERVE or R77_command = RESERVE or R78_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R6_command = LOCK or R16_command = LOCK or R56_command = LOCK or R69_command = LOCK or R71_command = LOCK or R72_command = LOCK or R77_command = LOCK or R78_command = LOCK) then
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