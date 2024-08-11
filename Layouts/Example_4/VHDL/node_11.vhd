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
			R11_command : in routeCommands;
			R42_command : in routeCommands;
			R45_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R85_command : in routeCommands;
			R86_command : in routeCommands;
			R87_command : in routeCommands;
			R89_command : in routeCommands;
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

	process(reset,R11_command,R42_command,R45_command,R46_command,R47_command,R85_command,R86_command,R87_command,R89_command)
	begin
		if (reset = '1') then
			commandState <= RELEASE;
		else
			if (R11_command = RELEASE and R42_command = RELEASE and R45_command = RELEASE and R46_command = RELEASE and R47_command = RELEASE and R85_command = RELEASE and R86_command = RELEASE and R87_command = RELEASE and R89_command = RELEASE) then
				commandState <= RELEASE;
			else
				if (R11_command = RESERVE or R42_command = RESERVE or R45_command = RESERVE or R46_command = RESERVE or R47_command = RESERVE or R85_command = RESERVE or R86_command = RESERVE or R87_command = RESERVE or R89_command = RESERVE) then
					commandState <= RESERVE;
				end if;
				if (R11_command = LOCK or R42_command = LOCK or R45_command = LOCK or R46_command = LOCK or R47_command = LOCK or R85_command = LOCK or R86_command = LOCK or R87_command = LOCK or R89_command = LOCK) then
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