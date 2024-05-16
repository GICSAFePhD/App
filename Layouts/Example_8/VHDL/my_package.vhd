--  my_package.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	package my_package is
		type routeCommands is (RELEASE,RESERVE,LOCK);
		type routeStates is (WAITING_COMMAND,RESERVING_TRACKS,LOCKING_TRACKS,RESERVING_INFRASTRUCTURE,LOCKING_INFRASTRUCTURE,DRIVING_SIGNAL,SEQUENTIAL_RELEASE,RELEASING_INFRASTRUCTURE,RELEASING_TRACKS);
		type nodeStates is (OCCUPIED,FREE);
		type objectLock is (RELEASED,RESERVED,LOCKED);
		type singleSwitchStates is (NORMAL,REVERSE,TRANSITION);
		type sSwitch_type is record
			msb : std_logic;
			lsb : std_logic;
		end record sSwitch_type;
		type sSwitches_type is record
			msb : std_logic_vector(2-1 downto 0);
			lsb : std_logic_vector(2-1 downto 0);
		end record sSwitches_type;
		type levelCrossingStates is (DOWN,UP,TRANSITION);
		type levelCrossing_type is record
			msb : std_logic;
			lsb : std_logic;
		end record levelCrossing_type;
		type levelCrossings_type is record
			msb : std_logic_vector(6-1 downto 0);
			lsb : std_logic_vector(6-1 downto 0);
		end record levelCrossings_type;
		type signalStates is (RED,DOUBLE_YELLOW,YELLOW,GREEN);
		type signal_type is record
			msb : std_logic;
			lsb : std_logic;
		end record signal_type;
		type signals_type is record
			msb : std_logic_vector(16-1 downto 0);
			lsb : std_logic_vector(16-1 downto 0);
		end record signals_type;
	end my_package;