--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 86;
			N_SIGNALS : natural := 24;
			N_ROUTES : natural := 22;
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
			singleSwitches_i : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity network;
architecture Behavioral of network is
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw01 : out singleSwitchStates;
			lock_Sw01 : out objectLock
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw03 : out singleSwitchStates;
			lock_Sw03 : out objectLock
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw02 : out singleSwitchStates;
			lock_Sw02 : out objectLock
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw05 : out singleSwitchStates;
			lock_Sw05 : out objectLock
		);
	end component singleSwitch_3;
	component singleSwitch_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw08 : out singleSwitchStates;
			lock_Sw08 : out objectLock
		);
	end component singleSwitch_4;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
			correspondence_J18 : out signalStates;
			lock_J18 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
			correspondence_S22 : out signalStates;
			lock_S22 : out objectLock;
			--Ocupation level 1
			ocupation_ne3 : in std_logic;
			ocupation_ne2 : in std_logic;
			ocupation_ne7 : in std_logic;
			ocupation_ne6 : in std_logic;
			correspondence_S27 : in signalStates;
			correspondence_J19 : in signalStates;
			correspondence_T03 : in signalStates;
			Sw01_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne4 : in std_logic;
			ocupation_ne5 : in std_logic;
			ocupation_ne41 : in std_logic;
			correspondence_S33 : in signalStates;
			correspondence_T01 : in signalStates;
			correspondence_T07 : in signalStates;
			Sw02_state : in singleSwitchStates;
			Sw08_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_C21 : out signalStates;
			lock_C21 : out objectLock;
			--Ocupation level 1
			ocupation_ne1 : in std_logic;
			correspondence_J18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_S27 : out signalStates;
			lock_S27 : out objectLock;
			--Ocupation level 1
			ocupation_ne5 : in std_logic;
			ocupation_ne4 : in std_logic;
			correspondence_S33 : in signalStates;
			correspondence_T01 : in signalStates;
			Sw02_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne10 : in std_logic;
			ocupation_ne11 : in std_logic;
			correspondence_T05 : in signalStates;
			correspondence_J13 : in signalStates;
			Sw05_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne4 : in std_logic;
			correspondence_T01 : out signalStates;
			lock_T01 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne4 : in std_logic;
			correspondence_T02 : out signalStates;
			lock_T02 : out objectLock;
			correspondence_B26 : in signalStates;
			--Ocupation level 2
			ocupation_ne3 : in std_logic;
			correspondence_C21 : in signalStates;
			Sw02_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne4 : in std_logic;
			correspondence_B26 : out signalStates;
			lock_B26 : out objectLock;
			--Ocupation level 1
			ocupation_ne3 : in std_logic;
			correspondence_C21 : in signalStates;
			Sw02_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne1 : in std_logic;
			correspondence_J18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne5 : in std_logic;
			correspondence_J16 : out signalStates;
			lock_J16 : out objectLock;
			--Ocupation level 1
			ocupation_ne3 : in std_logic;
			correspondence_C21 : in signalStates;
			Sw02_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne1 : in std_logic;
			correspondence_J18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne5 : in std_logic;
			correspondence_S33 : out signalStates;
			lock_S33 : out objectLock;
			--Ocupation level 1
			ocupation_ne10 : in std_logic;
			ocupation_ne11 : in std_logic;
			correspondence_T05 : in signalStates;
			correspondence_J13 : in signalStates;
			Sw05_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne6 : in std_logic;
			correspondence_T03 : out signalStates;
			lock_T03 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne6 : in std_logic;
			correspondence_T04 : out signalStates;
			lock_T04 : out objectLock;
			--Ocupation level 1
			ocupation_ne2 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_J18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne7 : in std_logic;
			correspondence_J19 : out signalStates;
			lock_J19 : out objectLock;
			--Ocupation level 1
			ocupation_ne41 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw08_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne7 : in std_logic;
			correspondence_J20 : out signalStates;
			lock_J20 : out objectLock;
			correspondence_C29 : in signalStates;
			--Ocupation level 2
			ocupation_ne1 : in std_logic;
			ocupation_ne2 : in std_logic;
			correspondence_J18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R17_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne7 : in std_logic;
			correspondence_C29 : out signalStates;
			lock_C29 : out objectLock;
			--Ocupation level 1
			ocupation_ne2 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_J18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne10 : in std_logic;
			correspondence_T05 : out signalStates;
			lock_T05 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne10 : in std_logic;
			correspondence_T06 : out signalStates;
			lock_T06 : out objectLock;
			--Ocupation level 1
			ocupation_ne5 : in std_logic;
			correspondence_J16 : in signalStates;
			Sw05_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne3 : in std_logic;
			correspondence_C21 : in signalStates;
			Sw02_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_15;
	component railwaySignal_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne11 : in std_logic;
			correspondence_J13 : out signalStates;
			lock_J13 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_16;
	component railwaySignal_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne11 : in std_logic;
			correspondence_J14 : out signalStates;
			lock_J14 : out objectLock;
			--Ocupation level 1
			ocupation_ne5 : in std_logic;
			correspondence_J16 : in signalStates;
			Sw05_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne3 : in std_logic;
			correspondence_C21 : in signalStates;
			Sw02_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_17;
	component railwaySignal_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne41 : in std_logic;
			correspondence_T07 : out signalStates;
			lock_T07 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_18;
	component railwaySignal_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne41 : in std_logic;
			correspondence_T08 : out signalStates;
			lock_T08 : out objectLock;
			correspondence_S37 : in signalStates;
			--Ocupation level 2
			ocupation_ne7 : in std_logic;
			ocupation_ne42 : in std_logic;
			correspondence_J20 : in signalStates;
			correspondence_B36 : in signalStates;
			Sw08_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_19;
	component railwaySignal_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne41 : in std_logic;
			correspondence_S37 : out signalStates;
			lock_S37 : out objectLock;
			--Ocupation level 1
			ocupation_ne7 : in std_logic;
			ocupation_ne42 : in std_logic;
			correspondence_J20 : in signalStates;
			correspondence_B36 : in signalStates;
			Sw08_state : in singleSwitchStates;
			correspondence_C29 : in signalStates;
			correspondence_T09 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_20;
	component railwaySignal_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne42 : in std_logic;
			correspondence_T09 : out signalStates;
			lock_T09 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_21;
	component railwaySignal_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne42 : in std_logic;
			correspondence_T10 : out signalStates;
			lock_T10 : out objectLock;
			--Ocupation level 1
			ocupation_ne41 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw08_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_22;
	component railwaySignal_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne42 : in std_logic;
			correspondence_B36 : out signalStates;
			lock_B36 : out objectLock;
			correspondence_T09 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_23;
	component node_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
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
			reset : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
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
			R14_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R12_command : in routeCommands;
			R17_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_6;
	component node_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R18_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_7;
	component node_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R19_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_8;
	component node_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_9;
	component node_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R20_command : in routeCommands;
			R22_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_10;
	component route_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne4_state : in nodeStates;
			ne4_lock : in objectLock;
			ne4_command : out routeCommands;
			T02_state : in signalStates;
			T02_lock : in objectLock;
			T02_command : out routeCommands;
			B26_state : in signalStates;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne6_state : in nodeStates;
			ne6_lock : in objectLock;
			ne6_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			T04_state : in signalStates;
			T04_lock : in objectLock;
			T04_command : out routeCommands;
			J18_state : in signalStates;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne10_state : in nodeStates;
			ne10_lock : in objectLock;
			ne10_command : out routeCommands;
			ne5_state : in nodeStates;
			ne5_lock : in objectLock;
			ne5_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_lock : in objectLock;
			Sw05_command : out routeCommands;
			T06_state : in signalStates;
			T06_lock : in objectLock;
			T06_command : out routeCommands;
			J16_state : in signalStates;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_lock : in objectLock;
			ne41_command : out routeCommands;
			T08_state : in signalStates;
			T08_lock : in objectLock;
			T08_command : out routeCommands;
			S37_state : in signalStates;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_lock : in objectLock;
			ne42_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_lock : in objectLock;
			ne41_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_lock : in objectLock;
			Sw08_command : out routeCommands;
			T10_state : in signalStates;
			T10_lock : in objectLock;
			T10_command : out routeCommands;
			T07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne11_state : in nodeStates;
			ne11_lock : in objectLock;
			ne11_command : out routeCommands;
			ne5_state : in nodeStates;
			ne5_lock : in objectLock;
			ne5_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_lock : in objectLock;
			Sw05_command : out routeCommands;
			J14_state : in signalStates;
			J14_lock : in objectLock;
			J14_command : out routeCommands;
			J16_state : in signalStates;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne5_state : in nodeStates;
			ne5_lock : in objectLock;
			ne5_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			J16_state : in signalStates;
			J16_lock : in objectLock;
			J16_command : out routeCommands;
			C21_state : in signalStates;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_lock : in objectLock;
			ne7_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_lock : in objectLock;
			ne41_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_lock : in objectLock;
			Sw08_command : out routeCommands;
			J19_state : in signalStates;
			J19_lock : in objectLock;
			J19_command : out routeCommands;
			T07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_lock : in objectLock;
			ne7_command : out routeCommands;
			J20_state : in signalStates;
			J20_lock : in objectLock;
			J20_command : out routeCommands;
			C29_state : in signalStates;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			C21_state : in signalStates;
			C21_lock : in objectLock;
			C21_command : out routeCommands;
			J18_state : in signalStates;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			S27_state : in signalStates;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne7_state : in nodeStates;
			ne7_lock : in objectLock;
			ne7_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			J19_state : in signalStates;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne6_state : in nodeStates;
			ne6_lock : in objectLock;
			ne6_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			S22_state : in signalStates;
			S22_lock : in objectLock;
			S22_command : out routeCommands;
			T03_state : in signalStates;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne4_state : in nodeStates;
			ne4_lock : in objectLock;
			ne4_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			B26_state : in signalStates;
			B26_lock : in objectLock;
			B26_command : out routeCommands;
			C21_state : in signalStates;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne5_state : in nodeStates;
			ne5_lock : in objectLock;
			ne5_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			S27_state : in signalStates;
			S27_lock : in objectLock;
			S27_command : out routeCommands;
			S33_state : in signalStates;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne4_state : in nodeStates;
			ne4_lock : in objectLock;
			ne4_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
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
			reset : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_lock : in objectLock;
			ne7_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_lock : in objectLock;
			ne2_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			C29_state : in signalStates;
			C29_lock : in objectLock;
			C29_command : out routeCommands;
			J18_state : in signalStates;
			routeState : out std_logic
		);
	end component route_16;
	component route_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne5_state : in nodeStates;
			ne5_lock : in objectLock;
			ne5_command : out routeCommands;
			ne10_state : in nodeStates;
			ne10_lock : in objectLock;
			ne10_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_lock : in objectLock;
			Sw05_command : out routeCommands;
			S33_state : in signalStates;
			S33_lock : in objectLock;
			S33_command : out routeCommands;
			T05_state : in signalStates;
			routeState : out std_logic
		);
	end component route_17;
	component route_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne5_state : in nodeStates;
			ne5_lock : in objectLock;
			ne5_command : out routeCommands;
			ne11_state : in nodeStates;
			ne11_lock : in objectLock;
			ne11_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_lock : in objectLock;
			Sw05_command : out routeCommands;
			S33_state : in signalStates;
			S33_lock : in objectLock;
			S33_command : out routeCommands;
			J13_state : in signalStates;
			routeState : out std_logic
		);
	end component route_18;
	component route_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_lock : in objectLock;
			ne42_command : out routeCommands;
			B36_state : in signalStates;
			B36_lock : in objectLock;
			B36_command : out routeCommands;
			T09_state : in signalStates;
			routeState : out std_logic
		);
	end component route_19;
	component route_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_lock : in objectLock;
			ne41_command : out routeCommands;
			ne7_state : in nodeStates;
			ne7_lock : in objectLock;
			ne7_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_lock : in objectLock;
			Sw08_command : out routeCommands;
			S37_state : in signalStates;
			S37_lock : in objectLock;
			S37_command : out routeCommands;
			J20_state : in signalStates;
			routeState : out std_logic
		);
	end component route_20;
	component route_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_lock : in objectLock;
			ne41_command : out routeCommands;
			ne42_state : in nodeStates;
			ne42_lock : in objectLock;
			ne42_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_lock : in objectLock;
			Sw08_command : out routeCommands;
			S37_state : in signalStates;
			S37_lock : in objectLock;
			S37_command : out routeCommands;
			B36_state : in signalStates;
			routeState : out std_logic
		);
	end component route_21;
	signal state_Sw01 , state_Sw03 , state_Sw02 , state_Sw05 , state_Sw08 : singleSwitchStates;
	signal Sw01_locking , Sw03_locking , Sw02_locking , Sw05_locking , Sw08_locking : objectLock;
	signal state_J18 , state_S22 , state_C21 , state_S27 , state_T01 , state_T02 , state_B26 , state_J16 , state_S33 , state_T03 , state_T04 , state_J19 , state_J20 , state_C29 , state_T05 , state_T06 , state_J13 , state_J14 , state_T07 , state_T08 , state_S37 , state_T09 , state_T10 , state_B36 : signalStates;
	signal J18_locking , S22_locking , C21_locking , S27_locking , T01_locking , T02_locking , B26_locking , J16_locking , S33_locking , T03_locking , T04_locking , J19_locking , J20_locking , C29_locking , T05_locking , T06_locking , J13_locking , J14_locking , T07_locking , T08_locking , S37_locking , T09_locking , T10_locking , B36_locking : objectLock;
	signal state_ne1 , state_ne2 , state_ne3 , state_ne4 , state_ne5 , state_ne6 , state_ne7 , state_ne10 , state_ne11 , state_ne41 , state_ne42 : nodeStates;
	signal ne1_locking , ne2_locking , ne3_locking , ne4_locking , ne5_locking , ne6_locking , ne7_locking , ne10_locking , ne11_locking , ne41_locking , ne42_locking : objectLock;
	signal cmd_R1_ne4 , cmd_R2_ne6 , cmd_R2_ne2 , cmd_R2_ne1 , cmd_R3_ne10 , cmd_R3_ne5 , cmd_R4_ne41 , cmd_R5_ne42 , cmd_R5_ne41 , cmd_R6_ne11 , cmd_R6_ne5 , cmd_R7_ne5 , cmd_R7_ne3 , cmd_R8_ne7 , cmd_R8_ne41 , cmd_R9_ne7 , cmd_R10_ne3 , cmd_R10_ne1 , cmd_R11_ne1 , cmd_R11_ne3 , cmd_R12_ne1 , cmd_R12_ne2 , cmd_R12_ne7 , cmd_R13_ne1 , cmd_R13_ne2 , cmd_R13_ne6 , cmd_R14_ne4 , cmd_R14_ne3 , cmd_R15_ne3 , cmd_R15_ne5 , cmd_R16_ne3 , cmd_R16_ne4 , cmd_R17_ne7 , cmd_R17_ne2 , cmd_R17_ne1 , cmd_R18_ne5 , cmd_R18_ne10 , cmd_R19_ne5 , cmd_R19_ne11 , cmd_R20_ne42 , cmd_R21_ne41 , cmd_R21_ne7 , cmd_R22_ne41 , cmd_R22_ne42 : routeCommands;
	signal cmd_R2_Sw01 , cmd_R2_Sw03 , cmd_R3_Sw05 , cmd_R5_Sw08 , cmd_R6_Sw05 , cmd_R7_Sw02 , cmd_R8_Sw08 , cmd_R10_Sw01 , cmd_R11_Sw01 , cmd_R12_Sw01 , cmd_R12_Sw03 , cmd_R13_Sw01 , cmd_R13_Sw03 , cmd_R14_Sw02 , cmd_R15_Sw02 , cmd_R16_Sw02 , cmd_R17_Sw01 , cmd_R17_Sw03 , cmd_R18_Sw05 , cmd_R19_Sw05 , cmd_R21_Sw08 , cmd_R22_Sw08 : routeCommands;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_T06 , cmd_R4_T08 , cmd_R5_T10 , cmd_R6_J14 , cmd_R7_J16 , cmd_R8_J19 , cmd_R9_J20 , cmd_R10_C21 , cmd_R11_S22 , cmd_R12_S22 , cmd_R13_S22 , cmd_R14_B26 , cmd_R15_S27 , cmd_R16_S27 , cmd_R17_C29 , cmd_R18_S33 , cmd_R19_S33 , cmd_R20_B36 , cmd_R21_S37 , cmd_R22_S37 : routeCommands;
begin
	singleSwitch_Sw01 : singleSwitch_0 port map(clock => clock, reset => reset, R2_command => cmd_R2_Sw01, R10_command => cmd_R10_Sw01, R11_command => cmd_R11_Sw01, R12_command => cmd_R12_Sw01, R13_command => cmd_R13_Sw01, R17_command => cmd_R17_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), lock_Sw01 => Sw01_locking, correspondence_Sw01 => state_Sw01);
	singleSwitch_Sw03 : singleSwitch_1 port map(clock => clock, reset => reset, R2_command => cmd_R2_Sw03, R12_command => cmd_R12_Sw03, R13_command => cmd_R13_Sw03, R17_command => cmd_R17_Sw03, indication => singleSwitches_i(1), command => singleSwitches_o(1), lock_Sw03 => Sw03_locking, correspondence_Sw03 => state_Sw03);
	singleSwitch_Sw02 : singleSwitch_2 port map(clock => clock, reset => reset, R7_command => cmd_R7_Sw02, R14_command => cmd_R14_Sw02, R15_command => cmd_R15_Sw02, R16_command => cmd_R16_Sw02, indication => singleSwitches_i(2), command => singleSwitches_o(2), lock_Sw02 => Sw02_locking, correspondence_Sw02 => state_Sw02);
	singleSwitch_Sw05 : singleSwitch_3 port map(clock => clock, reset => reset, R3_command => cmd_R3_Sw05, R6_command => cmd_R6_Sw05, R18_command => cmd_R18_Sw05, R19_command => cmd_R19_Sw05, indication => singleSwitches_i(3), command => singleSwitches_o(3), lock_Sw05 => Sw05_locking, correspondence_Sw05 => state_Sw05);
	singleSwitch_Sw08 : singleSwitch_4 port map(clock => clock, reset => reset, R5_command => cmd_R5_Sw08, R8_command => cmd_R8_Sw08, R21_command => cmd_R21_Sw08, R22_command => cmd_R22_Sw08, indication => singleSwitches_i(4), command => singleSwitches_o(4), lock_Sw08 => Sw08_locking, correspondence_Sw08 => state_Sw08);
	railwaySignal_J18 : railwaySignal_0 port map(clock => clock, reset => reset, ocupation_ne1 => ocupation(0), indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command.msb => signals_o.msb(0), command.lsb => signals_o.lsb(0), lock_J18 => J18_locking, correspondence_J18 => state_J18);
	railwaySignal_S22 : railwaySignal_1 port map(clock => clock, reset => reset, R11_command => cmd_R11_S22, R12_command => cmd_R12_S22, R13_command => cmd_R13_S22, ocupation_ne1 => ocupation(0), ocupation_ne3 => ocupation(2), ocupation_ne2 => ocupation(1), ocupation_ne7 => ocupation(6), ocupation_ne6 => ocupation(5), ocupation_ne4 => ocupation(3), ocupation_ne5 => ocupation(4), ocupation_ne41 => ocupation(9), correspondence_S27 => state_S27, correspondence_J19 => state_J19, correspondence_T03 => state_T03, correspondence_S33 => state_S33, correspondence_T01 => state_T01, correspondence_T07 => state_T07, Sw01_state => state_Sw01, Sw02_state => state_Sw02, Sw03_state => state_Sw03, Sw08_state => state_Sw08, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command.msb => signals_o.msb(1), command.lsb => signals_o.lsb(1), lock_S22 => S22_locking, correspondence_S22 => state_S22);
	railwaySignal_C21 : railwaySignal_2 port map(clock => clock, reset => reset, R10_command => cmd_R10_C21, ocupation_ne3 => ocupation(2), ocupation_ne1 => ocupation(0), correspondence_J18 => state_J18, Sw01_state => state_Sw01, indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command.msb => signals_o.msb(2), command.lsb => signals_o.lsb(2), lock_C21 => C21_locking, correspondence_C21 => state_C21);
	railwaySignal_S27 : railwaySignal_3 port map(clock => clock, reset => reset, R15_command => cmd_R15_S27, R16_command => cmd_R16_S27, ocupation_ne3 => ocupation(2), ocupation_ne5 => ocupation(4), ocupation_ne4 => ocupation(3), ocupation_ne10 => ocupation(7), ocupation_ne11 => ocupation(8), correspondence_S33 => state_S33, correspondence_T01 => state_T01, correspondence_T05 => state_T05, correspondence_J13 => state_J13, Sw02_state => state_Sw02, Sw05_state => state_Sw05, indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command.msb => signals_o.msb(3), command.lsb => signals_o.lsb(3), lock_S27 => S27_locking, correspondence_S27 => state_S27);
	railwaySignal_T01 : railwaySignal_4 port map(clock => clock, reset => reset, ocupation_ne4 => ocupation(3), indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command.msb => signals_o.msb(4), command.lsb => signals_o.lsb(4), lock_T01 => T01_locking, correspondence_T01 => state_T01);
	railwaySignal_T02 : railwaySignal_5 port map(clock => clock, reset => reset, R1_command => cmd_R1_T02, ocupation_ne4 => ocupation(3), ocupation_ne3 => ocupation(2), correspondence_B26 => state_B26, correspondence_C21 => state_C21, Sw02_state => state_Sw02, indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command.msb => signals_o.msb(5), command.lsb => signals_o.lsb(5), lock_T02 => T02_locking, correspondence_T02 => state_T02);
	railwaySignal_B26 : railwaySignal_6 port map(clock => clock, reset => reset, R14_command => cmd_R14_B26, ocupation_ne4 => ocupation(3), ocupation_ne3 => ocupation(2), ocupation_ne1 => ocupation(0), correspondence_C21 => state_C21, correspondence_J18 => state_J18, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command.msb => signals_o.msb(6), command.lsb => signals_o.lsb(6), lock_B26 => B26_locking, correspondence_B26 => state_B26);
	railwaySignal_J16 : railwaySignal_7 port map(clock => clock, reset => reset, R7_command => cmd_R7_J16, ocupation_ne5 => ocupation(4), ocupation_ne3 => ocupation(2), ocupation_ne1 => ocupation(0), correspondence_C21 => state_C21, correspondence_J18 => state_J18, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command.msb => signals_o.msb(7), command.lsb => signals_o.lsb(7), lock_J16 => J16_locking, correspondence_J16 => state_J16);
	railwaySignal_S33 : railwaySignal_8 port map(clock => clock, reset => reset, R18_command => cmd_R18_S33, R19_command => cmd_R19_S33, ocupation_ne5 => ocupation(4), ocupation_ne10 => ocupation(7), ocupation_ne11 => ocupation(8), correspondence_T05 => state_T05, correspondence_J13 => state_J13, Sw05_state => state_Sw05, indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command.msb => signals_o.msb(8), command.lsb => signals_o.lsb(8), lock_S33 => S33_locking, correspondence_S33 => state_S33);
	railwaySignal_T03 : railwaySignal_9 port map(clock => clock, reset => reset, ocupation_ne6 => ocupation(5), indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command.msb => signals_o.msb(9), command.lsb => signals_o.lsb(9), lock_T03 => T03_locking, correspondence_T03 => state_T03);
	railwaySignal_T04 : railwaySignal_10 port map(clock => clock, reset => reset, R2_command => cmd_R2_T04, ocupation_ne6 => ocupation(5), ocupation_ne2 => ocupation(1), ocupation_ne1 => ocupation(0), correspondence_J18 => state_J18, Sw01_state => state_Sw01, Sw03_state => state_Sw03, indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command.msb => signals_o.msb(10), command.lsb => signals_o.lsb(10), lock_T04 => T04_locking, correspondence_T04 => state_T04);
	railwaySignal_J19 : railwaySignal_11 port map(clock => clock, reset => reset, R8_command => cmd_R8_J19, ocupation_ne7 => ocupation(6), ocupation_ne41 => ocupation(9), correspondence_T07 => state_T07, Sw08_state => state_Sw08, indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command.msb => signals_o.msb(11), command.lsb => signals_o.lsb(11), lock_J19 => J19_locking, correspondence_J19 => state_J19);
	railwaySignal_J20 : railwaySignal_12 port map(clock => clock, reset => reset, R9_command => cmd_R9_J20, ocupation_ne7 => ocupation(6), ocupation_ne1 => ocupation(0), ocupation_ne2 => ocupation(1), correspondence_C29 => state_C29, correspondence_J18 => state_J18, Sw01_state => state_Sw01, Sw03_state => state_Sw03, indication.msb => signals_i.msb(12), indication.lsb => signals_i.lsb(12), command.msb => signals_o.msb(12), command.lsb => signals_o.lsb(12), lock_J20 => J20_locking, correspondence_J20 => state_J20);
	railwaySignal_C29 : railwaySignal_13 port map(clock => clock, reset => reset, R17_command => cmd_R17_C29, ocupation_ne7 => ocupation(6), ocupation_ne2 => ocupation(1), ocupation_ne1 => ocupation(0), correspondence_J18 => state_J18, Sw01_state => state_Sw01, Sw03_state => state_Sw03, indication.msb => signals_i.msb(13), indication.lsb => signals_i.lsb(13), command.msb => signals_o.msb(13), command.lsb => signals_o.lsb(13), lock_C29 => C29_locking, correspondence_C29 => state_C29);
	railwaySignal_T05 : railwaySignal_14 port map(clock => clock, reset => reset, ocupation_ne10 => ocupation(7), indication.msb => signals_i.msb(14), indication.lsb => signals_i.lsb(14), command.msb => signals_o.msb(14), command.lsb => signals_o.lsb(14), lock_T05 => T05_locking, correspondence_T05 => state_T05);
	railwaySignal_T06 : railwaySignal_15 port map(clock => clock, reset => reset, R3_command => cmd_R3_T06, ocupation_ne10 => ocupation(7), ocupation_ne5 => ocupation(4), ocupation_ne3 => ocupation(2), correspondence_J16 => state_J16, correspondence_C21 => state_C21, Sw05_state => state_Sw05, Sw02_state => state_Sw02, indication.msb => signals_i.msb(15), indication.lsb => signals_i.lsb(15), command.msb => signals_o.msb(15), command.lsb => signals_o.lsb(15), lock_T06 => T06_locking, correspondence_T06 => state_T06);
	railwaySignal_J13 : railwaySignal_16 port map(clock => clock, reset => reset, ocupation_ne11 => ocupation(8), indication.msb => signals_i.msb(16), indication.lsb => signals_i.lsb(16), command.msb => signals_o.msb(16), command.lsb => signals_o.lsb(16), lock_J13 => J13_locking, correspondence_J13 => state_J13);
	railwaySignal_J14 : railwaySignal_17 port map(clock => clock, reset => reset, R6_command => cmd_R6_J14, ocupation_ne11 => ocupation(8), ocupation_ne5 => ocupation(4), ocupation_ne3 => ocupation(2), correspondence_J16 => state_J16, correspondence_C21 => state_C21, Sw05_state => state_Sw05, Sw02_state => state_Sw02, indication.msb => signals_i.msb(17), indication.lsb => signals_i.lsb(17), command.msb => signals_o.msb(17), command.lsb => signals_o.lsb(17), lock_J14 => J14_locking, correspondence_J14 => state_J14);
	railwaySignal_T07 : railwaySignal_18 port map(clock => clock, reset => reset, ocupation_ne41 => ocupation(9), indication.msb => signals_i.msb(18), indication.lsb => signals_i.lsb(18), command.msb => signals_o.msb(18), command.lsb => signals_o.lsb(18), lock_T07 => T07_locking, correspondence_T07 => state_T07);
	railwaySignal_T08 : railwaySignal_19 port map(clock => clock, reset => reset, R4_command => cmd_R4_T08, ocupation_ne41 => ocupation(9), ocupation_ne7 => ocupation(6), ocupation_ne42 => ocupation(10), correspondence_S37 => state_S37, correspondence_J20 => state_J20, correspondence_B36 => state_B36, Sw08_state => state_Sw08, indication.msb => signals_i.msb(19), indication.lsb => signals_i.lsb(19), command.msb => signals_o.msb(19), command.lsb => signals_o.lsb(19), lock_T08 => T08_locking, correspondence_T08 => state_T08);
	railwaySignal_S37 : railwaySignal_20 port map(clock => clock, reset => reset, R21_command => cmd_R21_S37, R22_command => cmd_R22_S37, ocupation_ne41 => ocupation(9), ocupation_ne7 => ocupation(6), ocupation_ne42 => ocupation(10), correspondence_J20 => state_J20, correspondence_B36 => state_B36, correspondence_C29 => state_C29, correspondence_T09 => state_T09, Sw08_state => state_Sw08, indication.msb => signals_i.msb(20), indication.lsb => signals_i.lsb(20), command.msb => signals_o.msb(20), command.lsb => signals_o.lsb(20), lock_S37 => S37_locking, correspondence_S37 => state_S37);
	railwaySignal_T09 : railwaySignal_21 port map(clock => clock, reset => reset, ocupation_ne42 => ocupation(10), indication.msb => signals_i.msb(21), indication.lsb => signals_i.lsb(21), command.msb => signals_o.msb(21), command.lsb => signals_o.lsb(21), lock_T09 => T09_locking, correspondence_T09 => state_T09);
	railwaySignal_T10 : railwaySignal_22 port map(clock => clock, reset => reset, R5_command => cmd_R5_T10, ocupation_ne42 => ocupation(10), ocupation_ne41 => ocupation(9), correspondence_T07 => state_T07, Sw08_state => state_Sw08, indication.msb => signals_i.msb(22), indication.lsb => signals_i.lsb(22), command.msb => signals_o.msb(22), command.lsb => signals_o.lsb(22), lock_T10 => T10_locking, correspondence_T10 => state_T10);
	railwaySignal_B36 : railwaySignal_23 port map(clock => clock, reset => reset, R20_command => cmd_R20_B36, ocupation_ne42 => ocupation(10), correspondence_T09 => state_T09, indication.msb => signals_i.msb(23), indication.lsb => signals_i.lsb(23), command.msb => signals_o.msb(23), command.lsb => signals_o.lsb(23), lock_B36 => B36_locking, correspondence_B36 => state_B36);
	node_ne1 : node_0 port map(clock => clock, ocupation => ocupation(0), reset => reset, R2_command => cmd_R2_ne1, R10_command => cmd_R10_ne1, R11_command => cmd_R11_ne1, R12_command => cmd_R12_ne1, R13_command => cmd_R13_ne1, R17_command => cmd_R17_ne1, state => state_ne1, locking => ne1_locking);
	node_ne2 : node_1 port map(clock => clock, ocupation => ocupation(1), reset => reset, R2_command => cmd_R2_ne2, R12_command => cmd_R12_ne2, R13_command => cmd_R13_ne2, R17_command => cmd_R17_ne2, state => state_ne2, locking => ne2_locking);
	node_ne3 : node_2 port map(clock => clock, ocupation => ocupation(2), reset => reset, R7_command => cmd_R7_ne3, R10_command => cmd_R10_ne3, R11_command => cmd_R11_ne3, R14_command => cmd_R14_ne3, R15_command => cmd_R15_ne3, R16_command => cmd_R16_ne3, state => state_ne3, locking => ne3_locking);
	node_ne4 : node_3 port map(clock => clock, ocupation => ocupation(3), reset => reset, R1_command => cmd_R1_ne4, R14_command => cmd_R14_ne4, R16_command => cmd_R16_ne4, state => state_ne4, locking => ne4_locking);
	node_ne5 : node_4 port map(clock => clock, ocupation => ocupation(4), reset => reset, R3_command => cmd_R3_ne5, R6_command => cmd_R6_ne5, R7_command => cmd_R7_ne5, R15_command => cmd_R15_ne5, R18_command => cmd_R18_ne5, R19_command => cmd_R19_ne5, state => state_ne5, locking => ne5_locking);
	node_ne6 : node_5 port map(clock => clock, ocupation => ocupation(5), reset => reset, R2_command => cmd_R2_ne6, R13_command => cmd_R13_ne6, state => state_ne6, locking => ne6_locking);
	node_ne7 : node_6 port map(clock => clock, ocupation => ocupation(6), reset => reset, R8_command => cmd_R8_ne7, R9_command => cmd_R9_ne7, R12_command => cmd_R12_ne7, R17_command => cmd_R17_ne7, R21_command => cmd_R21_ne7, state => state_ne7, locking => ne7_locking);
	node_ne10 : node_7 port map(clock => clock, ocupation => ocupation(7), reset => reset, R3_command => cmd_R3_ne10, R18_command => cmd_R18_ne10, state => state_ne10, locking => ne10_locking);
	node_ne11 : node_8 port map(clock => clock, ocupation => ocupation(8), reset => reset, R6_command => cmd_R6_ne11, R19_command => cmd_R19_ne11, state => state_ne11, locking => ne11_locking);
	node_ne41 : node_9 port map(clock => clock, ocupation => ocupation(9), reset => reset, R4_command => cmd_R4_ne41, R5_command => cmd_R5_ne41, R8_command => cmd_R8_ne41, R21_command => cmd_R21_ne41, R22_command => cmd_R22_ne41, state => state_ne41, locking => ne41_locking);
	node_ne42 : node_10 port map(clock => clock, ocupation => ocupation(10), reset => reset, R5_command => cmd_R5_ne42, R20_command => cmd_R20_ne42, R22_command => cmd_R22_ne42, state => state_ne42, locking => ne42_locking);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), reset => reset, ne4_command => cmd_R1_ne4, ne4_state => state_ne4, ne4_lock => ne4_locking, T02_state => state_T02, T02_lock => T02_locking, T02_command => cmd_R1_T02, B26_state => state_B26, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), reset => reset, ne1_command => cmd_R2_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne2_command => cmd_R2_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne6_command => cmd_R2_ne6, ne6_state => state_ne6, ne6_lock => ne6_locking, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, Sw03_command => cmd_R2_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, T04_state => state_T04, T04_lock => T04_locking, T04_command => cmd_R2_T04, J18_state => state_J18, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), reset => reset, ne5_command => cmd_R3_ne5, ne5_state => state_ne5, ne5_lock => ne5_locking, ne10_command => cmd_R3_ne10, ne10_state => state_ne10, ne10_lock => ne10_locking, Sw05_command => cmd_R3_Sw05, Sw05_state => state_Sw05, Sw05_lock => Sw05_locking, T06_state => state_T06, T06_lock => T06_locking, T06_command => cmd_R3_T06, J16_state => state_J16, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), reset => reset, ne41_command => cmd_R4_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, T08_state => state_T08, T08_lock => T08_locking, T08_command => cmd_R4_T08, S37_state => state_S37, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), reset => reset, ne41_command => cmd_R5_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, ne42_command => cmd_R5_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, Sw08_command => cmd_R5_Sw08, Sw08_state => state_Sw08, Sw08_lock => Sw08_locking, T10_state => state_T10, T10_lock => T10_locking, T10_command => cmd_R5_T10, T07_state => state_T07, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), reset => reset, ne5_command => cmd_R6_ne5, ne5_state => state_ne5, ne5_lock => ne5_locking, ne11_command => cmd_R6_ne11, ne11_state => state_ne11, ne11_lock => ne11_locking, Sw05_command => cmd_R6_Sw05, Sw05_state => state_Sw05, Sw05_lock => Sw05_locking, J14_state => state_J14, J14_lock => J14_locking, J14_command => cmd_R6_J14, J16_state => state_J16, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), reset => reset, ne3_command => cmd_R7_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne5_command => cmd_R7_ne5, ne5_state => state_ne5, ne5_lock => ne5_locking, Sw02_command => cmd_R7_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, J16_state => state_J16, J16_lock => J16_locking, J16_command => cmd_R7_J16, C21_state => state_C21, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), reset => reset, ne7_command => cmd_R8_ne7, ne7_state => state_ne7, ne7_lock => ne7_locking, ne41_command => cmd_R8_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, Sw08_command => cmd_R8_Sw08, Sw08_state => state_Sw08, Sw08_lock => Sw08_locking, J19_state => state_J19, J19_lock => J19_locking, J19_command => cmd_R8_J19, T07_state => state_T07, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), reset => reset, ne7_command => cmd_R9_ne7, ne7_state => state_ne7, ne7_lock => ne7_locking, J20_state => state_J20, J20_lock => J20_locking, J20_command => cmd_R9_J20, C29_state => state_C29, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), reset => reset, ne1_command => cmd_R10_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne3_command => cmd_R10_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, Sw01_command => cmd_R10_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, C21_state => state_C21, C21_lock => C21_locking, C21_command => cmd_R10_C21, J18_state => state_J18, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), reset => reset, ne1_command => cmd_R11_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne3_command => cmd_R11_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, Sw01_command => cmd_R11_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R11_S22, S27_state => state_S27, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), reset => reset, ne1_command => cmd_R12_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne2_command => cmd_R12_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne7_command => cmd_R12_ne7, ne7_state => state_ne7, ne7_lock => ne7_locking, Sw01_command => cmd_R12_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, Sw03_command => cmd_R12_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R12_S22, J19_state => state_J19, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), reset => reset, ne1_command => cmd_R13_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne2_command => cmd_R13_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne6_command => cmd_R13_ne6, ne6_state => state_ne6, ne6_lock => ne6_locking, Sw01_command => cmd_R13_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, Sw03_command => cmd_R13_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, S22_state => state_S22, S22_lock => S22_locking, S22_command => cmd_R13_S22, T03_state => state_T03, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), reset => reset, ne3_command => cmd_R14_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne4_command => cmd_R14_ne4, ne4_state => state_ne4, ne4_lock => ne4_locking, Sw02_command => cmd_R14_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, B26_state => state_B26, B26_lock => B26_locking, B26_command => cmd_R14_B26, C21_state => state_C21, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), reset => reset, ne3_command => cmd_R15_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne5_command => cmd_R15_ne5, ne5_state => state_ne5, ne5_lock => ne5_locking, Sw02_command => cmd_R15_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, S27_state => state_S27, S27_lock => S27_locking, S27_command => cmd_R15_S27, S33_state => state_S33, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), reset => reset, ne3_command => cmd_R16_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne4_command => cmd_R16_ne4, ne4_state => state_ne4, ne4_lock => ne4_locking, Sw02_command => cmd_R16_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, S27_state => state_S27, S27_lock => S27_locking, S27_command => cmd_R16_S27, T01_state => state_T01, routeState => routes_o(15));
	route_R17 : route_16 port map(clock => clock, routeRequest => routes_i(16), reset => reset, ne1_command => cmd_R17_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne2_command => cmd_R17_ne2, ne2_state => state_ne2, ne2_lock => ne2_locking, ne7_command => cmd_R17_ne7, ne7_state => state_ne7, ne7_lock => ne7_locking, Sw01_command => cmd_R17_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, Sw03_command => cmd_R17_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, C29_state => state_C29, C29_lock => C29_locking, C29_command => cmd_R17_C29, J18_state => state_J18, routeState => routes_o(16));
	route_R18 : route_17 port map(clock => clock, routeRequest => routes_i(17), reset => reset, ne5_command => cmd_R18_ne5, ne5_state => state_ne5, ne5_lock => ne5_locking, ne10_command => cmd_R18_ne10, ne10_state => state_ne10, ne10_lock => ne10_locking, Sw05_command => cmd_R18_Sw05, Sw05_state => state_Sw05, Sw05_lock => Sw05_locking, S33_state => state_S33, S33_lock => S33_locking, S33_command => cmd_R18_S33, T05_state => state_T05, routeState => routes_o(17));
	route_R19 : route_18 port map(clock => clock, routeRequest => routes_i(18), reset => reset, ne5_command => cmd_R19_ne5, ne5_state => state_ne5, ne5_lock => ne5_locking, ne11_command => cmd_R19_ne11, ne11_state => state_ne11, ne11_lock => ne11_locking, Sw05_command => cmd_R19_Sw05, Sw05_state => state_Sw05, Sw05_lock => Sw05_locking, S33_state => state_S33, S33_lock => S33_locking, S33_command => cmd_R19_S33, J13_state => state_J13, routeState => routes_o(18));
	route_R20 : route_19 port map(clock => clock, routeRequest => routes_i(19), reset => reset, ne42_command => cmd_R20_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, B36_state => state_B36, B36_lock => B36_locking, B36_command => cmd_R20_B36, T09_state => state_T09, routeState => routes_o(19));
	route_R21 : route_20 port map(clock => clock, routeRequest => routes_i(20), reset => reset, ne7_command => cmd_R21_ne7, ne7_state => state_ne7, ne7_lock => ne7_locking, ne41_command => cmd_R21_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, Sw08_command => cmd_R21_Sw08, Sw08_state => state_Sw08, Sw08_lock => Sw08_locking, S37_state => state_S37, S37_lock => S37_locking, S37_command => cmd_R21_S37, J20_state => state_J20, routeState => routes_o(20));
	route_R22 : route_21 port map(clock => clock, routeRequest => routes_i(21), reset => reset, ne41_command => cmd_R22_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, ne42_command => cmd_R22_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, Sw08_command => cmd_R22_Sw08, Sw08_state => state_Sw08, Sw08_lock => Sw08_locking, S37_state => state_S37, S37_lock => S37_locking, S37_command => cmd_R22_S37, B36_state => state_B36, routeState => routes_o(21));
	processed <= processing;
end Behavioral;