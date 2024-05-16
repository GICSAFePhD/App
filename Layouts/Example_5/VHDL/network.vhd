--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 60;
			N_SIGNALS : natural := 16;
			N_ROUTES : natural := 16;
			N_SINGLESWITCHES : natural := 4;
			N_TRACKCIRCUITS : natural := 8
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
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
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
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw02 : out singleSwitchStates;
			lock_Sw02 : out objectLock
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw03 : out singleSwitchStates;
			lock_Sw03 : out objectLock
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw04 : out singleSwitchStates;
			lock_Sw04 : out objectLock
		);
	end component singleSwitch_3;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne01 : in std_logic;
			correspondence_T01 : out signalStates;
			lock_T01 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne01 : in std_logic;
			correspondence_T02 : out signalStates;
			lock_T02 : out objectLock;
			--Ocupation level 1
			ocupation_ne02 : in std_logic;
			ocupation_ne03 : in std_logic;
			correspondence_C25 : in signalStates;
			correspondence_B26 : in signalStates;
			Sw01_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne04 : in std_logic;
			correspondence_T03 : in signalStates;
			Sw02_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne02 : in std_logic;
			correspondence_C21 : out signalStates;
			lock_C21 : out objectLock;
			--Ocupation level 1
			ocupation_ne01 : in std_logic;
			correspondence_T01 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne02 : in std_logic;
			correspondence_C25 : out signalStates;
			lock_C25 : out objectLock;
			--Ocupation level 1
			ocupation_ne04 : in std_logic;
			correspondence_T03 : in signalStates;
			Sw02_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne03 : in std_logic;
			correspondence_B22 : out signalStates;
			lock_B22 : out objectLock;
			--Ocupation level 1
			ocupation_ne01 : in std_logic;
			correspondence_T01 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R12_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne03 : in std_logic;
			correspondence_B26 : out signalStates;
			lock_B26 : out objectLock;
			--Ocupation level 1
			ocupation_ne04 : in std_logic;
			correspondence_T03 : in signalStates;
			Sw02_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne04 : in std_logic;
			correspondence_T03 : out signalStates;
			lock_T03 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne04 : in std_logic;
			correspondence_T04 : out signalStates;
			lock_T04 : out objectLock;
			--Ocupation level 1
			ocupation_ne02 : in std_logic;
			ocupation_ne03 : in std_logic;
			correspondence_C21 : in signalStates;
			correspondence_B22 : in signalStates;
			Sw02_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne01 : in std_logic;
			correspondence_T01 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne05 : in std_logic;
			correspondence_T05 : out signalStates;
			lock_T05 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne05 : in std_logic;
			correspondence_T06 : out signalStates;
			lock_T06 : out objectLock;
			--Ocupation level 1
			ocupation_ne06 : in std_logic;
			ocupation_ne07 : in std_logic;
			correspondence_C33 : in signalStates;
			correspondence_B34 : in signalStates;
			Sw03_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne08 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R13_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne06 : in std_logic;
			correspondence_C29 : out signalStates;
			lock_C29 : out objectLock;
			--Ocupation level 1
			ocupation_ne05 : in std_logic;
			correspondence_T05 : in signalStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne06 : in std_logic;
			correspondence_C33 : out signalStates;
			lock_C33 : out objectLock;
			--Ocupation level 1
			ocupation_ne08 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne07 : in std_logic;
			correspondence_B30 : out signalStates;
			lock_B30 : out objectLock;
			--Ocupation level 1
			ocupation_ne05 : in std_logic;
			correspondence_T05 : in signalStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R16_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne07 : in std_logic;
			correspondence_B34 : out signalStates;
			lock_B34 : out objectLock;
			--Ocupation level 1
			ocupation_ne08 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw04_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne08 : in std_logic;
			correspondence_T07 : out signalStates;
			lock_T07 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne08 : in std_logic;
			correspondence_T08 : out signalStates;
			lock_T08 : out objectLock;
			--Ocupation level 1
			ocupation_ne06 : in std_logic;
			ocupation_ne07 : in std_logic;
			correspondence_C29 : in signalStates;
			correspondence_B30 : in signalStates;
			Sw04_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne05 : in std_logic;
			correspondence_T05 : in signalStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_15;
	component node_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R3_command : in routeCommands;
			R9_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
			R10_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
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
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R7_command : in routeCommands;
			R13_command : in routeCommands;
			R15_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R8_command : in routeCommands;
			R14_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_6;
	component node_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_7;
	component route_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne01_state : in nodeStates;
			ne01_lock : in objectLock;
			ne01_command : out routeCommands;
			ne02_state : in nodeStates;
			ne02_lock : in objectLock;
			ne02_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			T02_state : in signalStates;
			T02_lock : in objectLock;
			T02_command : out routeCommands;
			C25_state : in signalStates;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne01_state : in nodeStates;
			ne01_lock : in objectLock;
			ne01_command : out routeCommands;
			ne03_state : in nodeStates;
			ne03_lock : in objectLock;
			ne03_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			T02_state : in signalStates;
			T02_lock : in objectLock;
			T02_command : out routeCommands;
			B26_state : in signalStates;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne04_state : in nodeStates;
			ne04_lock : in objectLock;
			ne04_command : out routeCommands;
			ne02_state : in nodeStates;
			ne02_lock : in objectLock;
			ne02_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			T04_state : in signalStates;
			T04_lock : in objectLock;
			T04_command : out routeCommands;
			C21_state : in signalStates;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne04_state : in nodeStates;
			ne04_lock : in objectLock;
			ne04_command : out routeCommands;
			ne03_state : in nodeStates;
			ne03_lock : in objectLock;
			ne03_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			T04_state : in signalStates;
			T04_lock : in objectLock;
			T04_command : out routeCommands;
			B22_state : in signalStates;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne05_state : in nodeStates;
			ne05_lock : in objectLock;
			ne05_command : out routeCommands;
			ne06_state : in nodeStates;
			ne06_lock : in objectLock;
			ne06_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			T06_state : in signalStates;
			T06_lock : in objectLock;
			T06_command : out routeCommands;
			C33_state : in signalStates;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne05_state : in nodeStates;
			ne05_lock : in objectLock;
			ne05_command : out routeCommands;
			ne07_state : in nodeStates;
			ne07_lock : in objectLock;
			ne07_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			T06_state : in signalStates;
			T06_lock : in objectLock;
			T06_command : out routeCommands;
			B34_state : in signalStates;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne08_state : in nodeStates;
			ne08_lock : in objectLock;
			ne08_command : out routeCommands;
			ne06_state : in nodeStates;
			ne06_lock : in objectLock;
			ne06_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			T08_state : in signalStates;
			T08_lock : in objectLock;
			T08_command : out routeCommands;
			C29_state : in signalStates;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne08_state : in nodeStates;
			ne08_lock : in objectLock;
			ne08_command : out routeCommands;
			ne07_state : in nodeStates;
			ne07_lock : in objectLock;
			ne07_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			T08_state : in signalStates;
			T08_lock : in objectLock;
			T08_command : out routeCommands;
			B30_state : in signalStates;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne02_state : in nodeStates;
			ne02_lock : in objectLock;
			ne02_command : out routeCommands;
			ne01_state : in nodeStates;
			ne01_lock : in objectLock;
			ne01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			C21_state : in signalStates;
			C21_lock : in objectLock;
			C21_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne03_state : in nodeStates;
			ne03_lock : in objectLock;
			ne03_command : out routeCommands;
			ne01_state : in nodeStates;
			ne01_lock : in objectLock;
			ne01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			B22_state : in signalStates;
			B22_lock : in objectLock;
			B22_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne02_state : in nodeStates;
			ne02_lock : in objectLock;
			ne02_command : out routeCommands;
			ne04_state : in nodeStates;
			ne04_lock : in objectLock;
			ne04_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			C25_state : in signalStates;
			C25_lock : in objectLock;
			C25_command : out routeCommands;
			T03_state : in signalStates;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne03_state : in nodeStates;
			ne03_lock : in objectLock;
			ne03_command : out routeCommands;
			ne04_state : in nodeStates;
			ne04_lock : in objectLock;
			ne04_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			B26_state : in signalStates;
			B26_lock : in objectLock;
			B26_command : out routeCommands;
			T03_state : in signalStates;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne06_state : in nodeStates;
			ne06_lock : in objectLock;
			ne06_command : out routeCommands;
			ne05_state : in nodeStates;
			ne05_lock : in objectLock;
			ne05_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			C29_state : in signalStates;
			C29_lock : in objectLock;
			C29_command : out routeCommands;
			T05_state : in signalStates;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne07_state : in nodeStates;
			ne07_lock : in objectLock;
			ne07_command : out routeCommands;
			ne05_state : in nodeStates;
			ne05_lock : in objectLock;
			ne05_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			B30_state : in signalStates;
			B30_lock : in objectLock;
			B30_command : out routeCommands;
			T05_state : in signalStates;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne06_state : in nodeStates;
			ne06_lock : in objectLock;
			ne06_command : out routeCommands;
			ne08_state : in nodeStates;
			ne08_lock : in objectLock;
			ne08_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			C33_state : in signalStates;
			C33_lock : in objectLock;
			C33_command : out routeCommands;
			T07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne07_state : in nodeStates;
			ne07_lock : in objectLock;
			ne07_command : out routeCommands;
			ne08_state : in nodeStates;
			ne08_lock : in objectLock;
			ne08_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_lock : in objectLock;
			Sw04_command : out routeCommands;
			B34_state : in signalStates;
			B34_lock : in objectLock;
			B34_command : out routeCommands;
			T07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_15;
	signal state_Sw01 , state_Sw02 , state_Sw03 , state_Sw04 : singleSwitchStates;
	signal Sw01_locking , Sw02_locking , Sw03_locking , Sw04_locking : objectLock;
	signal state_T01 , state_T02 , state_C21 , state_C25 , state_B22 , state_B26 , state_T03 , state_T04 , state_T05 , state_T06 , state_C29 , state_C33 , state_B30 , state_B34 , state_T07 , state_T08 : signalStates;
	signal T01_locking , T02_locking , C21_locking , C25_locking , B22_locking , B26_locking , T03_locking , T04_locking , T05_locking , T06_locking , C29_locking , C33_locking , B30_locking , B34_locking , T07_locking , T08_locking : objectLock;
	signal state_ne01 , state_ne02 , state_ne03 , state_ne04 , state_ne05 , state_ne06 , state_ne07 , state_ne08 : nodeStates;
	signal ne01_locking , ne02_locking , ne03_locking , ne04_locking , ne05_locking , ne06_locking , ne07_locking , ne08_locking : objectLock;
	signal cmd_R1_ne01 , cmd_R1_ne02 , cmd_R2_ne01 , cmd_R2_ne03 , cmd_R3_ne04 , cmd_R3_ne02 , cmd_R4_ne04 , cmd_R4_ne03 , cmd_R5_ne05 , cmd_R5_ne06 , cmd_R6_ne05 , cmd_R6_ne07 , cmd_R7_ne08 , cmd_R7_ne06 , cmd_R8_ne08 , cmd_R8_ne07 , cmd_R9_ne02 , cmd_R9_ne01 , cmd_R10_ne03 , cmd_R10_ne01 , cmd_R11_ne02 , cmd_R11_ne04 , cmd_R12_ne03 , cmd_R12_ne04 , cmd_R13_ne06 , cmd_R13_ne05 , cmd_R14_ne07 , cmd_R14_ne05 , cmd_R15_ne06 , cmd_R15_ne08 , cmd_R16_ne07 , cmd_R16_ne08 : routeCommands;
	signal cmd_R1_Sw01 , cmd_R2_Sw01 , cmd_R3_Sw02 , cmd_R4_Sw02 , cmd_R5_Sw03 , cmd_R6_Sw03 , cmd_R7_Sw04 , cmd_R8_Sw04 , cmd_R9_Sw01 , cmd_R10_Sw01 , cmd_R11_Sw02 , cmd_R12_Sw02 , cmd_R13_Sw03 , cmd_R14_Sw03 , cmd_R15_Sw04 , cmd_R16_Sw04 : routeCommands;
	signal cmd_R1_T02 , cmd_R2_T02 , cmd_R3_T04 , cmd_R4_T04 , cmd_R5_T06 , cmd_R6_T06 , cmd_R7_T08 , cmd_R8_T08 , cmd_R9_C21 , cmd_R10_B22 , cmd_R11_C25 , cmd_R12_B26 , cmd_R13_C29 , cmd_R14_B30 , cmd_R15_C33 , cmd_R16_B34 : routeCommands;
begin
	singleSwitch_Sw01 : singleSwitch_0 port map(clock => clock, reset => reset, R1_command => cmd_R1_Sw01, R2_command => cmd_R2_Sw01, R9_command => cmd_R9_Sw01, R10_command => cmd_R10_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), lock_Sw01 => Sw01_locking, correspondence_Sw01 => state_Sw01);
	singleSwitch_Sw02 : singleSwitch_1 port map(clock => clock, reset => reset, R3_command => cmd_R3_Sw02, R4_command => cmd_R4_Sw02, R11_command => cmd_R11_Sw02, R12_command => cmd_R12_Sw02, indication => singleSwitches_i(1), command => singleSwitches_o(1), lock_Sw02 => Sw02_locking, correspondence_Sw02 => state_Sw02);
	singleSwitch_Sw03 : singleSwitch_2 port map(clock => clock, reset => reset, R5_command => cmd_R5_Sw03, R6_command => cmd_R6_Sw03, R13_command => cmd_R13_Sw03, R14_command => cmd_R14_Sw03, indication => singleSwitches_i(2), command => singleSwitches_o(2), lock_Sw03 => Sw03_locking, correspondence_Sw03 => state_Sw03);
	singleSwitch_Sw04 : singleSwitch_3 port map(clock => clock, reset => reset, R7_command => cmd_R7_Sw04, R8_command => cmd_R8_Sw04, R15_command => cmd_R15_Sw04, R16_command => cmd_R16_Sw04, indication => singleSwitches_i(3), command => singleSwitches_o(3), lock_Sw04 => Sw04_locking, correspondence_Sw04 => state_Sw04);
	railwaySignal_T01 : railwaySignal_0 port map(clock => clock, reset => reset, ocupation_ne01 => ocupation(0), indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command.msb => signals_o.msb(0), command.lsb => signals_o.lsb(0), lock_T01 => T01_locking, correspondence_T01 => state_T01);
	railwaySignal_T02 : railwaySignal_1 port map(clock => clock, reset => reset, R1_command => cmd_R1_T02, R2_command => cmd_R2_T02, ocupation_ne01 => ocupation(0), ocupation_ne02 => ocupation(1), ocupation_ne03 => ocupation(2), ocupation_ne04 => ocupation(3), correspondence_C25 => state_C25, correspondence_B26 => state_B26, correspondence_T03 => state_T03, Sw01_state => state_Sw01, Sw02_state => state_Sw02, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command.msb => signals_o.msb(1), command.lsb => signals_o.lsb(1), lock_T02 => T02_locking, correspondence_T02 => state_T02);
	railwaySignal_C21 : railwaySignal_2 port map(clock => clock, reset => reset, R9_command => cmd_R9_C21, ocupation_ne02 => ocupation(1), ocupation_ne01 => ocupation(0), correspondence_T01 => state_T01, Sw01_state => state_Sw01, indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command.msb => signals_o.msb(2), command.lsb => signals_o.lsb(2), lock_C21 => C21_locking, correspondence_C21 => state_C21);
	railwaySignal_C25 : railwaySignal_3 port map(clock => clock, reset => reset, R11_command => cmd_R11_C25, ocupation_ne02 => ocupation(1), ocupation_ne04 => ocupation(3), correspondence_T03 => state_T03, Sw02_state => state_Sw02, indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command.msb => signals_o.msb(3), command.lsb => signals_o.lsb(3), lock_C25 => C25_locking, correspondence_C25 => state_C25);
	railwaySignal_B22 : railwaySignal_4 port map(clock => clock, reset => reset, R10_command => cmd_R10_B22, ocupation_ne03 => ocupation(2), ocupation_ne01 => ocupation(0), correspondence_T01 => state_T01, Sw01_state => state_Sw01, indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command.msb => signals_o.msb(4), command.lsb => signals_o.lsb(4), lock_B22 => B22_locking, correspondence_B22 => state_B22);
	railwaySignal_B26 : railwaySignal_5 port map(clock => clock, reset => reset, R12_command => cmd_R12_B26, ocupation_ne03 => ocupation(2), ocupation_ne04 => ocupation(3), correspondence_T03 => state_T03, Sw02_state => state_Sw02, indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command.msb => signals_o.msb(5), command.lsb => signals_o.lsb(5), lock_B26 => B26_locking, correspondence_B26 => state_B26);
	railwaySignal_T03 : railwaySignal_6 port map(clock => clock, reset => reset, ocupation_ne04 => ocupation(3), indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command.msb => signals_o.msb(6), command.lsb => signals_o.lsb(6), lock_T03 => T03_locking, correspondence_T03 => state_T03);
	railwaySignal_T04 : railwaySignal_7 port map(clock => clock, reset => reset, R3_command => cmd_R3_T04, R4_command => cmd_R4_T04, ocupation_ne04 => ocupation(3), ocupation_ne02 => ocupation(1), ocupation_ne03 => ocupation(2), ocupation_ne01 => ocupation(0), correspondence_C21 => state_C21, correspondence_B22 => state_B22, correspondence_T01 => state_T01, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command.msb => signals_o.msb(7), command.lsb => signals_o.lsb(7), lock_T04 => T04_locking, correspondence_T04 => state_T04);
	railwaySignal_T05 : railwaySignal_8 port map(clock => clock, reset => reset, ocupation_ne05 => ocupation(4), indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command.msb => signals_o.msb(8), command.lsb => signals_o.lsb(8), lock_T05 => T05_locking, correspondence_T05 => state_T05);
	railwaySignal_T06 : railwaySignal_9 port map(clock => clock, reset => reset, R5_command => cmd_R5_T06, R6_command => cmd_R6_T06, ocupation_ne05 => ocupation(4), ocupation_ne06 => ocupation(5), ocupation_ne07 => ocupation(6), ocupation_ne08 => ocupation(7), correspondence_C33 => state_C33, correspondence_B34 => state_B34, correspondence_T07 => state_T07, Sw03_state => state_Sw03, Sw04_state => state_Sw04, indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command.msb => signals_o.msb(9), command.lsb => signals_o.lsb(9), lock_T06 => T06_locking, correspondence_T06 => state_T06);
	railwaySignal_C29 : railwaySignal_10 port map(clock => clock, reset => reset, R13_command => cmd_R13_C29, ocupation_ne06 => ocupation(5), ocupation_ne05 => ocupation(4), correspondence_T05 => state_T05, Sw03_state => state_Sw03, indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command.msb => signals_o.msb(10), command.lsb => signals_o.lsb(10), lock_C29 => C29_locking, correspondence_C29 => state_C29);
	railwaySignal_C33 : railwaySignal_11 port map(clock => clock, reset => reset, R15_command => cmd_R15_C33, ocupation_ne06 => ocupation(5), ocupation_ne08 => ocupation(7), correspondence_T07 => state_T07, Sw04_state => state_Sw04, indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command.msb => signals_o.msb(11), command.lsb => signals_o.lsb(11), lock_C33 => C33_locking, correspondence_C33 => state_C33);
	railwaySignal_B30 : railwaySignal_12 port map(clock => clock, reset => reset, R14_command => cmd_R14_B30, ocupation_ne07 => ocupation(6), ocupation_ne05 => ocupation(4), correspondence_T05 => state_T05, Sw03_state => state_Sw03, indication.msb => signals_i.msb(12), indication.lsb => signals_i.lsb(12), command.msb => signals_o.msb(12), command.lsb => signals_o.lsb(12), lock_B30 => B30_locking, correspondence_B30 => state_B30);
	railwaySignal_B34 : railwaySignal_13 port map(clock => clock, reset => reset, R16_command => cmd_R16_B34, ocupation_ne07 => ocupation(6), ocupation_ne08 => ocupation(7), correspondence_T07 => state_T07, Sw04_state => state_Sw04, indication.msb => signals_i.msb(13), indication.lsb => signals_i.lsb(13), command.msb => signals_o.msb(13), command.lsb => signals_o.lsb(13), lock_B34 => B34_locking, correspondence_B34 => state_B34);
	railwaySignal_T07 : railwaySignal_14 port map(clock => clock, reset => reset, ocupation_ne08 => ocupation(7), indication.msb => signals_i.msb(14), indication.lsb => signals_i.lsb(14), command.msb => signals_o.msb(14), command.lsb => signals_o.lsb(14), lock_T07 => T07_locking, correspondence_T07 => state_T07);
	railwaySignal_T08 : railwaySignal_15 port map(clock => clock, reset => reset, R7_command => cmd_R7_T08, R8_command => cmd_R8_T08, ocupation_ne08 => ocupation(7), ocupation_ne06 => ocupation(5), ocupation_ne07 => ocupation(6), ocupation_ne05 => ocupation(4), correspondence_C29 => state_C29, correspondence_B30 => state_B30, correspondence_T05 => state_T05, Sw04_state => state_Sw04, Sw03_state => state_Sw03, indication.msb => signals_i.msb(15), indication.lsb => signals_i.lsb(15), command.msb => signals_o.msb(15), command.lsb => signals_o.lsb(15), lock_T08 => T08_locking, correspondence_T08 => state_T08);
	node_ne01 : node_0 port map(clock => clock, ocupation => ocupation(0), reset => reset, R1_command => cmd_R1_ne01, R2_command => cmd_R2_ne01, R9_command => cmd_R9_ne01, R10_command => cmd_R10_ne01, state => state_ne01, locking => ne01_locking);
	node_ne02 : node_1 port map(clock => clock, ocupation => ocupation(1), reset => reset, R1_command => cmd_R1_ne02, R3_command => cmd_R3_ne02, R9_command => cmd_R9_ne02, R11_command => cmd_R11_ne02, state => state_ne02, locking => ne02_locking);
	node_ne03 : node_2 port map(clock => clock, ocupation => ocupation(2), reset => reset, R2_command => cmd_R2_ne03, R4_command => cmd_R4_ne03, R10_command => cmd_R10_ne03, R12_command => cmd_R12_ne03, state => state_ne03, locking => ne03_locking);
	node_ne04 : node_3 port map(clock => clock, ocupation => ocupation(3), reset => reset, R3_command => cmd_R3_ne04, R4_command => cmd_R4_ne04, R11_command => cmd_R11_ne04, R12_command => cmd_R12_ne04, state => state_ne04, locking => ne04_locking);
	node_ne05 : node_4 port map(clock => clock, ocupation => ocupation(4), reset => reset, R5_command => cmd_R5_ne05, R6_command => cmd_R6_ne05, R13_command => cmd_R13_ne05, R14_command => cmd_R14_ne05, state => state_ne05, locking => ne05_locking);
	node_ne06 : node_5 port map(clock => clock, ocupation => ocupation(5), reset => reset, R5_command => cmd_R5_ne06, R7_command => cmd_R7_ne06, R13_command => cmd_R13_ne06, R15_command => cmd_R15_ne06, state => state_ne06, locking => ne06_locking);
	node_ne07 : node_6 port map(clock => clock, ocupation => ocupation(6), reset => reset, R6_command => cmd_R6_ne07, R8_command => cmd_R8_ne07, R14_command => cmd_R14_ne07, R16_command => cmd_R16_ne07, state => state_ne07, locking => ne07_locking);
	node_ne08 : node_7 port map(clock => clock, ocupation => ocupation(7), reset => reset, R7_command => cmd_R7_ne08, R8_command => cmd_R8_ne08, R15_command => cmd_R15_ne08, R16_command => cmd_R16_ne08, state => state_ne08, locking => ne08_locking);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), reset => reset, ne01_command => cmd_R1_ne01, ne01_state => state_ne01, ne01_lock => ne01_locking, ne02_command => cmd_R1_ne02, ne02_state => state_ne02, ne02_lock => ne02_locking, Sw01_command => cmd_R1_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, T02_state => state_T02, T02_lock => T02_locking, T02_command => cmd_R1_T02, C25_state => state_C25, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), reset => reset, ne01_command => cmd_R2_ne01, ne01_state => state_ne01, ne01_lock => ne01_locking, ne03_command => cmd_R2_ne03, ne03_state => state_ne03, ne03_lock => ne03_locking, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, T02_state => state_T02, T02_lock => T02_locking, T02_command => cmd_R2_T02, B26_state => state_B26, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), reset => reset, ne02_command => cmd_R3_ne02, ne02_state => state_ne02, ne02_lock => ne02_locking, ne04_command => cmd_R3_ne04, ne04_state => state_ne04, ne04_lock => ne04_locking, Sw02_command => cmd_R3_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, T04_state => state_T04, T04_lock => T04_locking, T04_command => cmd_R3_T04, C21_state => state_C21, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), reset => reset, ne03_command => cmd_R4_ne03, ne03_state => state_ne03, ne03_lock => ne03_locking, ne04_command => cmd_R4_ne04, ne04_state => state_ne04, ne04_lock => ne04_locking, Sw02_command => cmd_R4_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, T04_state => state_T04, T04_lock => T04_locking, T04_command => cmd_R4_T04, B22_state => state_B22, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), reset => reset, ne05_command => cmd_R5_ne05, ne05_state => state_ne05, ne05_lock => ne05_locking, ne06_command => cmd_R5_ne06, ne06_state => state_ne06, ne06_lock => ne06_locking, Sw03_command => cmd_R5_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, T06_state => state_T06, T06_lock => T06_locking, T06_command => cmd_R5_T06, C33_state => state_C33, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), reset => reset, ne05_command => cmd_R6_ne05, ne05_state => state_ne05, ne05_lock => ne05_locking, ne07_command => cmd_R6_ne07, ne07_state => state_ne07, ne07_lock => ne07_locking, Sw03_command => cmd_R6_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, T06_state => state_T06, T06_lock => T06_locking, T06_command => cmd_R6_T06, B34_state => state_B34, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), reset => reset, ne06_command => cmd_R7_ne06, ne06_state => state_ne06, ne06_lock => ne06_locking, ne08_command => cmd_R7_ne08, ne08_state => state_ne08, ne08_lock => ne08_locking, Sw04_command => cmd_R7_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, T08_state => state_T08, T08_lock => T08_locking, T08_command => cmd_R7_T08, C29_state => state_C29, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), reset => reset, ne07_command => cmd_R8_ne07, ne07_state => state_ne07, ne07_lock => ne07_locking, ne08_command => cmd_R8_ne08, ne08_state => state_ne08, ne08_lock => ne08_locking, Sw04_command => cmd_R8_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, T08_state => state_T08, T08_lock => T08_locking, T08_command => cmd_R8_T08, B30_state => state_B30, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), reset => reset, ne01_command => cmd_R9_ne01, ne01_state => state_ne01, ne01_lock => ne01_locking, ne02_command => cmd_R9_ne02, ne02_state => state_ne02, ne02_lock => ne02_locking, Sw01_command => cmd_R9_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, C21_state => state_C21, C21_lock => C21_locking, C21_command => cmd_R9_C21, T01_state => state_T01, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), reset => reset, ne01_command => cmd_R10_ne01, ne01_state => state_ne01, ne01_lock => ne01_locking, ne03_command => cmd_R10_ne03, ne03_state => state_ne03, ne03_lock => ne03_locking, Sw01_command => cmd_R10_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, B22_state => state_B22, B22_lock => B22_locking, B22_command => cmd_R10_B22, T01_state => state_T01, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), reset => reset, ne02_command => cmd_R11_ne02, ne02_state => state_ne02, ne02_lock => ne02_locking, ne04_command => cmd_R11_ne04, ne04_state => state_ne04, ne04_lock => ne04_locking, Sw02_command => cmd_R11_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, C25_state => state_C25, C25_lock => C25_locking, C25_command => cmd_R11_C25, T03_state => state_T03, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), reset => reset, ne03_command => cmd_R12_ne03, ne03_state => state_ne03, ne03_lock => ne03_locking, ne04_command => cmd_R12_ne04, ne04_state => state_ne04, ne04_lock => ne04_locking, Sw02_command => cmd_R12_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, B26_state => state_B26, B26_lock => B26_locking, B26_command => cmd_R12_B26, T03_state => state_T03, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), reset => reset, ne05_command => cmd_R13_ne05, ne05_state => state_ne05, ne05_lock => ne05_locking, ne06_command => cmd_R13_ne06, ne06_state => state_ne06, ne06_lock => ne06_locking, Sw03_command => cmd_R13_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, C29_state => state_C29, C29_lock => C29_locking, C29_command => cmd_R13_C29, T05_state => state_T05, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), reset => reset, ne05_command => cmd_R14_ne05, ne05_state => state_ne05, ne05_lock => ne05_locking, ne07_command => cmd_R14_ne07, ne07_state => state_ne07, ne07_lock => ne07_locking, Sw03_command => cmd_R14_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, B30_state => state_B30, B30_lock => B30_locking, B30_command => cmd_R14_B30, T05_state => state_T05, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), reset => reset, ne06_command => cmd_R15_ne06, ne06_state => state_ne06, ne06_lock => ne06_locking, ne08_command => cmd_R15_ne08, ne08_state => state_ne08, ne08_lock => ne08_locking, Sw04_command => cmd_R15_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, C33_state => state_C33, C33_lock => C33_locking, C33_command => cmd_R15_C33, T07_state => state_T07, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), reset => reset, ne07_command => cmd_R16_ne07, ne07_state => state_ne07, ne07_lock => ne07_locking, ne08_command => cmd_R16_ne08, ne08_state => state_ne08, ne08_lock => ne08_locking, Sw04_command => cmd_R16_Sw04, Sw04_state => state_Sw04, Sw04_lock => Sw04_locking, B34_state => state_B34, B34_lock => B34_locking, B34_command => cmd_R16_B34, T07_state => state_T07, routeState => routes_o(15));
	processed <= processing;
end Behavioral;