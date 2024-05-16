--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 47;
			N_SIGNALS : natural := 13;
			N_ROUTES : natural := 11;
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
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw18 : out singleSwitchStates;
			lock_Sw18 : out objectLock
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw14 : out singleSwitchStates;
			lock_Sw14 : out objectLock
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw19 : out singleSwitchStates;
			lock_Sw19 : out objectLock
		);
	end component singleSwitch_2;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
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
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
			correspondence_T02 : out signalStates;
			lock_T02 : out objectLock;
			correspondence_S14 : in signalStates;
			--Ocupation level 2
			ocupation_ne32 : in std_logic;
			ocupation_ne31 : in std_logic;
			ocupation_ne40 : in std_logic;
			ocupation_ne41 : in std_logic;
			correspondence_B18 : in signalStates;
			correspondence_T03 : in signalStates;
			correspondence_T05 : in signalStates;
			Sw18_state : in singleSwitchStates;
			Sw14_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne1 : in std_logic;
			correspondence_S14 : out signalStates;
			lock_S14 : out objectLock;
			--Ocupation level 1
			ocupation_ne41 : in std_logic;
			ocupation_ne40 : in std_logic;
			ocupation_ne31 : in std_logic;
			ocupation_ne32 : in std_logic;
			correspondence_B18 : in signalStates;
			correspondence_T03 : in signalStates;
			correspondence_T05 : in signalStates;
			Sw18_state : in singleSwitchStates;
			Sw14_state : in singleSwitchStates;
			--Ocupation level 2
			ocupation_ne42 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw19_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne31 : in std_logic;
			correspondence_T03 : out signalStates;
			lock_T03 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne31 : in std_logic;
			correspondence_T04 : out signalStates;
			lock_T04 : out objectLock;
			--Ocupation level 1
			ocupation_ne40 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_T01 : in signalStates;
			Sw14_state : in singleSwitchStates;
			Sw18_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne32 : in std_logic;
			correspondence_T05 : out signalStates;
			lock_T05 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne32 : in std_logic;
			correspondence_T06 : out signalStates;
			lock_T06 : out objectLock;
			--Ocupation level 1
			ocupation_ne40 : in std_logic;
			ocupation_ne1 : in std_logic;
			correspondence_T01 : in signalStates;
			Sw14_state : in singleSwitchStates;
			Sw18_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne41 : in std_logic;
			correspondence_B18 : out signalStates;
			lock_B18 : out objectLock;
			--Ocupation level 1
			ocupation_ne42 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw19_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne42 : in std_logic;
			correspondence_T07 : out signalStates;
			lock_T07 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne42 : in std_logic;
			correspondence_T08 : out signalStates;
			lock_T08 : out objectLock;
			correspondence_H20 : in signalStates;
			--Ocupation level 2
			ocupation_ne1 : in std_logic;
			ocupation_ne43 : in std_logic;
			ocupation_ne41 : in std_logic;
			correspondence_T01 : in signalStates;
			correspondence_T09 : in signalStates;
			Sw18_state : in singleSwitchStates;
			Sw19_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne42 : in std_logic;
			correspondence_H20 : out signalStates;
			lock_H20 : out objectLock;
			--Ocupation level 1
			ocupation_ne41 : in std_logic;
			ocupation_ne1 : in std_logic;
			ocupation_ne43 : in std_logic;
			correspondence_T01 : in signalStates;
			correspondence_T09 : in signalStates;
			Sw18_state : in singleSwitchStates;
			Sw19_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne43 : in std_logic;
			correspondence_T09 : out signalStates;
			lock_T09 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne43 : in std_logic;
			correspondence_T10 : out signalStates;
			lock_T10 : out objectLock;
			--Ocupation level 1
			ocupation_ne42 : in std_logic;
			correspondence_T07 : in signalStates;
			Sw19_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_12;
	component node_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
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
			R2_command : in routeCommands;
			R7_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R8_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
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
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_6;
	component route_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			T02_state : in signalStates;
			T02_lock : in objectLock;
			T02_command : out routeCommands;
			S14_state : in signalStates;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne31_state : in nodeStates;
			ne31_lock : in objectLock;
			ne31_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_lock : in objectLock;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_lock : in objectLock;
			Sw18_command : out routeCommands;
			T04_state : in signalStates;
			T04_lock : in objectLock;
			T04_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne32_state : in nodeStates;
			ne32_lock : in objectLock;
			ne32_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_lock : in objectLock;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_lock : in objectLock;
			Sw18_command : out routeCommands;
			T06_state : in signalStates;
			T06_lock : in objectLock;
			T06_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_lock : in objectLock;
			ne42_command : out routeCommands;
			T08_state : in signalStates;
			T08_lock : in objectLock;
			T08_command : out routeCommands;
			H20_state : in signalStates;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne43_state : in nodeStates;
			ne43_lock : in objectLock;
			ne43_command : out routeCommands;
			ne42_state : in nodeStates;
			ne42_lock : in objectLock;
			ne42_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_lock : in objectLock;
			Sw19_command : out routeCommands;
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
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_lock : in objectLock;
			ne41_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_lock : in objectLock;
			Sw18_command : out routeCommands;
			S14_state : in signalStates;
			S14_lock : in objectLock;
			S14_command : out routeCommands;
			B18_state : in signalStates;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			ne31_state : in nodeStates;
			ne31_lock : in objectLock;
			ne31_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_lock : in objectLock;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_lock : in objectLock;
			Sw18_command : out routeCommands;
			S14_state : in signalStates;
			S14_lock : in objectLock;
			S14_command : out routeCommands;
			T03_state : in signalStates;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			ne32_state : in nodeStates;
			ne32_lock : in objectLock;
			ne32_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_lock : in objectLock;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_lock : in objectLock;
			Sw18_command : out routeCommands;
			S14_state : in signalStates;
			S14_lock : in objectLock;
			S14_command : out routeCommands;
			T05_state : in signalStates;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
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
			Sw19_state : in singleSwitchStates;
			Sw19_lock : in objectLock;
			Sw19_command : out routeCommands;
			B18_state : in signalStates;
			B18_lock : in objectLock;
			B18_command : out routeCommands;
			T07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
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
			ne1_state : in nodeStates;
			ne1_lock : in objectLock;
			ne1_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_lock : in objectLock;
			Sw18_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_lock : in objectLock;
			Sw19_command : out routeCommands;
			H20_state : in signalStates;
			H20_lock : in objectLock;
			H20_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_lock : in objectLock;
			ne42_command : out routeCommands;
			ne43_state : in nodeStates;
			ne43_lock : in objectLock;
			ne43_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_lock : in objectLock;
			Sw19_command : out routeCommands;
			H20_state : in signalStates;
			H20_lock : in objectLock;
			H20_command : out routeCommands;
			T09_state : in signalStates;
			routeState : out std_logic
		);
	end component route_10;
	signal state_Sw18 , state_Sw14 , state_Sw19 : singleSwitchStates;
	signal Sw18_locking , Sw14_locking , Sw19_locking : objectLock;
	signal state_T01 , state_T02 , state_S14 , state_T03 , state_T04 , state_T05 , state_T06 , state_B18 , state_T07 , state_T08 , state_H20 , state_T09 , state_T10 : signalStates;
	signal T01_locking , T02_locking , S14_locking , T03_locking , T04_locking , T05_locking , T06_locking , B18_locking , T07_locking , T08_locking , H20_locking , T09_locking , T10_locking : objectLock;
	signal state_ne1 , state_ne31 , state_ne32 , state_ne40 , state_ne41 , state_ne42 , state_ne43 : nodeStates;
	signal ne1_locking , ne31_locking , ne32_locking , ne40_locking , ne41_locking , ne42_locking , ne43_locking : objectLock;
	signal cmd_R1_ne1 , cmd_R2_ne31 , cmd_R2_ne40 , cmd_R2_ne1 , cmd_R3_ne32 , cmd_R3_ne40 , cmd_R3_ne1 , cmd_R4_ne42 , cmd_R5_ne43 , cmd_R5_ne42 , cmd_R6_ne1 , cmd_R6_ne41 , cmd_R7_ne1 , cmd_R7_ne40 , cmd_R7_ne31 , cmd_R8_ne1 , cmd_R8_ne40 , cmd_R8_ne32 , cmd_R9_ne41 , cmd_R9_ne42 , cmd_R10_ne42 , cmd_R10_ne41 , cmd_R10_ne1 , cmd_R11_ne42 , cmd_R11_ne43 : routeCommands;
	signal cmd_R2_Sw14 , cmd_R2_Sw18 , cmd_R3_Sw14 , cmd_R3_Sw18 , cmd_R5_Sw19 , cmd_R6_Sw18 , cmd_R7_Sw14 , cmd_R7_Sw18 , cmd_R8_Sw14 , cmd_R8_Sw18 , cmd_R9_Sw19 , cmd_R10_Sw18 , cmd_R10_Sw19 , cmd_R11_Sw19 : routeCommands;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_T06 , cmd_R4_T08 , cmd_R5_T10 , cmd_R6_S14 , cmd_R7_S14 , cmd_R8_S14 , cmd_R9_B18 , cmd_R10_H20 , cmd_R11_H20 : routeCommands;
begin
	singleSwitch_Sw18 : singleSwitch_0 port map(clock => clock, reset => reset, R2_command => cmd_R2_Sw18, R3_command => cmd_R3_Sw18, R6_command => cmd_R6_Sw18, R7_command => cmd_R7_Sw18, R8_command => cmd_R8_Sw18, R10_command => cmd_R10_Sw18, indication => singleSwitches_i(0), command => singleSwitches_o(0), lock_Sw18 => Sw18_locking, correspondence_Sw18 => state_Sw18);
	singleSwitch_Sw14 : singleSwitch_1 port map(clock => clock, reset => reset, R2_command => cmd_R2_Sw14, R3_command => cmd_R3_Sw14, R7_command => cmd_R7_Sw14, R8_command => cmd_R8_Sw14, indication => singleSwitches_i(1), command => singleSwitches_o(1), lock_Sw14 => Sw14_locking, correspondence_Sw14 => state_Sw14);
	singleSwitch_Sw19 : singleSwitch_2 port map(clock => clock, reset => reset, R5_command => cmd_R5_Sw19, R9_command => cmd_R9_Sw19, R10_command => cmd_R10_Sw19, R11_command => cmd_R11_Sw19, indication => singleSwitches_i(2), command => singleSwitches_o(2), lock_Sw19 => Sw19_locking, correspondence_Sw19 => state_Sw19);
	railwaySignal_T01 : railwaySignal_0 port map(clock => clock, reset => reset, ocupation_ne1 => ocupation(0), indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command.msb => signals_o.msb(0), command.lsb => signals_o.lsb(0), lock_T01 => T01_locking, correspondence_T01 => state_T01);
	railwaySignal_T02 : railwaySignal_1 port map(clock => clock, reset => reset, R1_command => cmd_R1_T02, ocupation_ne1 => ocupation(0), ocupation_ne32 => ocupation(2), ocupation_ne31 => ocupation(1), ocupation_ne40 => ocupation(3), ocupation_ne41 => ocupation(4), correspondence_S14 => state_S14, correspondence_B18 => state_B18, correspondence_T03 => state_T03, correspondence_T05 => state_T05, Sw18_state => state_Sw18, Sw14_state => state_Sw14, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command.msb => signals_o.msb(1), command.lsb => signals_o.lsb(1), lock_T02 => T02_locking, correspondence_T02 => state_T02);
	railwaySignal_S14 : railwaySignal_2 port map(clock => clock, reset => reset, R6_command => cmd_R6_S14, R7_command => cmd_R7_S14, R8_command => cmd_R8_S14, ocupation_ne1 => ocupation(0), ocupation_ne41 => ocupation(4), ocupation_ne40 => ocupation(3), ocupation_ne31 => ocupation(1), ocupation_ne32 => ocupation(2), ocupation_ne42 => ocupation(5), correspondence_B18 => state_B18, correspondence_T03 => state_T03, correspondence_T05 => state_T05, correspondence_T07 => state_T07, Sw18_state => state_Sw18, Sw19_state => state_Sw19, Sw14_state => state_Sw14, indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command.msb => signals_o.msb(2), command.lsb => signals_o.lsb(2), lock_S14 => S14_locking, correspondence_S14 => state_S14);
	railwaySignal_T03 : railwaySignal_3 port map(clock => clock, reset => reset, ocupation_ne31 => ocupation(1), indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command.msb => signals_o.msb(3), command.lsb => signals_o.lsb(3), lock_T03 => T03_locking, correspondence_T03 => state_T03);
	railwaySignal_T04 : railwaySignal_4 port map(clock => clock, reset => reset, R2_command => cmd_R2_T04, ocupation_ne31 => ocupation(1), ocupation_ne40 => ocupation(3), ocupation_ne1 => ocupation(0), correspondence_T01 => state_T01, Sw14_state => state_Sw14, Sw18_state => state_Sw18, indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command.msb => signals_o.msb(4), command.lsb => signals_o.lsb(4), lock_T04 => T04_locking, correspondence_T04 => state_T04);
	railwaySignal_T05 : railwaySignal_5 port map(clock => clock, reset => reset, ocupation_ne32 => ocupation(2), indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command.msb => signals_o.msb(5), command.lsb => signals_o.lsb(5), lock_T05 => T05_locking, correspondence_T05 => state_T05);
	railwaySignal_T06 : railwaySignal_6 port map(clock => clock, reset => reset, R3_command => cmd_R3_T06, ocupation_ne32 => ocupation(2), ocupation_ne40 => ocupation(3), ocupation_ne1 => ocupation(0), correspondence_T01 => state_T01, Sw14_state => state_Sw14, Sw18_state => state_Sw18, indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command.msb => signals_o.msb(6), command.lsb => signals_o.lsb(6), lock_T06 => T06_locking, correspondence_T06 => state_T06);
	railwaySignal_B18 : railwaySignal_7 port map(clock => clock, reset => reset, R9_command => cmd_R9_B18, ocupation_ne41 => ocupation(4), ocupation_ne42 => ocupation(5), correspondence_T07 => state_T07, Sw19_state => state_Sw19, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command.msb => signals_o.msb(7), command.lsb => signals_o.lsb(7), lock_B18 => B18_locking, correspondence_B18 => state_B18);
	railwaySignal_T07 : railwaySignal_8 port map(clock => clock, reset => reset, ocupation_ne42 => ocupation(5), indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command.msb => signals_o.msb(8), command.lsb => signals_o.lsb(8), lock_T07 => T07_locking, correspondence_T07 => state_T07);
	railwaySignal_T08 : railwaySignal_9 port map(clock => clock, reset => reset, R4_command => cmd_R4_T08, ocupation_ne42 => ocupation(5), ocupation_ne1 => ocupation(0), ocupation_ne43 => ocupation(6), ocupation_ne41 => ocupation(4), correspondence_H20 => state_H20, correspondence_T01 => state_T01, correspondence_T09 => state_T09, Sw18_state => state_Sw18, Sw19_state => state_Sw19, indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command.msb => signals_o.msb(9), command.lsb => signals_o.lsb(9), lock_T08 => T08_locking, correspondence_T08 => state_T08);
	railwaySignal_H20 : railwaySignal_10 port map(clock => clock, reset => reset, R10_command => cmd_R10_H20, R11_command => cmd_R11_H20, ocupation_ne42 => ocupation(5), ocupation_ne41 => ocupation(4), ocupation_ne1 => ocupation(0), ocupation_ne43 => ocupation(6), correspondence_T01 => state_T01, correspondence_T09 => state_T09, Sw18_state => state_Sw18, Sw19_state => state_Sw19, indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command.msb => signals_o.msb(10), command.lsb => signals_o.lsb(10), lock_H20 => H20_locking, correspondence_H20 => state_H20);
	railwaySignal_T09 : railwaySignal_11 port map(clock => clock, reset => reset, ocupation_ne43 => ocupation(6), indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command.msb => signals_o.msb(11), command.lsb => signals_o.lsb(11), lock_T09 => T09_locking, correspondence_T09 => state_T09);
	railwaySignal_T10 : railwaySignal_12 port map(clock => clock, reset => reset, R5_command => cmd_R5_T10, ocupation_ne43 => ocupation(6), ocupation_ne42 => ocupation(5), correspondence_T07 => state_T07, Sw19_state => state_Sw19, indication.msb => signals_i.msb(12), indication.lsb => signals_i.lsb(12), command.msb => signals_o.msb(12), command.lsb => signals_o.lsb(12), lock_T10 => T10_locking, correspondence_T10 => state_T10);
	node_ne1 : node_0 port map(clock => clock, ocupation => ocupation(0), reset => reset, R1_command => cmd_R1_ne1, R2_command => cmd_R2_ne1, R3_command => cmd_R3_ne1, R6_command => cmd_R6_ne1, R7_command => cmd_R7_ne1, R8_command => cmd_R8_ne1, R10_command => cmd_R10_ne1, state => state_ne1, locking => ne1_locking);
	node_ne31 : node_1 port map(clock => clock, ocupation => ocupation(1), reset => reset, R2_command => cmd_R2_ne31, R7_command => cmd_R7_ne31, state => state_ne31, locking => ne31_locking);
	node_ne32 : node_2 port map(clock => clock, ocupation => ocupation(2), reset => reset, R3_command => cmd_R3_ne32, R8_command => cmd_R8_ne32, state => state_ne32, locking => ne32_locking);
	node_ne40 : node_3 port map(clock => clock, ocupation => ocupation(3), reset => reset, R2_command => cmd_R2_ne40, R3_command => cmd_R3_ne40, R7_command => cmd_R7_ne40, R8_command => cmd_R8_ne40, state => state_ne40, locking => ne40_locking);
	node_ne41 : node_4 port map(clock => clock, ocupation => ocupation(4), reset => reset, R6_command => cmd_R6_ne41, R9_command => cmd_R9_ne41, R10_command => cmd_R10_ne41, state => state_ne41, locking => ne41_locking);
	node_ne42 : node_5 port map(clock => clock, ocupation => ocupation(5), reset => reset, R4_command => cmd_R4_ne42, R5_command => cmd_R5_ne42, R9_command => cmd_R9_ne42, R10_command => cmd_R10_ne42, R11_command => cmd_R11_ne42, state => state_ne42, locking => ne42_locking);
	node_ne43 : node_6 port map(clock => clock, ocupation => ocupation(6), reset => reset, R5_command => cmd_R5_ne43, R11_command => cmd_R11_ne43, state => state_ne43, locking => ne43_locking);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), reset => reset, ne1_command => cmd_R1_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, T02_state => state_T02, T02_lock => T02_locking, T02_command => cmd_R1_T02, S14_state => state_S14, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), reset => reset, ne1_command => cmd_R2_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne31_command => cmd_R2_ne31, ne31_state => state_ne31, ne31_lock => ne31_locking, ne40_command => cmd_R2_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, Sw14_command => cmd_R2_Sw14, Sw14_state => state_Sw14, Sw14_lock => Sw14_locking, Sw18_command => cmd_R2_Sw18, Sw18_state => state_Sw18, Sw18_lock => Sw18_locking, T04_state => state_T04, T04_lock => T04_locking, T04_command => cmd_R2_T04, T01_state => state_T01, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), reset => reset, ne1_command => cmd_R3_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne32_command => cmd_R3_ne32, ne32_state => state_ne32, ne32_lock => ne32_locking, ne40_command => cmd_R3_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, Sw14_command => cmd_R3_Sw14, Sw14_state => state_Sw14, Sw14_lock => Sw14_locking, Sw18_command => cmd_R3_Sw18, Sw18_state => state_Sw18, Sw18_lock => Sw18_locking, T06_state => state_T06, T06_lock => T06_locking, T06_command => cmd_R3_T06, T01_state => state_T01, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), reset => reset, ne42_command => cmd_R4_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, T08_state => state_T08, T08_lock => T08_locking, T08_command => cmd_R4_T08, H20_state => state_H20, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), reset => reset, ne42_command => cmd_R5_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, ne43_command => cmd_R5_ne43, ne43_state => state_ne43, ne43_lock => ne43_locking, Sw19_command => cmd_R5_Sw19, Sw19_state => state_Sw19, Sw19_lock => Sw19_locking, T10_state => state_T10, T10_lock => T10_locking, T10_command => cmd_R5_T10, T07_state => state_T07, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), reset => reset, ne1_command => cmd_R6_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne41_command => cmd_R6_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, Sw18_command => cmd_R6_Sw18, Sw18_state => state_Sw18, Sw18_lock => Sw18_locking, S14_state => state_S14, S14_lock => S14_locking, S14_command => cmd_R6_S14, B18_state => state_B18, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), reset => reset, ne1_command => cmd_R7_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne31_command => cmd_R7_ne31, ne31_state => state_ne31, ne31_lock => ne31_locking, ne40_command => cmd_R7_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, Sw14_command => cmd_R7_Sw14, Sw14_state => state_Sw14, Sw14_lock => Sw14_locking, Sw18_command => cmd_R7_Sw18, Sw18_state => state_Sw18, Sw18_lock => Sw18_locking, S14_state => state_S14, S14_lock => S14_locking, S14_command => cmd_R7_S14, T03_state => state_T03, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), reset => reset, ne1_command => cmd_R8_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne32_command => cmd_R8_ne32, ne32_state => state_ne32, ne32_lock => ne32_locking, ne40_command => cmd_R8_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, Sw14_command => cmd_R8_Sw14, Sw14_state => state_Sw14, Sw14_lock => Sw14_locking, Sw18_command => cmd_R8_Sw18, Sw18_state => state_Sw18, Sw18_lock => Sw18_locking, S14_state => state_S14, S14_lock => S14_locking, S14_command => cmd_R8_S14, T05_state => state_T05, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), reset => reset, ne41_command => cmd_R9_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, ne42_command => cmd_R9_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, Sw19_command => cmd_R9_Sw19, Sw19_state => state_Sw19, Sw19_lock => Sw19_locking, B18_state => state_B18, B18_lock => B18_locking, B18_command => cmd_R9_B18, T07_state => state_T07, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), reset => reset, ne1_command => cmd_R10_ne1, ne1_state => state_ne1, ne1_lock => ne1_locking, ne41_command => cmd_R10_ne41, ne41_state => state_ne41, ne41_lock => ne41_locking, ne42_command => cmd_R10_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, Sw18_command => cmd_R10_Sw18, Sw18_state => state_Sw18, Sw18_lock => Sw18_locking, Sw19_command => cmd_R10_Sw19, Sw19_state => state_Sw19, Sw19_lock => Sw19_locking, H20_state => state_H20, H20_lock => H20_locking, H20_command => cmd_R10_H20, T01_state => state_T01, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), reset => reset, ne42_command => cmd_R11_ne42, ne42_state => state_ne42, ne42_lock => ne42_locking, ne43_command => cmd_R11_ne43, ne43_state => state_ne43, ne43_lock => ne43_locking, Sw19_command => cmd_R11_Sw19, Sw19_state => state_Sw19, Sw19_lock => Sw19_locking, H20_state => state_H20, H20_lock => H20_locking, H20_command => cmd_R11_H20, T09_state => state_T09, routeState => routes_o(10));
	processed <= processing;
end Behavioral;