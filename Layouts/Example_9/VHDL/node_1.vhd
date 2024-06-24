--  node_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity node_1 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			R17_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			track_o : out hex_char
		);
	end entity node_1;
architecture Behavioral of node_1 is
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

	process(reset,R2_command,R4_command,R7_command,R15_command,R16_command,R17_command,R20_command,R21_command,R22_command,R27_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R2_command = RELEASE and R4_command = RELEASE and R7_command = RELEASE and R15_command = RELEASE and R16_command = RELEASE and R17_command = RELEASE and R20_command = RELEASE and R21_command = RELEASE and R22_command = RELEASE and R27_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R2_command = RESERVE or R4_command = RESERVE or R7_command = RESERVE or R15_command = RESERVE or R16_command = RESERVE or R17_command = RESERVE or R20_command = RESERVE or R21_command = RESERVE or R22_command = RESERVE or R27_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R2_command = LOCK or R4_command = LOCK or R7_command = LOCK or R15_command = LOCK or R16_command = LOCK or R17_command = LOCK or R20_command = LOCK or R21_command = LOCK or R22_command = LOCK or R27_command = LOCK) then
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