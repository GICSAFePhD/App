--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 58;
			N_SIGNALS : natural := 16;
			N_ROUTES : natural := 13;
			N_LEVELCROSSINGS : natural := 6;
			N_SINGLESWITCHES : natural := 2;
			N_TRACKCIRCUITS : natural := 5
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			ocupation : in std_logic_vector(N_TRACKCIRCUITS-1 downto 0);
			signals_i : in signals_type;
			signals_o : out signals_type;
			routes_i : in std_logic_vector(N_ROUTES-1 downto 0);
			routes_o : out std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings_i : in std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			levelCrossings_o : out std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches_i : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity network;
architecture Behavioral of network is
	component levelCrossing_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne3 : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne27 : in std_logic;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc06 : out levelCrossingStates;
			lock_Lc06 : out objectLock
		);
	end component levelCrossing_0;
	component levelCrossing_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne23 : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne27 : in std_logic;
			R3_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc07 : out levelCrossingStates;
			lock_Lc07 : out objectLock
		);
	end component levelCrossing_1;
	component levelCrossing_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne23 : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne27 : in std_logic;
			R4_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc09 : out levelCrossingStates;
			lock_Lc09 : out objectLock
		);
	end component levelCrossing_2;
	component levelCrossing_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne23 : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc05 : out levelCrossingStates;
			lock_Lc05 : out objectLock
		);
	end component levelCrossing_3;
	component levelCrossing_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne3 : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc03 : out levelCrossingStates;
			lock_Lc03 : out objectLock
		);
	end component levelCrossing_4;
	component levelCrossing_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne3 : in std_logic;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc04 : out levelCrossingStates;
			lock_Lc04 : out objectLock
		);
	end component levelCrossing_5;
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw12 : out singleSwitchStates;
			lock_Sw12 : out objectLock
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw11 : out singleSwitchStates;
			lock_Sw11 : out objectLock
		);
	end component singleSwitch_1;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_L01 : out signalStates;
			lock_L01 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_X16 : out signalStates;
			lock_X16 : out objectLock;
			correspondence_L01 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc03_state : in levelCrossingStates;
			Lc04_state : in levelCrossingStates;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_S25 : out signalStates;
			lock_S25 : out objectLock;
			--Ocupation level 1
			ocupation_ne26 : in std_logic;
			ocupation_ne27 : in std_logic;
			ocupation_ne23 : in std_logic;
			correspondence_X07 : in signalStates;
			correspondence_X12 : in signalStates;
			Sw12_state : in singleSwitchStates;
			Sw11_state : in singleSwitchStates;
			correspondence_L04 : in signalStates;
			correspondence_P19 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne23 : in std_logic;
			correspondence_L02 : out signalStates;
			lock_L02 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			Lc07_state : in levelCrossingStates;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne23 : in std_logic;
			correspondence_X09 : out signalStates;
			lock_X09 : out objectLock;
			correspondence_S22 : in signalStates;
			--Ocupation level 2
			ocupation_ne27 : in std_logic;
			ocupation_ne3 : in std_logic;
			ocupation_ne25 : in std_logic;
			correspondence_X13 : in signalStates;
			correspondence_X16 : in signalStates;
			Sw11_state : in singleSwitchStates;
			Sw12_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne23 : in std_logic;
			correspondence_X12 : out signalStates;
			lock_X12 : out objectLock;
			correspondence_P19 : in signalStates;
			--Ocupation level 2
			correspondence_L02 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			Lc07_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne23 : in std_logic;
			correspondence_P19 : out signalStates;
			lock_P19 : out objectLock;
			correspondence_L02 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc05_state : in levelCrossingStates;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne23 : in std_logic;
			correspondence_S22 : out signalStates;
			lock_S22 : out objectLock;
			--Ocupation level 1
			ocupation_ne25 : in std_logic;
			ocupation_ne27 : in std_logic;
			ocupation_ne3 : in std_logic;
			correspondence_X13 : in signalStates;
			correspondence_X16 : in signalStates;
			Sw11_state : in singleSwitchStates;
			Sw12_state : in singleSwitchStates;
			correspondence_L03 : in signalStates;
			correspondence_L01 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne25 : in std_logic;
			correspondence_L03 : out signalStates;
			lock_L03 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			Lc05_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne25 : in std_logic;
			correspondence_X13 : out signalStates;
			lock_X13 : out objectLock;
			correspondence_L03 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne25 : in std_logic;
			correspondence_X14 : out signalStates;
			lock_X14 : out objectLock;
			--Ocupation level 1
			ocupation_ne23 : in std_logic;
			correspondence_X12 : in signalStates;
			Sw11_state : in singleSwitchStates;
			correspondence_P19 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne26 : in std_logic;
			correspondence_L04 : out signalStates;
			lock_L04 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne26 : in std_logic;
			correspondence_X05 : out signalStates;
			lock_X05 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc04_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne26 : in std_logic;
			correspondence_X06 : out signalStates;
			lock_X06 : out objectLock;
			correspondence_C24 : in signalStates;
			--Ocupation level 2
			ocupation_ne3 : in std_logic;
			correspondence_X16 : in signalStates;
			Sw12_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc04_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne26 : in std_logic;
			correspondence_X07 : out signalStates;
			lock_X07 : out objectLock;
			correspondence_L04 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne26 : in std_logic;
			correspondence_C24 : out signalStates;
			lock_C24 : out objectLock;
			--Ocupation level 1
			ocupation_ne3 : in std_logic;
			correspondence_X16 : in signalStates;
			Sw12_state : in singleSwitchStates;
			correspondence_L01 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_15;
	component node_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R6_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_4;
	component route_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_lock : in objectLock;
			ne26_command : out routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc03_lock : in objectLock;
			Lc03_command : out routeCommands;
			X06_state : in signalStates;
			X06_lock : in objectLock;
			X06_command : out routeCommands;
			C24_state : in signalStates;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_lock : in objectLock;
			ne26_command : out routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc03_lock : in objectLock;
			Lc03_command : out routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc04_lock : in objectLock;
			Lc04_command : out routeCommands;
			X07_state : in signalStates;
			X07_lock : in objectLock;
			X07_command : out routeCommands;
			L04_state : in signalStates;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Lc07_state : in levelCrossingStates;
			Lc07_lock : in objectLock;
			Lc07_command : out routeCommands;
			X09_state : in signalStates;
			X09_lock : in objectLock;
			X09_command : out routeCommands;
			S22_state : in signalStates;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_lock : in objectLock;
			Lc09_command : out routeCommands;
			X12_state : in signalStates;
			X12_lock : in objectLock;
			X12_command : out routeCommands;
			P19_state : in signalStates;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne25_state : in nodeStates;
			ne25_lock : in objectLock;
			ne25_command : out routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc05_lock : in objectLock;
			Lc05_command : out routeCommands;
			X13_state : in signalStates;
			X13_lock : in objectLock;
			X13_command : out routeCommands;
			L03_state : in signalStates;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne25_state : in nodeStates;
			ne25_lock : in objectLock;
			ne25_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc05_lock : in objectLock;
			Lc05_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_lock : in objectLock;
			Sw11_command : out routeCommands;
			X14_state : in signalStates;
			X14_lock : in objectLock;
			X14_command : out routeCommands;
			X12_state : in signalStates;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_lock : in objectLock;
			Lc06_command : out routeCommands;
			X16_state : in signalStates;
			X16_lock : in objectLock;
			X16_command : out routeCommands;
			L01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Lc07_state : in levelCrossingStates;
			Lc07_lock : in objectLock;
			Lc07_command : out routeCommands;
			P19_state : in signalStates;
			P19_lock : in objectLock;
			P19_command : out routeCommands;
			L02_state : in signalStates;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			ne25_state : in nodeStates;
			ne25_lock : in objectLock;
			ne25_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_lock : in objectLock;
			Lc09_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_lock : in objectLock;
			Sw11_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			X13_state : in signalStates;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			ne27_state : in nodeStates;
			ne27_lock : in objectLock;
			ne27_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_lock : in objectLock;
			Lc09_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_lock : in objectLock;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			X16_state : in signalStates;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_lock : in objectLock;
			ne26_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc04_lock : in objectLock;
			Lc04_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			C24_state : in signalStates;
			C24_lock : in objectLock;
			C24_command : out routeCommands;
			X16_state : in signalStates;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne26_state : in nodeStates;
			ne26_lock : in objectLock;
			ne26_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_lock : in objectLock;
			Lc06_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			S25_state : in signalStates;
			S25_lock : in objectLock;
			S25_command : out routeCommands;
			X07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne27_state : in nodeStates;
			ne27_lock : in objectLock;
			ne27_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_lock : in objectLock;
			Lc06_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_lock : in objectLock;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			S25_state : in signalStates;
			S25_lock : in objectLock;
			S25_command : out routeCommands;
			X12_state : in signalStates;
			routeState : out std_logic
		);
	end component route_12;
	signal state_Lc06 , state_Lc07 , state_Lc09 , state_Lc05 , state_Lc03 , state_Lc04 : levelCrossingStates := DOWN;
	signal Lc06_locking , Lc07_locking , Lc09_locking , Lc05_locking , Lc03_locking , Lc04_locking : objectLock := RELEASED;
	signal state_Sw12 , state_Sw11 : singleSwitchStates := NORMAL;
	signal Sw12_locking , Sw11_locking : objectLock := RELEASED;
	signal state_L01 , state_X16 , state_S25 , state_L02 , state_X09 , state_X12 , state_P19 , state_S22 , state_L03 , state_X13 , state_X14 , state_L04 , state_X05 , state_X06 , state_X07 , state_C24 : signalStates := RED;
	signal L01_locking , X16_locking , S25_locking , L02_locking , X09_locking , X12_locking , P19_locking , S22_locking , L03_locking , X13_locking , X14_locking , L04_locking , X05_locking , X06_locking , X07_locking , C24_locking : objectLock := RELEASED;
	signal state_ne3 , state_ne23 , state_ne25 , state_ne26 , state_ne27 : nodeStates := FREE;
	signal ne3_locking , ne23_locking , ne25_locking , ne26_locking , ne27_locking : objectLock := RELEASED;
	signal cmd_R1_ne26 , cmd_R2_ne26 , cmd_R3_ne23 , cmd_R4_ne23 , cmd_R5_ne25 , cmd_R6_ne25 , cmd_R6_ne23 , cmd_R7_ne3 , cmd_R8_ne23 , cmd_R9_ne23 , cmd_R9_ne25 , cmd_R10_ne23 , cmd_R10_ne27 , cmd_R10_ne3 , cmd_R11_ne26 , cmd_R11_ne3 , cmd_R12_ne3 , cmd_R12_ne26 , cmd_R13_ne3 , cmd_R13_ne27 , cmd_R13_ne23 : routeCommands := RELEASE;
	signal cmd_R1_Lc03 , cmd_R2_Lc03 , cmd_R2_Lc04 , cmd_R3_Lc07 , cmd_R4_Lc09 , cmd_R5_Lc05 , cmd_R6_Lc05 , cmd_R7_Lc06 , cmd_R8_Lc07 , cmd_R9_Lc09 , cmd_R10_Lc09 , cmd_R11_Lc04 , cmd_R12_Lc06 , cmd_R13_Lc06 : routeCommands := RELEASE;
	signal cmd_R6_Sw11 , cmd_R9_Sw11 , cmd_R10_Sw11 , cmd_R10_Sw12 , cmd_R11_Sw12 , cmd_R12_Sw12 , cmd_R13_Sw11 , cmd_R13_Sw12 : routeCommands := RELEASE;
	signal cmd_R1_X06 , cmd_R2_X07 , cmd_R3_X09 , cmd_R4_X12 , cmd_R5_X13 , cmd_R6_X14 , cmd_R7_X16 , cmd_R8_P19 , cmd_R9_S22 , cmd_R10_S22 , cmd_R11_C24 , cmd_R12_S25 , cmd_R13_S25 : routeCommands := RELEASE;
begin
	levelCrossing_Lc06 : levelCrossing_0 port map(clock => clock, reset => reset, R7_command => cmd_R7_Lc06, R12_command => cmd_R12_Lc06, R13_command => cmd_R13_Lc06, ocupation_ne3 => ocupation(0), ocupation_ne26 => ocupation(3), ocupation_ne27 => ocupation(4), indication => levelCrossings_i(0), command  => levelCrossings_o(0), lock_Lc06 => Lc06_locking, correspondence_Lc06 => state_Lc06);
	levelCrossing_Lc07 : levelCrossing_1 port map(clock => clock, reset => reset, R3_command => cmd_R3_Lc07, R8_command => cmd_R8_Lc07, ocupation_ne23 => ocupation(1), ocupation_ne25 => ocupation(2), ocupation_ne27 => ocupation(4), indication => levelCrossings_i(1), command  => levelCrossings_o(1), lock_Lc07 => Lc07_locking, correspondence_Lc07 => state_Lc07);
	levelCrossing_Lc09 : levelCrossing_2 port map(clock => clock, reset => reset, R4_command => cmd_R4_Lc09, R9_command => cmd_R9_Lc09, R10_command => cmd_R10_Lc09, ocupation_ne23 => ocupation(1), ocupation_ne25 => ocupation(2), ocupation_ne27 => ocupation(4), indication => levelCrossings_i(2), command  => levelCrossings_o(2), lock_Lc09 => Lc09_locking, correspondence_Lc09 => state_Lc09);
	levelCrossing_Lc05 : levelCrossing_3 port map(clock => clock, reset => reset, R5_command => cmd_R5_Lc05, R6_command => cmd_R6_Lc05, ocupation_ne25 => ocupation(2), ocupation_ne23 => ocupation(1), indication => levelCrossings_i(3), command  => levelCrossings_o(3), lock_Lc05 => Lc05_locking, correspondence_Lc05 => state_Lc05);
	levelCrossing_Lc03 : levelCrossing_4 port map(clock => clock, reset => reset, R1_command => cmd_R1_Lc03, R2_command => cmd_R2_Lc03, ocupation_ne26 => ocupation(3), ocupation_ne3 => ocupation(0), indication => levelCrossings_i(4), command  => levelCrossings_o(4), lock_Lc03 => Lc03_locking, correspondence_Lc03 => state_Lc03);
	levelCrossing_Lc04 : levelCrossing_5 port map(clock => clock, reset => reset, R2_command => cmd_R2_Lc04, R11_command => cmd_R11_Lc04, ocupation_ne26 => ocupation(3), ocupation_ne3 => ocupation(0), indication => levelCrossings_i(5), command  => levelCrossings_o(5), lock_Lc04 => Lc04_locking, correspondence_Lc04 => state_Lc04);
	singleSwitch_Sw12 : singleSwitch_0 port map(clock => clock, reset => reset, R10_command => cmd_R10_Sw12, R11_command => cmd_R11_Sw12, R12_command => cmd_R12_Sw12, R13_command => cmd_R13_Sw12, indication => singleSwitches_i(0), command => singleSwitches_o(0), lock_Sw12 => Sw12_locking, correspondence_Sw12 => state_Sw12);
	singleSwitch_Sw11 : singleSwitch_1 port map(clock => clock, reset => reset, R6_command => cmd_R6_Sw11, R9_command => cmd_R9_Sw11, R10_command => cmd_R10_Sw11, R13_command => cmd_R13_Sw11, indication => singleSwitches_i(1), command => singleSwitches_o(1), lock_Sw11 => Sw11_locking, correspondence_Sw11 => state_Sw11);
	railwaySignal_L01 : railwaySignal_0 port map(clock => clock, reset => reset, ocupation_ne3 => ocupation(0), indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command.msb => signals_o.msb(0), command.lsb => signals_o.lsb(0), lock_L01 => L01_locking, correspondence_L01 => state_L01);
	railwaySignal_X16 : railwaySignal_1 port map(clock => clock, reset => reset, R7_command => cmd_R7_X16, ocupation_ne3 => ocupation(0), correspondence_L01 => state_L01, Lc06_state => state_Lc06, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command.msb => signals_o.msb(1), command.lsb => signals_o.lsb(1), lock_X16 => X16_locking, correspondence_X16 => state_X16);
	railwaySignal_S25 : railwaySignal_2 port map(clock => clock, reset => reset, R12_command => cmd_R12_S25, R13_command => cmd_R13_S25, ocupation_ne3 => ocupation(0), ocupation_ne26 => ocupation(3), ocupation_ne27 => ocupation(4), ocupation_ne23 => ocupation(1), correspondence_X07 => state_X07, correspondence_X12 => state_X12, correspondence_L04 => state_L04, correspondence_P19 => state_P19, Sw12_state => state_Sw12, Sw11_state => state_Sw11, Lc06_state => state_Lc06, Lc03_state => state_Lc03, Lc04_state => state_Lc04, Lc09_state => state_Lc09, indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command.msb => signals_o.msb(2), command.lsb => signals_o.lsb(2), lock_S25 => S25_locking, correspondence_S25 => state_S25);
	railwaySignal_L02 : railwaySignal_3 port map(clock => clock, reset => reset, ocupation_ne23 => ocupation(1), indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command.msb => signals_o.msb(3), command.lsb => signals_o.lsb(3), lock_L02 => L02_locking, correspondence_L02 => state_L02);
	railwaySignal_X09 : railwaySignal_4 port map(clock => clock, reset => reset, R3_command => cmd_R3_X09, ocupation_ne23 => ocupation(1), ocupation_ne27 => ocupation(4), ocupation_ne3 => ocupation(0), ocupation_ne25 => ocupation(2), correspondence_S22 => state_S22, correspondence_X13 => state_X13, correspondence_X16 => state_X16, Sw11_state => state_Sw11, Sw12_state => state_Sw12, Lc07_state => state_Lc07, Lc09_state => state_Lc09, indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command.msb => signals_o.msb(4), command.lsb => signals_o.lsb(4), lock_X09 => X09_locking, correspondence_X09 => state_X09);
	railwaySignal_X12 : railwaySignal_5 port map(clock => clock, reset => reset, R4_command => cmd_R4_X12, ocupation_ne23 => ocupation(1), correspondence_P19 => state_P19, correspondence_L02 => state_L02, Lc09_state => state_Lc09, indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command.msb => signals_o.msb(5), command.lsb => signals_o.lsb(5), lock_X12 => X12_locking, correspondence_X12 => state_X12);
	railwaySignal_P19 : railwaySignal_6 port map(clock => clock, reset => reset, R8_command => cmd_R8_P19, ocupation_ne23 => ocupation(1), correspondence_L02 => state_L02, Lc07_state => state_Lc07, indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command.msb => signals_o.msb(6), command.lsb => signals_o.lsb(6), lock_P19 => P19_locking, correspondence_P19 => state_P19);
	railwaySignal_S22 : railwaySignal_7 port map(clock => clock, reset => reset, R9_command => cmd_R9_S22, R10_command => cmd_R10_S22, ocupation_ne23 => ocupation(1), ocupation_ne25 => ocupation(2), ocupation_ne27 => ocupation(4), ocupation_ne3 => ocupation(0), correspondence_X13 => state_X13, correspondence_X16 => state_X16, correspondence_L03 => state_L03, correspondence_L01 => state_L01, Sw11_state => state_Sw11, Sw12_state => state_Sw12, Lc09_state => state_Lc09, Lc05_state => state_Lc05, Lc06_state => state_Lc06, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command.msb => signals_o.msb(7), command.lsb => signals_o.lsb(7), lock_S22 => S22_locking, correspondence_S22 => state_S22);
	railwaySignal_L03 : railwaySignal_8 port map(clock => clock, reset => reset, ocupation_ne25 => ocupation(2), indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command.msb => signals_o.msb(8), command.lsb => signals_o.lsb(8), lock_L03 => L03_locking, correspondence_L03 => state_L03);
	railwaySignal_X13 : railwaySignal_9 port map(clock => clock, reset => reset, R5_command => cmd_R5_X13, ocupation_ne25 => ocupation(2), correspondence_L03 => state_L03, Lc05_state => state_Lc05, indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command.msb => signals_o.msb(9), command.lsb => signals_o.lsb(9), lock_X13 => X13_locking, correspondence_X13 => state_X13);
	railwaySignal_X14 : railwaySignal_10 port map(clock => clock, reset => reset, R6_command => cmd_R6_X14, ocupation_ne25 => ocupation(2), ocupation_ne23 => ocupation(1), correspondence_X12 => state_X12, correspondence_P19 => state_P19, Sw11_state => state_Sw11, Lc05_state => state_Lc05, Lc09_state => state_Lc09, indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command.msb => signals_o.msb(10), command.lsb => signals_o.lsb(10), lock_X14 => X14_locking, correspondence_X14 => state_X14);
	railwaySignal_L04 : railwaySignal_11 port map(clock => clock, reset => reset, ocupation_ne26 => ocupation(3), indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command.msb => signals_o.msb(11), command.lsb => signals_o.lsb(11), lock_L04 => L04_locking, correspondence_L04 => state_L04);
	railwaySignal_X05 : railwaySignal_12 port map(clock => clock, reset => reset, ocupation_ne26 => ocupation(3), indication.msb => signals_i.msb(12), indication.lsb => signals_i.lsb(12), command.msb => signals_o.msb(12), command.lsb => signals_o.lsb(12), lock_X05 => X05_locking, correspondence_X05 => state_X05);
	railwaySignal_X06 : railwaySignal_13 port map(clock => clock, reset => reset, R1_command => cmd_R1_X06, ocupation_ne26 => ocupation(3), ocupation_ne3 => ocupation(0), correspondence_C24 => state_C24, correspondence_X16 => state_X16, Sw12_state => state_Sw12, Lc03_state => state_Lc03, Lc04_state => state_Lc04, indication.msb => signals_i.msb(13), indication.lsb => signals_i.lsb(13), command.msb => signals_o.msb(13), command.lsb => signals_o.lsb(13), lock_X06 => X06_locking, correspondence_X06 => state_X06);
	railwaySignal_X07 : railwaySignal_14 port map(clock => clock, reset => reset, R2_command => cmd_R2_X07, ocupation_ne26 => ocupation(3), correspondence_L04 => state_L04, Lc03_state => state_Lc03, Lc04_state => state_Lc04, indication.msb => signals_i.msb(14), indication.lsb => signals_i.lsb(14), command.msb => signals_o.msb(14), command.lsb => signals_o.lsb(14), lock_X07 => X07_locking, correspondence_X07 => state_X07);
	railwaySignal_C24 : railwaySignal_15 port map(clock => clock, reset => reset, R11_command => cmd_R11_C24, ocupation_ne26 => ocupation(3), ocupation_ne3 => ocupation(0), correspondence_X16 => state_X16, correspondence_L01 => state_L01, Sw12_state => state_Sw12, Lc04_state => state_Lc04, Lc06_state => state_Lc06, indication.msb => signals_i.msb(15), indication.lsb => signals_i.lsb(15), command.msb => signals_o.msb(15), command.lsb => signals_o.lsb(15), lock_C24 => C24_locking, correspondence_C24 => state_C24);
	node_ne3 : node_0 port map(clock => clock, ocupation => ocupation(0), reset => reset, R7_command => cmd_R7_ne3, R10_command => cmd_R10_ne3, R11_command => cmd_R11_ne3, R12_command => cmd_R12_ne3, R13_command => cmd_R13_ne3, state => state_ne3, locking => ne3_locking);
	node_ne23 : node_1 port map(clock => clock, ocupation => ocupation(1), reset => reset, R3_command => cmd_R3_ne23, R4_command => cmd_R4_ne23, R6_command => cmd_R6_ne23, R8_command => cmd_R8_ne23, R9_command => cmd_R9_ne23, R10_command => cmd_R10_ne23, R13_command => cmd_R13_ne23, state => state_ne23, locking => ne23_locking);
	node_ne25 : node_2 port map(clock => clock, ocupation => ocupation(2), reset => reset, R5_command => cmd_R5_ne25, R6_command => cmd_R6_ne25, R9_command => cmd_R9_ne25, state => state_ne25, locking => ne25_locking);
	node_ne26 : node_3 port map(clock => clock, ocupation => ocupation(3), reset => reset, R1_command => cmd_R1_ne26, R2_command => cmd_R2_ne26, R11_command => cmd_R11_ne26, R12_command => cmd_R12_ne26, state => state_ne26, locking => ne26_locking);
	node_ne27 : node_4 port map(clock => clock, ocupation => ocupation(4), reset => reset, R10_command => cmd_R10_ne27, R13_command => cmd_R13_ne27, state => state_ne27, locking => ne27_locking);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), reset => reset, ne26_command => cmd_R1_ne26, ne26_state => state_ne26, ne26_lock => ne26_locking, Lc03_command => cmd_R1_Lc03, Lc03_state => state_Lc03, Lc03_lock => Lc03_locking, X06_state => state_X06, X06_lock => X06_locking, X06_command => cmd_R1_X06, C24_state => state_C24, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), reset => reset, ne26_command => cmd_R2_ne26, ne26_state => state_ne26, ne26_lock => ne26_locking, Lc03_command => cmd_R2_Lc03, Lc03_state => state_Lc03, Lc03_lock => Lc03_locking, Lc04_command => cmd_R2_Lc04, Lc04_state => state_Lc04, Lc04_lock => Lc04_locking, X07_state => state_X07, X07_lock => X07_locking, X07_command => cmd_R2_X07, L04_state => state_L04, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), reset => reset, ne23_command => cmd_R3_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, Lc07_command => cmd_R3_Lc07, Lc07_state => state_Lc07, Lc07_lock => Lc07_locking, X09_state => state_X09, X09_lock => X09_locking, X09_command => cmd_R3_X09, S22_state => state_S22, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), reset => reset, ne23_command => cmd_R4_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, Lc09_command => cmd_R4_Lc09, Lc09_state => state_Lc09, Lc09_lock => Lc09_locking, X12_state => state_X12, X12_lock => X12_locking, X12_command => cmd_R4_X12, P19_state => state_P19, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), reset => reset, ne25_command => cmd_R5_ne25, ne25_state => state_ne25, ne25_lock => ne25_locking, Lc05_command => cmd_R5_Lc05, Lc05_state => state_Lc05, Lc05_lock => Lc05_locking, X13_state => state_X13, X13_lock => X13_locking, X13_command => cmd_R5_X13, L03_state => state_L03, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), reset => reset, ne23_command => cmd_R6_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, ne25_command => cmd_R6_ne25, ne25_state => state_ne25, ne25_lock => ne25_locking, Lc05_command => cmd_R6_Lc05, Lc05_state => state_Lc05, Lc05_lock => Lc05_locking, Sw11_command => cmd_R6_Sw11, Sw11_state => state_Sw11, Sw11_lock => Sw11_locking, X14_state => state_X14, X14_lock => X14_locking, X14_command => cmd_R6_X14, X12_state => state_X12, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), reset => reset, ne3_command => cmd_R7_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, Lc06_command => cmd_R7_Lc06, Lc06_state => state_Lc06, Lc06_lock => Lc06_locking, X16_state => state_X16, X16_lock => X16_locking, X16_command => cmd_R7_X16, L01_state => state_L01, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), reset => reset, ne23_command => cmd_R8_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, Lc07_command => cmd_R8_Lc07, Lc07_state => state_Lc07, Lc07_lock => Lc07_locking, P19_state => state_P19, P19_lock => P19_locking, P19_command => cmd_R8_P19, L02_state => state_L02, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), reset => reset, ne23_command => cmd_R9_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, ne25_command => cmd_R9_ne25, ne25_state => state_ne25, ne25_lock => ne25_locking, Lc09_command => cmd_R9_Lc09, Lc09_state => state_Lc09, Lc09_lock => Lc09_locking, Sw11_command => cmd_R9_Sw11, Sw11_state => state_Sw11, Sw11_lock => Sw11_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R9_S22, X13_state => state_X13, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), reset => reset, ne3_command => cmd_R10_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne23_command => cmd_R10_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, ne27_command => cmd_R10_ne27, ne27_state => state_ne27, ne27_lock => ne27_locking, Lc09_command => cmd_R10_Lc09, Lc09_state => state_Lc09, Lc09_lock => Lc09_locking, Sw11_command => cmd_R10_Sw11, Sw11_state => state_Sw11, Sw11_lock => Sw11_locking, Sw12_command => cmd_R10_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R10_S22, X16_state => state_X16, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), reset => reset, ne3_command => cmd_R11_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne26_command => cmd_R11_ne26, ne26_state => state_ne26, ne26_lock => ne26_locking, Lc04_command => cmd_R11_Lc04, Lc04_state => state_Lc04, Lc04_lock => Lc04_locking, Sw12_command => cmd_R11_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, C24_state => state_C24, C24_lock => C24_locking, C24_command => cmd_R11_C24, X16_state => state_X16, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), reset => reset, ne3_command => cmd_R12_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne26_command => cmd_R12_ne26, ne26_state => state_ne26, ne26_lock => ne26_locking, Lc06_command => cmd_R12_Lc06, Lc06_state => state_Lc06, Lc06_lock => Lc06_locking, Sw12_command => cmd_R12_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, S25_state => state_S25, S25_lock => S25_locking, S25_command => cmd_R12_S25, X07_state => state_X07, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), reset => reset, ne3_command => cmd_R13_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne23_command => cmd_R13_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, ne27_command => cmd_R13_ne27, ne27_state => state_ne27, ne27_lock => ne27_locking, Lc06_command => cmd_R13_Lc06, Lc06_state => state_Lc06, Lc06_lock => Lc06_locking, Sw11_command => cmd_R13_Sw11, Sw11_state => state_Sw11, Sw11_lock => Sw11_locking, Sw12_command => cmd_R13_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, S25_state => state_S25, S25_lock => S25_locking, S25_command => cmd_R13_S25, X12_state => state_X12, routeState => routes_o(12));
	processed <= processing;
end Behavioral;