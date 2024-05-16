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
			msb : std_logic_vector(15-1 downto 0);
			lsb : std_logic_vector(15-1 downto 0);
		end record sSwitches_type;
		type doubleSwitchStates is (DOUBLE_NORMAL,DOUBLE_REVERSE,REVERSE_NORMAL,NORMAL_REVERSE,TRANSITION);
		type dSwitch_type is record
			msb : std_logic;
			lsb : std_logic;
		end record dSwitch_type;
		type dSwitches_type is record
			msb : std_logic_vector(2-1 downto 0);
			lsb : std_logic_vector(2-1 downto 0);
		end record dSwitches_type;
		type scissorCrossingStates is (NORMAL,REVERSE,TRANSITION);
		type scissorCrossing_type is record
			msb : std_logic;
			lsb : std_logic;
		end record scissorCrossing_type;
		type levelCrossingStates is (DOWN,UP,TRANSITION);
		type levelCrossing_type is record
			msb : std_logic;
			lsb : std_logic;
		end record levelCrossing_type;
		type signalStates is (RED,DOUBLE_YELLOW,YELLOW,GREEN);
		type signal_type is record
			msb : std_logic;
			lsb : std_logic;
		end record signal_type;
		type signals_type is record
			msb : std_logic_vector(82-1 downto 0);
			lsb : std_logic_vector(82-1 downto 0);
		end record signals_type;
	end my_package;