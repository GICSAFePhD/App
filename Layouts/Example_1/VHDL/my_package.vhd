--  my_package.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
	package my_package is
		type hex_char is ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
		type hex_array is array (natural range <>) of hex_char;
		type ascii_array is array (0 to 255) of hex_char;
		type ascii_packet is array (hex_char range <>) of std_logic_vector(8-1 downto 0);
		--LL|S
		type nodeStates is (OCCUPIED,FREE);
		type routeCommands is (RELEASE,RESERVE,LOCK);
		type objectLock is (RELEASED,RESERVED,LOCKED);
		type routeStates is (WAITING_COMMAND,ROUTE_REQUEST,RESERVING_TRACKS,LOCKING_TRACKS,RESERVING_INFRASTRUCTURE,LOCKING_INFRASTRUCTURE,DRIVING_SIGNAL,SEQUENTIAL_RELEASE,RELEASING_INFRASTRUCTURE,CANCEL_ROUTE);
		function hex_to_slv(h: hex_char) return std_logic_vector;
		function slv_to_hex(s: std_logic_vector) return hex_char;
		type singleSwitchStates is (NORMAL,REVERSE,TRANSITION);
		type sSwitch_type is record
			msb : std_logic;
			lsb : std_logic;
		end record sSwitch_type;
		type sSwitches_type is record
			msb : std_logic_vector(5-1 downto 0);
			lsb : std_logic_vector(5-1 downto 0);
		end record sSwitches_type;
		type levelCrossingStates is (DOWN,UP,TRANSITION);
		type levelCrossing_type is record
			msb : std_logic;
			lsb : std_logic;
		end record levelCrossing_type;
		type levelCrossings_type is record
			msb : std_logic_vector(2-1 downto 0);
			lsb : std_logic_vector(2-1 downto 0);
		end record levelCrossings_type;
		type signalStates is (RED,DOUBLE_YELLOW,YELLOW,GREEN);
		type signal_type is record
			msb : std_logic;
			lsb : std_logic;
		end record signal_type;
		type signals_type is record
			msb : std_logic_vector(23-1 downto 0);
			lsb : std_logic_vector(23-1 downto 0);
		end record signals_type;
	end my_package;	package body my_package is
	-- Conversion functions
	function hex_to_slv(h: hex_char) return std_logic_vector is
	begin
	case h is
		when '0' => return "0000";
		when '1' => return "0001";
		when '2' => return "0010";
		when '3' => return "0011";
		when '4' => return "0100";
		when '5' => return "0101";
		when '6' => return "0110";
		when '7' => return "0111";
		when '8' => return "1000";
		when '9' => return "1001";
		when 'A' => return "1010";
		when 'B' => return "1011";
		when 'C' => return "1100";
		when 'D' => return "1101";
		when 'E' => return "1110";
		when 'F' => return "1111";
		when others => return "0000";  -- Default case
	end case;
	end function hex_to_slv;
	function slv_to_hex(s: std_logic_vector) return hex_char is
	begin
	case s is
		when "0000" => return '0';
		when "0001" => return '1';
		when "0010" => return '2';
		when "0011" => return '3';
		when "0100" => return '4';
		when "0101" => return '5';
		when "0110" => return '6';
		when "0111" => return '7';
		when "1000" => return '8';
		when "1001" => return '9';
		when "1010" => return 'A';
		when "1011" => return 'B';
		when "1100" => return 'C';
		when "1101" => return 'D';
		when "1110" => return 'E';
		when "1111" => return 'F';
		when others => return '0';  -- Default case
	end case;
	end function slv_to_hex;
end package body my_package;
