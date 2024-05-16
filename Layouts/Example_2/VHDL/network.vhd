--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 45;
			N_SIGNALS : natural := 12;
			N_ROUTES : natural := 10;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 3;
			N_TRACKCIRCUITS : natural := 7
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
			levelCrossings_i : in std_logic;
			levelCrossings_o : out std_logic;
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
			ocupation_ne16 : in std_logic;
			ocupation_ne14 : in std_logic;
			ocupation_ne15 : in std_logic;
			ocupation_ne18 : in std_logic;
			ocupation_ne17 : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc01 : out levelCrossingStates;
			lock_Lc01 : out objectLock
		);
	end component levelCrossing_0;
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
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
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
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
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw03 : out singleSwitchStates;
			lock_Sw03 : out objectLock
		);
	end component singleSwitch_2;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne14 : in std_logic;
			correspondence_P09 : out signalStates;
			lock_P09 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne14 : in std_logic;
			correspondence_C13 : out signalStates;
			lock_C13 : out objectLock;
			--Ocupation level 1
			ocupation_ne16 : in std_logic;
			correspondence_S18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne20 : in std_logic;
			ocupation_ne17 : in std_logic;
			ocupation_ne18 : in std_logic;
			correspondence_P12 : in signalStates;
			correspondence_L06 : in signalStates;
			Sw02_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne15 : in std_logic;
			correspondence_L04 : out signalStates;
			lock_L04 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne15 : in std_logic;
			correspondence_B14 : out signalStates;
			lock_B14 : out objectLock;
			--Ocupation level 1
			ocupation_ne16 : in std_logic;
			correspondence_S18 : in signalStates;
			Sw01_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne20 : in std_logic;
			ocupation_ne17 : in std_logic;
			ocupation_ne18 : in std_logic;
			correspondence_P12 : in signalStates;
			correspondence_L06 : in signalStates;
			Sw02_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			Lc01_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne16 : in std_logic;
			correspondence_S15 : out signalStates;
			lock_S15 : out objectLock;
			--Ocupation level 1
			ocupation_ne14 : in std_logic;
			ocupation_ne15 : in std_logic;
			correspondence_P09 : in signalStates;
			correspondence_L04 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			Lc01_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne16 : in std_logic;
			correspondence_S18 : out signalStates;
			lock_S18 : out objectLock;
			--Ocupation level 1
			ocupation_ne18 : in std_logic;
			ocupation_ne17 : in std_logic;
			ocupation_ne20 : in std_logic;
			correspondence_P12 : in signalStates;
			correspondence_L06 : in signalStates;
			Sw02_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne18 : in std_logic;
			correspondence_P12 : out signalStates;
			lock_P12 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne18 : in std_logic;
			correspondence_C17 : out signalStates;
			lock_C17 : out objectLock;
			--Ocupation level 1
			ocupation_ne16 : in std_logic;
			correspondence_S15 : in signalStates;
			Sw02_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne14 : in std_logic;
			ocupation_ne15 : in std_logic;
			correspondence_P09 : in signalStates;
			correspondence_L04 : in signalStates;
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
			ocupation_ne19 : in std_logic;
			correspondence_T01 : out signalStates;
			lock_T01 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne19 : in std_logic;
			correspondence_T02 : out signalStates;
			lock_T02 : out objectLock;
			--Ocupation level 1
			ocupation_ne20 : in std_logic;
			correspondence_L06 : in signalStates;
			Sw03_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne20 : in std_logic;
			correspondence_L06 : out signalStates;
			lock_L06 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne20 : in std_logic;
			correspondence_S21 : out signalStates;
			lock_S21 : out objectLock;
			--Ocupation level 1
			ocupation_ne17 : in std_logic;
			ocupation_ne16 : in std_logic;
			ocupation_ne19 : in std_logic;
			correspondence_S15 : in signalStates;
			correspondence_T01 : in signalStates;
			Sw02_state : in singleSwitchStates;
			Sw03_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne14 : in std_logic;
			ocupation_ne15 : in std_logic;
			correspondence_P09 : in signalStates;
			correspondence_L04 : in signalStates;
			Sw01_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_11;
	component node_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
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
			R5_command : in routeCommands;
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
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
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
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_6;
	component route_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne19_state : in nodeStates;
			ne19_lock : in objectLock;
			ne19_command : out routeCommands;
			ne20_state : in nodeStates;
			ne20_lock : in objectLock;
			ne20_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			T02_state : in signalStates;
			T02_lock : in objectLock;
			T02_command : out routeCommands;
			L06_state : in signalStates;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_lock : in objectLock;
			ne14_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			C13_state : in signalStates;
			C13_lock : in objectLock;
			C13_command : out routeCommands;
			S18_state : in signalStates;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne15_state : in nodeStates;
			ne15_lock : in objectLock;
			ne15_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			B14_state : in signalStates;
			B14_lock : in objectLock;
			B14_command : out routeCommands;
			S18_state : in signalStates;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			ne14_state : in nodeStates;
			ne14_lock : in objectLock;
			ne14_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_lock : in objectLock;
			Lc01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			S15_state : in signalStates;
			S15_lock : in objectLock;
			S15_command : out routeCommands;
			P09_state : in signalStates;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			ne15_state : in nodeStates;
			ne15_lock : in objectLock;
			ne15_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_lock : in objectLock;
			Lc01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_lock : in objectLock;
			Sw01_command : out routeCommands;
			S15_state : in signalStates;
			S15_lock : in objectLock;
			S15_command : out routeCommands;
			L04_state : in signalStates;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne18_state : in nodeStates;
			ne18_lock : in objectLock;
			ne18_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			C17_state : in signalStates;
			C17_lock : in objectLock;
			C17_command : out routeCommands;
			S15_state : in signalStates;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			ne18_state : in nodeStates;
			ne18_lock : in objectLock;
			ne18_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_lock : in objectLock;
			Lc01_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			S18_state : in signalStates;
			S18_lock : in objectLock;
			S18_command : out routeCommands;
			P12_state : in signalStates;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_lock : in objectLock;
			ne17_command : out routeCommands;
			ne20_state : in nodeStates;
			ne20_lock : in objectLock;
			ne20_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_lock : in objectLock;
			Lc01_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			S18_state : in signalStates;
			S18_lock : in objectLock;
			S18_command : out routeCommands;
			L06_state : in signalStates;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne20_state : in nodeStates;
			ne20_lock : in objectLock;
			ne20_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_lock : in objectLock;
			ne17_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_lock : in objectLock;
			ne16_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_lock : in objectLock;
			Sw02_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			S21_state : in signalStates;
			S21_lock : in objectLock;
			S21_command : out routeCommands;
			S15_state : in signalStates;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne20_state : in nodeStates;
			ne20_lock : in objectLock;
			ne20_command : out routeCommands;
			ne19_state : in nodeStates;
			ne19_lock : in objectLock;
			ne19_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_lock : in objectLock;
			Sw03_command : out routeCommands;
			S21_state : in signalStates;
			S21_lock : in objectLock;
			S21_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_9;
	signal state_Lc01 : levelCrossingStates := DOWN;
	signal Lc01_locking : objectLock := RELEASED;
	signal state_Sw01 , state_Sw02 , state_Sw03 : singleSwitchStates := NORMAL;
	signal Sw01_locking , Sw02_locking , Sw03_locking : objectLock := RELEASED;
	signal state_P09 , state_C13 , state_L04 , state_B14 , state_S15 , state_S18 , state_P12 , state_C17 , state_T01 , state_T02 , state_L06 , state_S21 : signalStates := RED;
	signal P09_locking , C13_locking , L04_locking , B14_locking , S15_locking , S18_locking , P12_locking , C17_locking , T01_locking , T02_locking , L06_locking , S21_locking : objectLock := RELEASED;
	signal state_ne14 , state_ne15 , state_ne16 , state_ne17 , state_ne18 , state_ne19 , state_ne20 : nodeStates := FREE;
	signal ne14_locking , ne15_locking , ne16_locking , ne17_locking , ne18_locking , ne19_locking , ne20_locking : objectLock := RELEASED;
	signal cmd_R1_ne19 , cmd_R1_ne20 , cmd_R2_ne14 , cmd_R2_ne16 , cmd_R3_ne15 , cmd_R3_ne16 , cmd_R4_ne16 , cmd_R4_ne14 , cmd_R5_ne16 , cmd_R5_ne15 , cmd_R6_ne18 , cmd_R6_ne16 , cmd_R7_ne16 , cmd_R7_ne18 , cmd_R8_ne16 , cmd_R8_ne17 , cmd_R8_ne20 , cmd_R9_ne20 , cmd_R9_ne17 , cmd_R9_ne16 , cmd_R10_ne20 , cmd_R10_ne19 : routeCommands := RELEASE;
	signal cmd_R4_Lc01 , cmd_R5_Lc01 , cmd_R7_Lc01 , cmd_R8_Lc01 : routeCommands := RELEASE;
	signal cmd_R1_Sw03 , cmd_R2_Sw01 , cmd_R3_Sw01 , cmd_R4_Sw01 , cmd_R5_Sw01 , cmd_R6_Sw02 , cmd_R7_Sw02 , cmd_R8_Sw02 , cmd_R8_Sw03 , cmd_R9_Sw02 , cmd_R9_Sw03 , cmd_R10_Sw03 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_C13 , cmd_R3_B14 , cmd_R4_S15 , cmd_R5_S15 , cmd_R6_C17 , cmd_R7_S18 , cmd_R8_S18 , cmd_R9_S21 , cmd_R10_S21 : routeCommands := RELEASE;
begin
	levelCrossing_Lc01 : levelCrossing_0 port map(clock => clock, reset => reset, R4_command => cmd_R4_Lc01, R5_command => cmd_R5_Lc01, R7_command => cmd_R7_Lc01, R8_command => cmd_R8_Lc01, ocupation_ne16 => ocupation(2), ocupation_ne14 => ocupation(0), ocupation_ne15 => ocupation(1), ocupation_ne18 => ocupation(4), ocupation_ne17 => ocupation(3), indication => levelCrossings_i, command  => levelCrossings_o, lock_Lc01 => Lc01_locking, correspondence_Lc01 => state_Lc01);
	singleSwitch_Sw01 : singleSwitch_0 port map(clock => clock, reset => reset, R2_command => cmd_R2_Sw01, R3_command => cmd_R3_Sw01, R4_command => cmd_R4_Sw01, R5_command => cmd_R5_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), lock_Sw01 => Sw01_locking, correspondence_Sw01 => state_Sw01);
	singleSwitch_Sw02 : singleSwitch_1 port map(clock => clock, reset => reset, R6_command => cmd_R6_Sw02, R7_command => cmd_R7_Sw02, R8_command => cmd_R8_Sw02, R9_command => cmd_R9_Sw02, indication => singleSwitches_i(1), command => singleSwitches_o(1), lock_Sw02 => Sw02_locking, correspondence_Sw02 => state_Sw02);
	singleSwitch_Sw03 : singleSwitch_2 port map(clock => clock, reset => reset, R1_command => cmd_R1_Sw03, R8_command => cmd_R8_Sw03, R9_command => cmd_R9_Sw03, R10_command => cmd_R10_Sw03, indication => singleSwitches_i(2), command => singleSwitches_o(2), lock_Sw03 => Sw03_locking, correspondence_Sw03 => state_Sw03);
	railwaySignal_P09 : railwaySignal_0 port map(clock => clock, reset => reset, ocupation_ne14 => ocupation(0), indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command.msb => signals_o.msb(0), command.lsb => signals_o.lsb(0), lock_P09 => P09_locking, correspondence_P09 => state_P09);
	railwaySignal_C13 : railwaySignal_1 port map(clock => clock, reset => reset, R2_command => cmd_R2_C13, ocupation_ne14 => ocupation(0), ocupation_ne16 => ocupation(2), ocupation_ne20 => ocupation(6), ocupation_ne17 => ocupation(3), ocupation_ne18 => ocupation(4), correspondence_S18 => state_S18, correspondence_P12 => state_P12, correspondence_L06 => state_L06, Sw01_state => state_Sw01, Sw02_state => state_Sw02, Sw03_state => state_Sw03, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command.msb => signals_o.msb(1), command.lsb => signals_o.lsb(1), lock_C13 => C13_locking, correspondence_C13 => state_C13);
	railwaySignal_L04 : railwaySignal_2 port map(clock => clock, reset => reset, ocupation_ne15 => ocupation(1), indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command.msb => signals_o.msb(2), command.lsb => signals_o.lsb(2), lock_L04 => L04_locking, correspondence_L04 => state_L04);
	railwaySignal_B14 : railwaySignal_3 port map(clock => clock, reset => reset, R3_command => cmd_R3_B14, ocupation_ne15 => ocupation(1), ocupation_ne16 => ocupation(2), ocupation_ne20 => ocupation(6), ocupation_ne17 => ocupation(3), ocupation_ne18 => ocupation(4), correspondence_S18 => state_S18, correspondence_P12 => state_P12, correspondence_L06 => state_L06, Sw01_state => state_Sw01, Sw02_state => state_Sw02, Sw03_state => state_Sw03, indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command.msb => signals_o.msb(3), command.lsb => signals_o.lsb(3), lock_B14 => B14_locking, correspondence_B14 => state_B14);
	railwaySignal_S15 : railwaySignal_4 port map(clock => clock, reset => reset, R4_command => cmd_R4_S15, R5_command => cmd_R5_S15, ocupation_ne16 => ocupation(2), ocupation_ne14 => ocupation(0), ocupation_ne15 => ocupation(1), correspondence_P09 => state_P09, correspondence_L04 => state_L04, Sw01_state => state_Sw01, Lc01_state => state_Lc01, indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command.msb => signals_o.msb(4), command.lsb => signals_o.lsb(4), lock_S15 => S15_locking, correspondence_S15 => state_S15);
	railwaySignal_S18 : railwaySignal_5 port map(clock => clock, reset => reset, R7_command => cmd_R7_S18, R8_command => cmd_R8_S18, ocupation_ne16 => ocupation(2), ocupation_ne18 => ocupation(4), ocupation_ne17 => ocupation(3), ocupation_ne20 => ocupation(6), correspondence_P12 => state_P12, correspondence_L06 => state_L06, Sw02_state => state_Sw02, Sw03_state => state_Sw03, Lc01_state => state_Lc01, indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command.msb => signals_o.msb(5), command.lsb => signals_o.lsb(5), lock_S18 => S18_locking, correspondence_S18 => state_S18);
	railwaySignal_P12 : railwaySignal_6 port map(clock => clock, reset => reset, ocupation_ne18 => ocupation(4), indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command.msb => signals_o.msb(6), command.lsb => signals_o.lsb(6), lock_P12 => P12_locking, correspondence_P12 => state_P12);
	railwaySignal_C17 : railwaySignal_7 port map(clock => clock, reset => reset, R6_command => cmd_R6_C17, ocupation_ne18 => ocupation(4), ocupation_ne16 => ocupation(2), ocupation_ne14 => ocupation(0), ocupation_ne15 => ocupation(1), correspondence_S15 => state_S15, correspondence_P09 => state_P09, correspondence_L04 => state_L04, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command.msb => signals_o.msb(7), command.lsb => signals_o.lsb(7), lock_C17 => C17_locking, correspondence_C17 => state_C17);
	railwaySignal_T01 : railwaySignal_8 port map(clock => clock, reset => reset, ocupation_ne19 => ocupation(5), indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command.msb => signals_o.msb(8), command.lsb => signals_o.lsb(8), lock_T01 => T01_locking, correspondence_T01 => state_T01);
	railwaySignal_T02 : railwaySignal_9 port map(clock => clock, reset => reset, R1_command => cmd_R1_T02, ocupation_ne19 => ocupation(5), ocupation_ne20 => ocupation(6), correspondence_L06 => state_L06, Sw03_state => state_Sw03, indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command.msb => signals_o.msb(9), command.lsb => signals_o.lsb(9), lock_T02 => T02_locking, correspondence_T02 => state_T02);
	railwaySignal_L06 : railwaySignal_10 port map(clock => clock, reset => reset, ocupation_ne20 => ocupation(6), indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command.msb => signals_o.msb(10), command.lsb => signals_o.lsb(10), lock_L06 => L06_locking, correspondence_L06 => state_L06);
	railwaySignal_S21 : railwaySignal_11 port map(clock => clock, reset => reset, R9_command => cmd_R9_S21, R10_command => cmd_R10_S21, ocupation_ne20 => ocupation(6), ocupation_ne17 => ocupation(3), ocupation_ne16 => ocupation(2), ocupation_ne19 => ocupation(5), ocupation_ne14 => ocupation(0), ocupation_ne15 => ocupation(1), correspondence_S15 => state_S15, correspondence_T01 => state_T01, correspondence_P09 => state_P09, correspondence_L04 => state_L04, Sw02_state => state_Sw02, Sw03_state => state_Sw03, Sw01_state => state_Sw01, indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command.msb => signals_o.msb(11), command.lsb => signals_o.lsb(11), lock_S21 => S21_locking, correspondence_S21 => state_S21);
	node_ne14 : node_0 port map(clock => clock, ocupation => ocupation(0), reset => reset, R2_command => cmd_R2_ne14, R4_command => cmd_R4_ne14, state => state_ne14, locking => ne14_locking);
	node_ne15 : node_1 port map(clock => clock, ocupation => ocupation(1), reset => reset, R3_command => cmd_R3_ne15, R5_command => cmd_R5_ne15, state => state_ne15, locking => ne15_locking);
	node_ne16 : node_2 port map(clock => clock, ocupation => ocupation(2), reset => reset, R2_command => cmd_R2_ne16, R3_command => cmd_R3_ne16, R4_command => cmd_R4_ne16, R5_command => cmd_R5_ne16, R6_command => cmd_R6_ne16, R7_command => cmd_R7_ne16, R8_command => cmd_R8_ne16, R9_command => cmd_R9_ne16, state => state_ne16, locking => ne16_locking);
	node_ne17 : node_3 port map(clock => clock, ocupation => ocupation(3), reset => reset, R8_command => cmd_R8_ne17, R9_command => cmd_R9_ne17, state => state_ne17, locking => ne17_locking);
	node_ne18 : node_4 port map(clock => clock, ocupation => ocupation(4), reset => reset, R6_command => cmd_R6_ne18, R7_command => cmd_R7_ne18, state => state_ne18, locking => ne18_locking);
	node_ne19 : node_5 port map(clock => clock, ocupation => ocupation(5), reset => reset, R1_command => cmd_R1_ne19, R10_command => cmd_R10_ne19, state => state_ne19, locking => ne19_locking);
	node_ne20 : node_6 port map(clock => clock, ocupation => ocupation(6), reset => reset, R1_command => cmd_R1_ne20, R8_command => cmd_R8_ne20, R9_command => cmd_R9_ne20, R10_command => cmd_R10_ne20, state => state_ne20, locking => ne20_locking);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), reset => reset, ne19_command => cmd_R1_ne19, ne19_state => state_ne19, ne19_lock => ne19_locking, ne20_command => cmd_R1_ne20, ne20_state => state_ne20, ne20_lock => ne20_locking, Sw03_command => cmd_R1_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, T02_state => state_T02, T02_lock => T02_locking, T02_command => cmd_R1_T02, L06_state => state_L06, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), reset => reset, ne14_command => cmd_R2_ne14, ne14_state => state_ne14, ne14_lock => ne14_locking, ne16_command => cmd_R2_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, C13_state => state_C13, C13_lock => C13_locking, C13_command => cmd_R2_C13, S18_state => state_S18, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), reset => reset, ne15_command => cmd_R3_ne15, ne15_state => state_ne15, ne15_lock => ne15_locking, ne16_command => cmd_R3_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, Sw01_command => cmd_R3_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, B14_state => state_B14, B14_lock => B14_locking, B14_command => cmd_R3_B14, S18_state => state_S18, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), reset => reset, ne14_command => cmd_R4_ne14, ne14_state => state_ne14, ne14_lock => ne14_locking, ne16_command => cmd_R4_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, Lc01_command => cmd_R4_Lc01, Lc01_state => state_Lc01, Lc01_lock => Lc01_locking, Sw01_command => cmd_R4_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, S15_state => state_S15, S15_lock => S15_locking, S15_command => cmd_R4_S15, P09_state => state_P09, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), reset => reset, ne15_command => cmd_R5_ne15, ne15_state => state_ne15, ne15_lock => ne15_locking, ne16_command => cmd_R5_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, Lc01_command => cmd_R5_Lc01, Lc01_state => state_Lc01, Lc01_lock => Lc01_locking, Sw01_command => cmd_R5_Sw01, Sw01_state => state_Sw01, Sw01_lock => Sw01_locking, S15_state => state_S15, S15_lock => S15_locking, S15_command => cmd_R5_S15, L04_state => state_L04, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), reset => reset, ne16_command => cmd_R6_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, ne18_command => cmd_R6_ne18, ne18_state => state_ne18, ne18_lock => ne18_locking, Sw02_command => cmd_R6_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, C17_state => state_C17, C17_lock => C17_locking, C17_command => cmd_R6_C17, S15_state => state_S15, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), reset => reset, ne16_command => cmd_R7_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, ne18_command => cmd_R7_ne18, ne18_state => state_ne18, ne18_lock => ne18_locking, Lc01_command => cmd_R7_Lc01, Lc01_state => state_Lc01, Lc01_lock => Lc01_locking, Sw02_command => cmd_R7_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, S18_state => state_S18, S18_lock => S18_locking, S18_command => cmd_R7_S18, P12_state => state_P12, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), reset => reset, ne16_command => cmd_R8_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, ne17_command => cmd_R8_ne17, ne17_state => state_ne17, ne17_lock => ne17_locking, ne20_command => cmd_R8_ne20, ne20_state => state_ne20, ne20_lock => ne20_locking, Lc01_command => cmd_R8_Lc01, Lc01_state => state_Lc01, Lc01_lock => Lc01_locking, Sw02_command => cmd_R8_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, Sw03_command => cmd_R8_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, S18_state => state_S18, S18_lock => S18_locking, S18_command => cmd_R8_S18, L06_state => state_L06, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), reset => reset, ne16_command => cmd_R9_ne16, ne16_state => state_ne16, ne16_lock => ne16_locking, ne17_command => cmd_R9_ne17, ne17_state => state_ne17, ne17_lock => ne17_locking, ne20_command => cmd_R9_ne20, ne20_state => state_ne20, ne20_lock => ne20_locking, Sw02_command => cmd_R9_Sw02, Sw02_state => state_Sw02, Sw02_lock => Sw02_locking, Sw03_command => cmd_R9_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, S21_state => state_S21, S21_lock => S21_locking, S21_command => cmd_R9_S21, S15_state => state_S15, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), reset => reset, ne19_command => cmd_R10_ne19, ne19_state => state_ne19, ne19_lock => ne19_locking, ne20_command => cmd_R10_ne20, ne20_state => state_ne20, ne20_lock => ne20_locking, Sw03_command => cmd_R10_Sw03, Sw03_state => state_Sw03, Sw03_lock => Sw03_locking, S21_state => state_S21, S21_lock => S21_locking, S21_command => cmd_R10_S21, T01_state => state_T01, routeState => routes_o(9));
	processed <= processing;
end Behavioral;