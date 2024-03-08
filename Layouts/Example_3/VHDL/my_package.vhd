--  my_package.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	package my_package is
		type routeCommands is (RELEASE,RESERVE,LOCK);
		type nodeStates is (OCCUPIED,FREE,RESERVED,LOCKED);
		type singleSwitchStates is (NORMAL,REVERSE,TRANSITION,RESERVED,LOCKED);
		type sSwitch_type is record
			msb : std_logic;
			lsb : std_logic;
		end record sSwitch_type;
		type sSwitches_type is record
			msb : std_logic_vector(15-1 downto 0);
			lsb : std_logic_vector(15-1 downto 0);
		end record sSwitches_type;
		type dSwitch_type is record
			msb : std_logic;
			lsb : std_logic;
		end record dSwitch_type;
		type dSwitches_type is record
			msb : std_logic_vector(2-1 downto 0);
			lsb : std_logic_vector(2-1 downto 0);
		end record dSwitches_type;
		type scrissorCrossing_type is record
			msb : std_logic;
			lsb : std_logic;
		end record scrissorCrossing_type;
		type levelCrossingStates is (DOWN,UP,TRANSITION,RESERVED,LOCKED);
		type levelCrossing_type is record
			msb : std_logic;
			lsb : std_logic;
		end record levelCrossing_type;
		type signal_type is record
			msb : std_logic;
			lsb : std_logic;
		end record signal_type;
		type signals_type is record
			msb : std_logic_vector(82-1 downto 0);
			lsb : std_logic_vector(82-1 downto 0);
		end record signals_type;
	end my_package;