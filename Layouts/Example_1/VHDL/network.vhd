--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 85;
			N_SIGNALS : natural := 23;
			N_ROUTES : natural := 21;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 5;
			N_TRACKCIRCUITS : natural := 11
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
			ocupation_ne13 : in std_logic;
			ocupation_ne2 : in std_logic;
			R1_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc08 : out levelCrossingStates;
			lock_Lc08 : out objectLock
		);
	end component levelCrossing_0;
	component levelCrossing_1 is
		port(
			clock : in std_logic;
			ocupation_ne14 : in std_logic;
			ocupation_ne9 : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc06 : out levelCrossingStates;
			lock_Lc06 : out objectLock
		);
	end component levelCrossing_1;
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw04 : out singleSwitchStates;
			lock_Sw04 : out objectLock
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			R9_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw06 : out singleSwitchStates;
			lock_Sw06 : out objectLock
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw12 : out singleSwitchStates;
			lock_Sw12 : out objectLock
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw07 : out singleSwitchStates;
			lock_Sw07 : out objectLock
		);
	end component singleSwitch_3;
	component singleSwitch_4 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			R19_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw13 : out singleSwitchStates;
			lock_Sw13 : out objectLock
		);
	end component singleSwitch_4;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
			correspondence_L07 : out signalStates;
			lock_L07 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
			correspondence_S22 : out signalStates;
			lock_S22 : out objectLock;
			--Ocupation level 1
			ocupation_ne8 : in std_logic;
			ocupation_ne9 : in std_logic;
			ocupation_ne14 : in std_logic;
			ocupation_ne15 : in std_logic;
			correspondence_S32 : in signalStates;
			correspondence_X15 : in signalStates;
			correspondence_T05 : in signalStates;
			Sw04_state : in singleSwitchStates;
			Sw07_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne22 : in std_logic;
			ocupation_ne12 : in std_logic;
			ocupation_ne24 : in std_logic;
			correspondence_J11 : in signalStates;
			correspondence_C25 : in signalStates;
			correspondence_T03 : in signalStates;
			Sw12_state : in singleSwitchStates;
			Sw13_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			--Ocupation level 0
			ocupation_ne2 : in std_logic;
			correspondence_L08 : out signalStates;
			lock_L08 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			Lc08_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne2 : in std_logic;
			correspondence_S27 : out signalStates;
			lock_S27 : out objectLock;
			--Ocupation level 1
			ocupation_ne12 : in std_logic;
			ocupation_ne13 : in std_logic;
			correspondence_S35 : in signalStates;
			correspondence_T01 : in signalStates;
			Sw06_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne23 : in std_logic;
			ocupation_ne8 : in std_logic;
			ocupation_ne24 : in std_logic;
			correspondence_J14 : in signalStates;
			correspondence_C21 : in signalStates;
			Sw13_state : in singleSwitchStates;
			Sw12_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			R10_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne8 : in std_logic;
			correspondence_C21 : out signalStates;
			lock_C21 : out objectLock;
			--Ocupation level 1
			ocupation_ne1 : in std_logic;
			correspondence_L07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne8 : in std_logic;
			correspondence_S32 : out signalStates;
			lock_S32 : out objectLock;
			--Ocupation level 1
			ocupation_ne22 : in std_logic;
			ocupation_ne24 : in std_logic;
			ocupation_ne12 : in std_logic;
			correspondence_J11 : in signalStates;
			correspondence_C25 : in signalStates;
			Sw12_state : in singleSwitchStates;
			Sw13_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne2 : in std_logic;
			correspondence_L09 : in signalStates;
			correspondence_L08 : in signalStates;
			Sw06_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			R14_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne12 : in std_logic;
			correspondence_C25 : out signalStates;
			lock_C25 : out objectLock;
			--Ocupation level 1
			ocupation_ne2 : in std_logic;
			correspondence_L08 : in signalStates;
			Sw06_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne12 : in std_logic;
			correspondence_S35 : out signalStates;
			lock_S35 : out objectLock;
			--Ocupation level 1
			ocupation_ne23 : in std_logic;
			ocupation_ne24 : in std_logic;
			ocupation_ne8 : in std_logic;
			correspondence_J14 : in signalStates;
			correspondence_C21 : in signalStates;
			Sw13_state : in singleSwitchStates;
			Sw12_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne1 : in std_logic;
			correspondence_L07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			--Ocupation level 0
			ocupation_ne13 : in std_logic;
			correspondence_T01 : out signalStates;
			lock_T01 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			R1_command : in routeCommands;
			Lc08_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne13 : in std_logic;
			correspondence_T02 : out signalStates;
			lock_T02 : out objectLock;
			correspondence_P20 : in signalStates;
			--Ocupation level 2
			ocupation_ne2 : in std_logic;
			correspondence_L08 : in signalStates;
			Sw06_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			R9_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne13 : in std_logic;
			correspondence_P20 : out signalStates;
			lock_P20 : out objectLock;
			--Ocupation level 1
			ocupation_ne2 : in std_logic;
			correspondence_L08 : in signalStates;
			Sw06_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			--Ocupation level 0
			ocupation_ne14 : in std_logic;
			correspondence_T03 : out signalStates;
			lock_T03 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			R2_command : in routeCommands;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne14 : in std_logic;
			correspondence_T04 : out signalStates;
			lock_T04 : out objectLock;
			correspondence_X16 : in signalStates;
			--Ocupation level 2
			ocupation_ne9 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_L07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			Sw07_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			R7_command : in routeCommands;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne14 : in std_logic;
			correspondence_X15 : out signalStates;
			lock_X15 : out objectLock;
			correspondence_T03 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			R8_command : in routeCommands;
			Lc06_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne14 : in std_logic;
			correspondence_X16 : out signalStates;
			lock_X16 : out objectLock;
			--Ocupation level 1
			ocupation_ne9 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_L07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			Sw07_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			--Ocupation level 0
			ocupation_ne15 : in std_logic;
			correspondence_T05 : out signalStates;
			lock_T05 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_15;
	component railwaySignal_16 is
		port(
			clock : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne15 : in std_logic;
			correspondence_T06 : out signalStates;
			lock_T06 : out objectLock;
			correspondence_C29 : in signalStates;
			--Ocupation level 2
			ocupation_ne9 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_L07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			Sw07_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_16;
	component railwaySignal_17 is
		port(
			clock : in std_logic;
			R17_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne15 : in std_logic;
			correspondence_C29 : out signalStates;
			lock_C29 : out objectLock;
			--Ocupation level 1
			ocupation_ne9 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_L07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			Sw07_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_17;
	component railwaySignal_18 is
		port(
			clock : in std_logic;
			--Ocupation level 0
			ocupation_ne22 : in std_logic;
			correspondence_L09 : out signalStates;
			lock_L09 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_18;
	component railwaySignal_19 is
		port(
			clock : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne22 : in std_logic;
			correspondence_J11 : out signalStates;
			lock_J11 : out objectLock;
			correspondence_L09 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_19;
	component railwaySignal_20 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne22 : in std_logic;
			correspondence_J12 : out signalStates;
			lock_J12 : out objectLock;
			--Ocupation level 1
			ocupation_ne8 : in std_logic;
			correspondence_C21 : in signalStates;
			Sw12_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne1 : in std_logic;
			correspondence_L07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_20;
	component railwaySignal_21 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne23 : in std_logic;
			correspondence_J13 : out signalStates;
			lock_J13 : out objectLock;
			--Ocupation level 1
			ocupation_ne12 : in std_logic;
			correspondence_C25 : in signalStates;
			Sw13_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne2 : in std_logic;
			correspondence_L08 : in signalStates;
			Sw06_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_21;
	component railwaySignal_22 is
		port(
			clock : in std_logic;
			--Ocupation level 0
			ocupation_ne23 : in std_logic;
			correspondence_J14 : out signalStates;
			lock_J14 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_22;
	component node_0 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R9_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R19_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R9_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_6;
	component node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_7;
	component node_8 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R18_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_8;
	component node_9 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R20_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_9;
	component node_10 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_10;
	component route_0 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne13_state : in nodeStates;
			ne13_lock : in objectLock;
			ne13_command : out routeCommands;
			Lc08_state : in levelCrossingStates;
			Lc08_lock : in objectLock;
			Lc08_command : out routeCommands;
			T02_state : in signalStates;
			T02_lock : in objectLock;
			T02_command : out routeCommands;
			P20_state : in signalStates;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_lock : in objectLock;
			ne14_command : out routeCommands;
			T04_state : in signalStates;
			T04_lock : in objectLock;
			T04_command : out routeCommands;
			X16_state : in signalStates;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne15_state : in nodeStates;
			ne15_lock : in objectLock;
			ne15_command : out routeCommands;
			T06_state : in signalStates;
			T06_lock : in objectLock;
			T06_command : out routeCommands;
			C29_state : in signalStates;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne22_state : in nodeStates;
			ne22_lock : in objectLock;
			ne22_command : out routeCommands;
			J11_state : in signalStates;
			J11_lock : in objectLock;
			J11_command : out routeCommands;
			L09_state : in signalStates;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne22_state : in nodeStates;
			ne22_lock : in objectLock;
			ne22_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			J12_state : in signalStates;
			J12_lock : in objectLock;
			J12_command : out routeCommands;
			C21_state : in signalStates;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			J13_state : in signalStates;
			J13_lock : in objectLock;
			J13_command : out routeCommands;
			C25_state : in signalStates;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_lock : in objectLock;
			ne14_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_lock : in objectLock;
			Lc06_command : out routeCommands;
			X15_state : in signalStates;
			X15_lock : in objectLock;
			X15_command : out routeCommands;
			T03_state : in signalStates;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_lock : in objectLock;
			ne14_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_lock : in objectLock;
			ne9_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_lock : in objectLock;
			Lc06_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			X16_state : in signalStates;
			X16_lock : in objectLock;
			X16_command : out routeCommands;
			L07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne13_state : in nodeStates;
			ne13_lock : in objectLock;
			ne13_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			P20_state : in signalStates;
			P20_lock : in objectLock;
			P20_command : out routeCommands;
			L08_state : in signalStates;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			C21_state : in signalStates;
			C21_lock : in objectLock;
			C21_command : out routeCommands;
			L07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			S32_state : in signalStates;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_lock : in objectLock;
			ne9_command : out routeCommands;
			ne14_state : in nodeStates;
			ne14_lock : in objectLock;
			ne14_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			X15_state : in signalStates;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_lock : in objectLock;
			ne9_command : out routeCommands;
			ne15_state : in nodeStates;
			ne15_lock : in objectLock;
			ne15_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			T05_state : in signalStates;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			C25_state : in signalStates;
			C25_lock : in objectLock;
			C25_command : out routeCommands;
			L08_state : in signalStates;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			S27_state : in signalStates;
			S27_lock : in objectLock;
			S27_command : out routeCommands;
			S35_state : in signalStates;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne13_state : in nodeStates;
			ne13_lock : in objectLock;
			ne13_command : out routeCommands;
			Lc08_state : in levelCrossingStates;
			Lc08_lock : in objectLock;
			Lc08_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_lock : in objectLock;
			Sw06_command : out routeCommands;
			S27_state : in signalStates;
			S27_lock : in objectLock;
			S27_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_15;
	component route_16 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne15_state : in nodeStates;
			ne15_lock : in objectLock;
			ne15_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_lock : in objectLock;
			ne9_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_lock : in objectLock;
			Sw07_command : out routeCommands;
			C29_state : in signalStates;
			C29_lock : in objectLock;
			C29_command : out routeCommands;
			L07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_16;
	component route_17 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			ne22_state : in nodeStates;
			ne22_lock : in objectLock;
			ne22_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			S32_state : in signalStates;
			S32_lock : in objectLock;
			S32_command : out routeCommands;
			J11_state : in signalStates;
			routeState : out std_logic
		);
	end component route_17;
	component route_18 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			ne24_state : in nodeStates;
			ne24_lock : in objectLock;
			ne24_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			S32_state : in signalStates;
			S32_lock : in objectLock;
			S32_command : out routeCommands;
			C25_state : in signalStates;
			routeState : out std_logic
		);
	end component route_18;
	component route_19 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_lock : in objectLock;
			ne23_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			S35_state : in signalStates;
			S35_lock : in objectLock;
			S35_command : out routeCommands;
			J14_state : in signalStates;
			routeState : out std_logic
		);
	end component route_19;
	component route_20 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_lock : in objectLock;
			ne12_command : out routeCommands;
			ne24_state : in nodeStates;
			ne24_lock : in objectLock;
			ne24_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_lock : in objectLock;
			ne8_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_lock : in objectLock;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_lock : in objectLock;
			Sw13_command : out routeCommands;
			S35_state : in signalStates;
			S35_lock : in objectLock;
			S35_command : out routeCommands;
			C21_state : in signalStates;
			routeState : out std_logic
		);
	end component route_20;
	signal state_Lc08 , state_Lc06 : levelCrossingStates := DOWN;
	signal Lc08_locking , Lc06_locking : objectLock := RELEASED;
	signal state_Sw04 , state_Sw06 , state_Sw12 , state_Sw07 , state_Sw13 : singleSwitchStates := NORMAL;
	signal Sw04_locking , Sw06_locking , Sw12_locking , Sw07_locking , Sw13_locking : objectLock := RELEASED;
	signal state_L07 , state_S22 , state_L08 , state_S27 , state_C21 , state_S32 , state_C25 , state_S35 , state_T01 , state_T02 , state_P20 , state_T03 , state_T04 , state_X15 , state_X16 , state_T05 , state_T06 , state_C29 , state_L09 , state_J11 , state_J12 , state_J13 , state_J14 : signalStates := RED;
	signal L07_locking , S22_locking , L08_locking , S27_locking , C21_locking , S32_locking , C25_locking , S35_locking , T01_locking , T02_locking , P20_locking , T03_locking , T04_locking , X15_locking , X16_locking , T05_locking , T06_locking , C29_locking , L09_locking , J11_locking , J12_locking , J13_locking , J14_locking : objectLock := RELEASED;
	signal state_ne1 , state_ne2 , state_ne8 , state_ne9 , state_ne12 , state_ne13 , state_ne14 , state_ne15 , state_ne22 , state_ne23 , state_ne24 : nodeStates := FREE;
	signal ne1_locking , ne2_locking , ne8_locking , ne9_locking , ne12_locking , ne13_locking , ne14_locking , ne15_locking , ne22_locking , ne23_locking , ne24_locking : objectLock := RELEASED;
	signal cmd_R1_ne13 , cmd_R2_ne14 , cmd_R3_ne15 , cmd_R4_ne22 , cmd_R5_ne22 , cmd_R5_ne8 , cmd_R6_ne23 , cmd_R6_ne12 , cmd_R7_ne14 , cmd_R8_ne14 , cmd_R8_ne9 , cmd_R8_ne1 , cmd_R9_ne13 , cmd_R9_ne2 , cmd_R10_ne8 , cmd_R10_ne1 , cmd_R11_ne1 , cmd_R11_ne8 , cmd_R12_ne1 , cmd_R12_ne9 , cmd_R12_ne14 , cmd_R13_ne1 , cmd_R13_ne9 , cmd_R13_ne15 , cmd_R14_ne12 , cmd_R14_ne2 , cmd_R15_ne2 , cmd_R15_ne12 , cmd_R16_ne2 , cmd_R16_ne13 , cmd_R17_ne15 , cmd_R17_ne9 , cmd_R17_ne1 , cmd_R18_ne8 , cmd_R18_ne22 , cmd_R19_ne8 , cmd_R19_ne24 , cmd_R19_ne12 , cmd_R20_ne12 , cmd_R20_ne23 , cmd_R21_ne12 , cmd_R21_ne24 , cmd_R21_ne8 : routeCommands := RELEASE;
	signal cmd_R1_Lc08 , cmd_R7_Lc06 , cmd_R8_Lc06 , cmd_R16_Lc08 : routeCommands := RELEASE;
	signal cmd_R5_Sw12 , cmd_R6_Sw13 , cmd_R8_Sw04 , cmd_R8_Sw07 , cmd_R9_Sw06 , cmd_R10_Sw04 , cmd_R11_Sw04 , cmd_R12_Sw04 , cmd_R12_Sw07 , cmd_R13_Sw04 , cmd_R13_Sw07 , cmd_R14_Sw06 , cmd_R15_Sw06 , cmd_R16_Sw06 , cmd_R17_Sw04 , cmd_R17_Sw07 , cmd_R18_Sw12 , cmd_R19_Sw12 , cmd_R19_Sw13 , cmd_R20_Sw13 , cmd_R21_Sw12 , cmd_R21_Sw13 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_T06 , cmd_R4_J11 , cmd_R5_J12 , cmd_R6_J13 , cmd_R7_X15 , cmd_R8_X16 , cmd_R9_P20 , cmd_R10_C21 , cmd_R11_S22 , cmd_R12_S22 , cmd_R13_S22 , cmd_R14_C25 , cmd_R15_S27 , cmd_R16_S27 , cmd_R17_C29 , cmd_R18_S32 , cmd_R19_S32 , cmd_R20_S35 , cmd_R21_S35 : routeCommands := RELEASE;
begin
	levelCrossing_Lc08 : levelCrossing_0 port map(clock => clock, R1_command => cmd_R1_Lc08, R16_command => cmd_R16_Lc08, ocupation_ne13 => ocupation(5), ocupation_ne2 => ocupation(1), indication => levelCrossings_i(0), command  => levelCrossings_o(0), lock_Lc08 => Lc08_locking, correspondence_Lc08 => state_Lc08);
	levelCrossing_Lc06 : levelCrossing_1 port map(clock => clock, R7_command => cmd_R7_Lc06, R8_command => cmd_R8_Lc06, ocupation_ne14 => ocupation(6), ocupation_ne9 => ocupation(3), indication => levelCrossings_i(1), command  => levelCrossings_o(1), lock_Lc06 => Lc06_locking, correspondence_Lc06 => state_Lc06);
	singleSwitch_Sw04 : singleSwitch_0 port map(clock => clock, R8_command => cmd_R8_Sw04, R10_command => cmd_R10_Sw04, R11_command => cmd_R11_Sw04, R12_command => cmd_R12_Sw04, R13_command => cmd_R13_Sw04, R17_command => cmd_R17_Sw04, indication => singleSwitches_i(0), command => singleSwitches_o(0), lock_Sw04 => Sw04_locking, correspondence_Sw04 => state_Sw04);
	singleSwitch_Sw06 : singleSwitch_1 port map(clock => clock, R9_command => cmd_R9_Sw06, R14_command => cmd_R14_Sw06, R15_command => cmd_R15_Sw06, R16_command => cmd_R16_Sw06, indication => singleSwitches_i(1), command => singleSwitches_o(1), lock_Sw06 => Sw06_locking, correspondence_Sw06 => state_Sw06);
	singleSwitch_Sw12 : singleSwitch_2 port map(clock => clock, R5_command => cmd_R5_Sw12, R18_command => cmd_R18_Sw12, R19_command => cmd_R19_Sw12, R21_command => cmd_R21_Sw12, indication => singleSwitches_i(2), command => singleSwitches_o(2), lock_Sw12 => Sw12_locking, correspondence_Sw12 => state_Sw12);
	singleSwitch_Sw07 : singleSwitch_3 port map(clock => clock, R8_command => cmd_R8_Sw07, R12_command => cmd_R12_Sw07, R13_command => cmd_R13_Sw07, R17_command => cmd_R17_Sw07, indication => singleSwitches_i(3), command => singleSwitches_o(3), lock_Sw07 => Sw07_locking, correspondence_Sw07 => state_Sw07);
	singleSwitch_Sw13 : singleSwitch_4 port map(clock => clock, R6_command => cmd_R6_Sw13, R19_command => cmd_R19_Sw13, R20_command => cmd_R20_Sw13, R21_command => cmd_R21_Sw13, indication => singleSwitches_i(4), command => singleSwitches_o(4), lock_Sw13 => Sw13_locking, correspondence_Sw13 => state_Sw13);
	railwaySignal_L07 : railwaySignal_0 port map(clock => clock, ocupation_ne1 => ocupation(0), indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command.msb => signals_o.msb(0), command.lsb => signals_o.lsb(0), lock_L07 => L07_locking, correspondence_L07 => state_L07);
	railwaySignal_S22 : railwaySignal_1 port map(clock => clock, R11_command => cmd_R11_S22, R12_command => cmd_R12_S22, R13_command => cmd_R13_S22, ocupation_ne1 => ocupation(0), ocupation_ne8 => ocupation(2), ocupation_ne9 => ocupation(3), ocupation_ne14 => ocupation(6), ocupation_ne15 => ocupation(7), ocupation_ne22 => ocupation(8), ocupation_ne12 => ocupation(4), ocupation_ne24 => ocupation(10), correspondence_S32 => state_S32, correspondence_X15 => state_X15, correspondence_T05 => state_T05, correspondence_J11 => state_J11, correspondence_C25 => state_C25, correspondence_T03 => state_T03, Sw04_state => state_Sw04, Sw12_state => state_Sw12, Sw13_state => state_Sw13, Sw07_state => state_Sw07, Lc06_state => state_Lc06, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command.msb => signals_o.msb(1), command.lsb => signals_o.lsb(1), lock_S22 => S22_locking, correspondence_S22 => state_S22);
	railwaySignal_L08 : railwaySignal_2 port map(clock => clock, ocupation_ne2 => ocupation(1), indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command.msb => signals_o.msb(2), command.lsb => signals_o.lsb(2), lock_L08 => L08_locking, correspondence_L08 => state_L08);
	railwaySignal_S27 : railwaySignal_3 port map(clock => clock, R15_command => cmd_R15_S27, R16_command => cmd_R16_S27, ocupation_ne2 => ocupation(1), ocupation_ne12 => ocupation(4), ocupation_ne13 => ocupation(5), ocupation_ne23 => ocupation(9), ocupation_ne8 => ocupation(2), ocupation_ne24 => ocupation(10), correspondence_S35 => state_S35, correspondence_T01 => state_T01, correspondence_J14 => state_J14, correspondence_C21 => state_C21, Sw06_state => state_Sw06, Sw13_state => state_Sw13, Sw12_state => state_Sw12, Lc08_state => state_Lc08, indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command.msb => signals_o.msb(3), command.lsb => signals_o.lsb(3), lock_S27 => S27_locking, correspondence_S27 => state_S27);
	railwaySignal_C21 : railwaySignal_4 port map(clock => clock, R10_command => cmd_R10_C21, ocupation_ne8 => ocupation(2), ocupation_ne1 => ocupation(0), correspondence_L07 => state_L07, Sw04_state => state_Sw04, indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command.msb => signals_o.msb(4), command.lsb => signals_o.lsb(4), lock_C21 => C21_locking, correspondence_C21 => state_C21);
	railwaySignal_S32 : railwaySignal_5 port map(clock => clock, R18_command => cmd_R18_S32, R19_command => cmd_R19_S32, ocupation_ne8 => ocupation(2), ocupation_ne22 => ocupation(8), ocupation_ne24 => ocupation(10), ocupation_ne12 => ocupation(4), ocupation_ne2 => ocupation(1), correspondence_J11 => state_J11, correspondence_C25 => state_C25, correspondence_L09 => state_L09, correspondence_L08 => state_L08, Sw12_state => state_Sw12, Sw13_state => state_Sw13, Sw06_state => state_Sw06, indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command.msb => signals_o.msb(5), command.lsb => signals_o.lsb(5), lock_S32 => S32_locking, correspondence_S32 => state_S32);
	railwaySignal_C25 : railwaySignal_6 port map(clock => clock, R14_command => cmd_R14_C25, ocupation_ne12 => ocupation(4), ocupation_ne2 => ocupation(1), correspondence_L08 => state_L08, Sw06_state => state_Sw06, indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command.msb => signals_o.msb(6), command.lsb => signals_o.lsb(6), lock_C25 => C25_locking, correspondence_C25 => state_C25);
	railwaySignal_S35 : railwaySignal_7 port map(clock => clock, R20_command => cmd_R20_S35, R21_command => cmd_R21_S35, ocupation_ne12 => ocupation(4), ocupation_ne23 => ocupation(9), ocupation_ne24 => ocupation(10), ocupation_ne8 => ocupation(2), ocupation_ne1 => ocupation(0), correspondence_J14 => state_J14, correspondence_C21 => state_C21, correspondence_L07 => state_L07, Sw13_state => state_Sw13, Sw12_state => state_Sw12, Sw04_state => state_Sw04, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command.msb => signals_o.msb(7), command.lsb => signals_o.lsb(7), lock_S35 => S35_locking, correspondence_S35 => state_S35);
	railwaySignal_T01 : railwaySignal_8 port map(clock => clock, ocupation_ne13 => ocupation(5), indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command.msb => signals_o.msb(8), command.lsb => signals_o.lsb(8), lock_T01 => T01_locking, correspondence_T01 => state_T01);
	railwaySignal_T02 : railwaySignal_9 port map(clock => clock, R1_command => cmd_R1_T02, ocupation_ne13 => ocupation(5), ocupation_ne2 => ocupation(1), correspondence_P20 => state_P20, correspondence_L08 => state_L08, Sw06_state => state_Sw06, Lc08_state => state_Lc08, indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command.msb => signals_o.msb(9), command.lsb => signals_o.lsb(9), lock_T02 => T02_locking, correspondence_T02 => state_T02);
	railwaySignal_P20 : railwaySignal_10 port map(clock => clock, R9_command => cmd_R9_P20, ocupation_ne13 => ocupation(5), ocupation_ne2 => ocupation(1), correspondence_L08 => state_L08, Sw06_state => state_Sw06, indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command.msb => signals_o.msb(10), command.lsb => signals_o.lsb(10), lock_P20 => P20_locking, correspondence_P20 => state_P20);
	railwaySignal_T03 : railwaySignal_11 port map(clock => clock, ocupation_ne14 => ocupation(6), indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command.msb => signals_o.msb(11), command.lsb => signals_o.lsb(11), lock_T03 => T03_locking, correspondence_T03 => state_T03);
	railwaySignal_T04 : railwaySignal_12 port map(clock => clock, R2_command => cmd_R2_T04, ocupation_ne14 => ocupation(6), ocupation_ne9 => ocupation(3), ocupation_ne1 => ocupation(0), correspondence_X16 => state_X16, correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, Lc06_state => state_Lc06, indication.msb => signals_i.msb(12), indication.lsb => signals_i.lsb(12), command.msb => signals_o.msb(12), command.lsb => signals_o.lsb(12), lock_T04 => T04_locking, correspondence_T04 => state_T04);
	railwaySignal_X15 : railwaySignal_13 port map(clock => clock, R7_command => cmd_R7_X15, ocupation_ne14 => ocupation(6), correspondence_T03 => state_T03, Lc06_state => state_Lc06, indication.msb => signals_i.msb(13), indication.lsb => signals_i.lsb(13), command.msb => signals_o.msb(13), command.lsb => signals_o.lsb(13), lock_X15 => X15_locking, correspondence_X15 => state_X15);
	railwaySignal_X16 : railwaySignal_14 port map(clock => clock, R8_command => cmd_R8_X16, ocupation_ne14 => ocupation(6), ocupation_ne9 => ocupation(3), ocupation_ne1 => ocupation(0), correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, Lc06_state => state_Lc06, indication.msb => signals_i.msb(14), indication.lsb => signals_i.lsb(14), command.msb => signals_o.msb(14), command.lsb => signals_o.lsb(14), lock_X16 => X16_locking, correspondence_X16 => state_X16);
	railwaySignal_T05 : railwaySignal_15 port map(clock => clock, ocupation_ne15 => ocupation(7), indication.msb => signals_i.msb(15), indication.lsb => signals_i.lsb(15), command.msb => signals_o.msb(15), command.lsb => signals_o.lsb(15), lock_T05 => T05_locking, correspondence_T05 => state_T05);
	railwaySignal_T06 : railwaySignal_16 port map(clock => clock, R3_command => cmd_R3_T06, ocupation_ne15 => ocupation(7), ocupation_ne9 => ocupation(3), ocupation_ne1 => ocupation(0), correspondence_C29 => state_C29, correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, indication.msb => signals_i.msb(16), indication.lsb => signals_i.lsb(16), command.msb => signals_o.msb(16), command.lsb => signals_o.lsb(16), lock_T06 => T06_locking, correspondence_T06 => state_T06);
	railwaySignal_C29 : railwaySignal_17 port map(clock => clock, R17_command => cmd_R17_C29, ocupation_ne15 => ocupation(7), ocupation_ne9 => ocupation(3), ocupation_ne1 => ocupation(0), correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, indication.msb => signals_i.msb(17), indication.lsb => signals_i.lsb(17), command.msb => signals_o.msb(17), command.lsb => signals_o.lsb(17), lock_C29 => C29_locking, correspondence_C29 => state_C29);
	railwaySignal_L09 : railwaySignal_18 port map(clock => clock, ocupation_ne22 => ocupation(8), indication.msb => signals_i.msb(18), indication.lsb => signals_i.lsb(18), command.msb => signals_o.msb(18), command.lsb => signals_o.lsb(18), lock_L09 => L09_locking, correspondence_L09 => state_L09);
	railwaySignal_J11 : railwaySignal_19 port map(clock => clock, R4_command => cmd_R4_J11, ocupation_ne22 => ocupation(8), correspondence_L09 => state_L09, indication.msb => signals_i.msb(19), indication.lsb => signals_i.lsb(19), command.msb => signals_o.msb(19), command.lsb => signals_o.lsb(19), lock_J11 => J11_locking, correspondence_J11 => state_J11);
	railwaySignal_J12 : railwaySignal_20 port map(clock => clock, R5_command => cmd_R5_J12, ocupation_ne22 => ocupation(8), ocupation_ne8 => ocupation(2), ocupation_ne1 => ocupation(0), correspondence_C21 => state_C21, correspondence_L07 => state_L07, Sw12_state => state_Sw12, Sw04_state => state_Sw04, indication.msb => signals_i.msb(20), indication.lsb => signals_i.lsb(20), command.msb => signals_o.msb(20), command.lsb => signals_o.lsb(20), lock_J12 => J12_locking, correspondence_J12 => state_J12);
	railwaySignal_J13 : railwaySignal_21 port map(clock => clock, R6_command => cmd_R6_J13, ocupation_ne23 => ocupation(9), ocupation_ne12 => ocupation(4), ocupation_ne2 => ocupation(1), correspondence_C25 => state_C25, correspondence_L08 => state_L08, Sw13_state => state_Sw13, Sw06_state => state_Sw06, indication.msb => signals_i.msb(21), indication.lsb => signals_i.lsb(21), command.msb => signals_o.msb(21), command.lsb => signals_o.lsb(21), lock_J13 => J13_locking, correspondence_J13 => state_J13);
	railwaySignal_J14 : railwaySignal_22 port map(clock => clock, ocupation_ne23 => ocupation(9), indication.msb => signals_i.msb(22), indication.lsb => signals_i.lsb(22), command.msb => signals_o.msb(22), command.lsb => signals_o.lsb(22), lock_J14 => J14_locking, correspondence_J14 => state_J14);
	node_ne1 : node_0 port map(clock => clock, ocupation => ocupation(0), R8_command => cmd_R8_ne1, R10_command => cmd_R10_ne1, R11_command => cmd_R11_ne1, R12_command => cmd_R12_ne1, R13_command => cmd_R13_ne1, R17_command => cmd_R17_ne1, state => state_ne1, locking => ne1_locking);
	node_ne2 : node_1 port map(clock => clock, ocupation => ocupation(1), R9_command => cmd_R9_ne2, R14_command => cmd_R14_ne2, R15_command => cmd_R15_ne2, R16_command => cmd_R16_ne2, state => state_ne2, locking => ne2_locking);
	node_ne8 : node_2 port map(clock => clock, ocupation => ocupation(2), R5_command => cmd_R5_ne8, R10_command => cmd_R10_ne8, R11_command => cmd_R11_ne8, R18_command => cmd_R18_ne8, R19_command => cmd_R19_ne8, R21_command => cmd_R21_ne8, state => state_ne8, locking => ne8_locking);
	node_ne9 : node_3 port map(clock => clock, ocupation => ocupation(3), R8_command => cmd_R8_ne9, R12_command => cmd_R12_ne9, R13_command => cmd_R13_ne9, R17_command => cmd_R17_ne9, state => state_ne9, locking => ne9_locking);
	node_ne12 : node_4 port map(clock => clock, ocupation => ocupation(4), R6_command => cmd_R6_ne12, R14_command => cmd_R14_ne12, R15_command => cmd_R15_ne12, R19_command => cmd_R19_ne12, R20_command => cmd_R20_ne12, R21_command => cmd_R21_ne12, state => state_ne12, locking => ne12_locking);
	node_ne13 : node_5 port map(clock => clock, ocupation => ocupation(5), R1_command => cmd_R1_ne13, R9_command => cmd_R9_ne13, R16_command => cmd_R16_ne13, state => state_ne13, locking => ne13_locking);
	node_ne14 : node_6 port map(clock => clock, ocupation => ocupation(6), R2_command => cmd_R2_ne14, R7_command => cmd_R7_ne14, R8_command => cmd_R8_ne14, R12_command => cmd_R12_ne14, state => state_ne14, locking => ne14_locking);
	node_ne15 : node_7 port map(clock => clock, ocupation => ocupation(7), R3_command => cmd_R3_ne15, R13_command => cmd_R13_ne15, R17_command => cmd_R17_ne15, state => state_ne15, locking => ne15_locking);
	node_ne22 : node_8 port map(clock => clock, ocupation => ocupation(8), R4_command => cmd_R4_ne22, R5_command => cmd_R5_ne22, R18_command => cmd_R18_ne22, state => state_ne22, locking => ne22_locking);
	node_ne23 : node_9 port map(clock => clock, ocupation => ocupation(9), R6_command => cmd_R6_ne23, R20_command => cmd_R20_ne23, state => state_ne23, locking => ne23_locking);
	node_ne24 : node_10 port map(clock => clock, ocupation => ocupation(10), R19_command => cmd_R19_ne24, R21_command => cmd_R21_ne24, state => state_ne24, locking => ne24_locking);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne13_command => cmd_R1_ne13, ne13_state => state_ne13, ne13_lock => ne13_locking, Lc08_command => cmd_R1_Lc08, Lc08_state => state_Lc08, Lc08_lock => Lc08_locking, T02_state => state_T02, T02_lock => T02_locking, T02_command => cmd_R1_T02, P20_state => state_P20, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne14_command => cmd_R2_ne14, ne14_state => state_ne14, ne14_lock => ne14_locking, T04_state => state_T04, T04_lock => T04_locking, T04_command => cmd_R2_T04, X16_state => state_X16, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne15_command => cmd_R3_ne15, ne15_state => state_ne15, ne15_lock => ne15_locking, T06_state => state_T06, T06_lock => T06_locking, T06_command => cmd_R3_T06, C29_state => state_C29, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne22_command => cmd_R4_ne22, ne22_state => state_ne22, ne22_lock => ne22_locking, J11_state => state_J11, J11_lock => J11_locking, J11_command => cmd_R4_J11, L09_state => state_L09, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne8_command => cmd_R5_ne8, ne8_state => state_ne8, ne8_lock => ne8_locking, ne22_command => cmd_R5_ne22, ne22_state => state_ne22, ne22_lock => ne22_locking, Sw12_command => cmd_R5_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, J12_state => state_J12, J12_lock => J12_locking, J12_command => cmd_R5_J12, C21_state => state_C21, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne12_command => cmd_R6_ne12, ne12_state => state_ne12, ne12_lock => ne12_locking, ne23_command => cmd_R6_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, Sw13_command => cmd_R6_Sw13, Sw13_state => state_Sw13, Sw13_lock => Sw13_locking, J13_state => state_J13, J13_lock => J13_locking, J13_command => cmd_R6_J13, C25_state => state_C25, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne14_command => cmd_R7_ne14, ne14_state => state_ne14, ne14_lock => ne14_locking, Lc06_command => cmd_R7_Lc06, Lc06_state => state_Lc06, Lc06_lock => Lc06_locking, X15_state => state_X15, X15_lock => X15_locking, X15_command => cmd_R7_X15, T03_state => state_T03, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne1_command => cmd_R8_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne9_command => cmd_R8_ne9, ne9_state => state_ne9, ne9_lock => ne9_locking, ne14_command => cmd_R8_ne14, ne14_state => state_ne14, ne14_lock => ne14_locking, Lc06_command => cmd_R8_Lc06, Lc06_state => state_Lc06, Lc06_lock => Lc06_locking, Sw04_command => cmd_R8_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, Sw07_command => cmd_R8_Sw07, Sw07_state => state_Sw07, Sw07_lock => Sw07_locking, X16_state => state_X16, X16_lock => X16_locking, X16_command => cmd_R8_X16, L07_state => state_L07, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne2_command => cmd_R9_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne13_command => cmd_R9_ne13, ne13_state => state_ne13, ne13_lock => ne13_locking, Sw06_command => cmd_R9_Sw06, Sw06_state => state_Sw06, Sw06_lock => Sw06_locking, P20_state => state_P20, P20_lock => P20_locking, P20_command => cmd_R9_P20, L08_state => state_L08, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne1_command => cmd_R10_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne8_command => cmd_R10_ne8, ne8_state => state_ne8, ne8_lock => ne8_locking, Sw04_command => cmd_R10_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, C21_state => state_C21, C21_lock => C21_locking, C21_command => cmd_R10_C21, L07_state => state_L07, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), ne1_command => cmd_R11_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne8_command => cmd_R11_ne8, ne8_state => state_ne8, ne8_lock => ne8_locking, Sw04_command => cmd_R11_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R11_S22, S32_state => state_S32, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), ne1_command => cmd_R12_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne9_command => cmd_R12_ne9, ne9_state => state_ne9, ne9_lock => ne9_locking, ne14_command => cmd_R12_ne14, ne14_state => state_ne14, ne14_lock => ne14_locking, Sw04_command => cmd_R12_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, Sw07_command => cmd_R12_Sw07, Sw07_state => state_Sw07, Sw07_lock => Sw07_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R12_S22, X15_state => state_X15, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), ne1_command => cmd_R13_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne9_command => cmd_R13_ne9, ne9_state => state_ne9, ne9_lock => ne9_locking, ne15_command => cmd_R13_ne15, ne15_state => state_ne15, ne15_lock => ne15_locking, Sw04_command => cmd_R13_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, Sw07_command => cmd_R13_Sw07, Sw07_state => state_Sw07, Sw07_lock => Sw07_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R13_S22, T05_state => state_T05, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), ne2_command => cmd_R14_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne12_command => cmd_R14_ne12, ne12_state => state_ne12, ne12_lock => ne12_locking, Sw06_command => cmd_R14_Sw06, Sw06_state => state_Sw06, Sw06_lock => Sw06_locking, C25_state => state_C25, C25_lock => C25_locking, C25_command => cmd_R14_C25, L08_state => state_L08, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), ne2_command => cmd_R15_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne12_command => cmd_R15_ne12, ne12_state => state_ne12, ne12_lock => ne12_locking, Sw06_command => cmd_R15_Sw06, Sw06_state => state_Sw06, Sw06_lock => Sw06_locking, S27_state => state_S27, S27_lock => S27_locking, S27_command => cmd_R15_S27, S35_state => state_S35, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), ne2_command => cmd_R16_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne13_command => cmd_R16_ne13, ne13_state => state_ne13, ne13_lock => ne13_locking, Lc08_command => cmd_R16_Lc08, Lc08_state => state_Lc08, Lc08_lock => Lc08_locking, Sw06_command => cmd_R16_Sw06, Sw06_state => state_Sw06, Sw06_lock => Sw06_locking, S27_state => state_S27, S27_lock => S27_locking, S27_command => cmd_R16_S27, T01_state => state_T01, routeState => routes_o(15));
	route_R17 : route_16 port map(clock => clock, routeRequest => routes_i(16), ne1_command => cmd_R17_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne9_command => cmd_R17_ne9, ne9_state => state_ne9, ne9_lock => ne9_locking, ne15_command => cmd_R17_ne15, ne15_state => state_ne15, ne15_lock => ne15_locking, Sw04_command => cmd_R17_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, Sw07_command => cmd_R17_Sw07, Sw07_state => state_Sw07, Sw07_lock => Sw07_locking, C29_state => state_C29, C29_lock => C29_locking, C29_command => cmd_R17_C29, L07_state => state_L07, routeState => routes_o(16));
	route_R18 : route_17 port map(clock => clock, routeRequest => routes_i(17), ne8_command => cmd_R18_ne8, ne8_state => state_ne8, ne8_lock => ne8_locking, ne22_command => cmd_R18_ne22, ne22_state => state_ne22, ne22_lock => ne22_locking, Sw12_command => cmd_R18_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, S32_state => state_S32, S32_lock => S32_locking, S32_command => cmd_R18_S32, J11_state => state_J11, routeState => routes_o(17));
	route_R19 : route_18 port map(clock => clock, routeRequest => routes_i(18), ne8_command => cmd_R19_ne8, ne8_state => state_ne8, ne8_lock => ne8_locking, ne12_command => cmd_R19_ne12, ne12_state => state_ne12, ne12_lock => ne12_locking, ne24_command => cmd_R19_ne24, ne24_state => state_ne24, ne24_lock => ne24_locking, Sw12_command => cmd_R19_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, Sw13_command => cmd_R19_Sw13, Sw13_state => state_Sw13, Sw13_lock => Sw13_locking, S32_state => state_S32, S32_lock => S32_locking, S32_command => cmd_R19_S32, C25_state => state_C25, routeState => routes_o(18));
	route_R20 : route_19 port map(clock => clock, routeRequest => routes_i(19), ne12_command => cmd_R20_ne12, ne12_state => state_ne12, ne12_lock => ne12_locking, ne23_command => cmd_R20_ne23, ne23_state => state_ne23, ne23_lock => ne23_locking, Sw13_command => cmd_R20_Sw13, Sw13_state => state_Sw13, Sw13_lock => Sw13_locking, S35_state => state_S35, S35_lock => S35_locking, S35_command => cmd_R20_S35, J14_state => state_J14, routeState => routes_o(19));
	route_R21 : route_20 port map(clock => clock, routeRequest => routes_i(20), ne8_command => cmd_R21_ne8, ne8_state => state_ne8, ne8_lock => ne8_locking, ne12_command => cmd_R21_ne12, ne12_state => state_ne12, ne12_lock => ne12_locking, ne24_command => cmd_R21_ne24, ne24_state => state_ne24, ne24_lock => ne24_locking, Sw12_command => cmd_R21_Sw12, Sw12_state => state_Sw12, Sw12_lock => Sw12_locking, Sw13_command => cmd_R21_Sw13, Sw13_state => state_Sw13, Sw13_lock => Sw13_locking, S35_state => state_S35, S35_lock => S35_locking, S35_command => cmd_R21_S35, C21_state => state_C21, routeState => routes_o(20));
	processed <= processing;
end Behavioral;