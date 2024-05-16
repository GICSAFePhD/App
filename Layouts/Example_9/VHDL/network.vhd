--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 91;
			N_SIGNALS : natural := 25;
			N_ROUTES : natural := 27;
			N_LEVELCROSSINGS : natural := 3;
			N_SINGLESWITCHES : natural := 4;
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
			ocupation_ne46 : in std_logic;
			ocupation_ne3 : in std_logic;
			ocupation_ne40 : in std_logic;
			R12_command : in routeCommands;
			R18_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc10 : out levelCrossingStates;
			lock_Lc10 : out objectLock
		);
	end component levelCrossing_0;
	component levelCrossing_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne49 : in std_logic;
			ocupation_ne48 : in std_logic;
			ocupation_ne53 : in std_logic;
			R3_command : in routeCommands;
			R9_command : in routeCommands;
			R19_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc11 : out levelCrossingStates;
			lock_Lc11 : out objectLock
		);
	end component levelCrossing_1;
	component levelCrossing_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation_ne50 : in std_logic;
			ocupation_ne48 : in std_logic;
			ocupation_ne53 : in std_logic;
			R5_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc09 : out levelCrossingStates;
			lock_Lc09 : out objectLock
		);
	end component levelCrossing_2;
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R19_command : in routeCommands;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw31 : out singleSwitchStates;
			lock_Sw31 : out objectLock
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R7_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw27 : out singleSwitchStates;
			lock_Sw27 : out objectLock
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw29 : out singleSwitchStates;
			lock_Sw29 : out objectLock
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R19_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw33 : out singleSwitchStates;
			lock_Sw33 : out objectLock
		);
	end component singleSwitch_3;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
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
			ocupation_ne3 : in std_logic;
			correspondence_T02 : out signalStates;
			lock_T02 : out objectLock;
			correspondence_S42 : in signalStates;
			--Ocupation level 2
			ocupation_ne53 : in std_logic;
			ocupation_ne49 : in std_logic;
			ocupation_ne50 : in std_logic;
			ocupation_ne46 : in std_logic;
			correspondence_J16 : in signalStates;
			correspondence_J12 : in signalStates;
			correspondence_J14 : in signalStates;
			Sw31_state : in singleSwitchStates;
			Sw33_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R13_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_J17 : out signalStates;
			lock_J17 : out objectLock;
			correspondence_J21 : in signalStates;
			--Ocupation level 2
			correspondence_T01 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_J21 : out signalStates;
			lock_J21 : out objectLock;
			correspondence_T01 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			Lc10_state : in levelCrossingStates;
			Lc11_state : in levelCrossingStates;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne3 : in std_logic;
			correspondence_S42 : out signalStates;
			lock_S42 : out objectLock;
			--Ocupation level 1
			ocupation_ne46 : in std_logic;
			ocupation_ne53 : in std_logic;
			ocupation_ne49 : in std_logic;
			ocupation_ne50 : in std_logic;
			correspondence_J16 : in signalStates;
			correspondence_J12 : in signalStates;
			correspondence_J14 : in signalStates;
			Sw31_state : in singleSwitchStates;
			Sw33_state : in singleSwitchStates;
			correspondence_J10 : in signalStates;
			correspondence_J06 : in signalStates;
			correspondence_B46 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			ocupation_ne40 : in std_logic;
			correspondence_T03 : out signalStates;
			lock_T03 : out objectLock;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne40 : in std_logic;
			correspondence_T04 : out signalStates;
			lock_T04 : out objectLock;
			correspondence_J25 : in signalStates;
			--Ocupation level 2
			correspondence_S36 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne40 : in std_logic;
			correspondence_J24 : out signalStates;
			lock_J24 : out objectLock;
			correspondence_J26 : in signalStates;
			--Ocupation level 2
			correspondence_T03 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R16_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne40 : in std_logic;
			correspondence_J25 : out signalStates;
			lock_J25 : out objectLock;
			correspondence_S36 : in signalStates;
			--Ocupation level 2
			ocupation_ne49 : in std_logic;
			ocupation_ne48 : in std_logic;
			ocupation_ne50 : in std_logic;
			ocupation_ne46 : in std_logic;
			correspondence_J09 : in signalStates;
			correspondence_J05 : in signalStates;
			correspondence_J07 : in signalStates;
			Sw27_state : in singleSwitchStates;
			Sw29_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R17_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne40 : in std_logic;
			correspondence_J26 : out signalStates;
			lock_J26 : out objectLock;
			correspondence_T03 : in signalStates;
			--Ocupation level 2
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			Lc11_state : in levelCrossingStates;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne40 : in std_logic;
			correspondence_S36 : out signalStates;
			lock_S36 : out objectLock;
			--Ocupation level 1
			ocupation_ne46 : in std_logic;
			ocupation_ne48 : in std_logic;
			ocupation_ne49 : in std_logic;
			ocupation_ne50 : in std_logic;
			correspondence_J09 : in signalStates;
			correspondence_J05 : in signalStates;
			correspondence_J07 : in signalStates;
			Sw27_state : in singleSwitchStates;
			Sw29_state : in singleSwitchStates;
			correspondence_X31 : in signalStates;
			correspondence_J11 : in signalStates;
			correspondence_J13 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne46 : in std_logic;
			correspondence_J09 : out signalStates;
			lock_J09 : out objectLock;
			correspondence_X31 : in signalStates;
			--Ocupation level 2
			correspondence_C41 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne46 : in std_logic;
			correspondence_J10 : out signalStates;
			lock_J10 : out objectLock;
			--Ocupation level 1
			ocupation_ne40 : in std_logic;
			correspondence_J24 : in signalStates;
			Sw27_state : in singleSwitchStates;
			correspondence_J26 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R12_command : in routeCommands;
			Lc10_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne46 : in std_logic;
			correspondence_J16 : out signalStates;
			lock_J16 : out objectLock;
			correspondence_J10 : in signalStates;
			--Ocupation level 2
			ocupation_ne40 : in std_logic;
			correspondence_J24 : in signalStates;
			Sw27_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			Lc10_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne46 : in std_logic;
			correspondence_X31 : out signalStates;
			lock_X31 : out objectLock;
			correspondence_C41 : in signalStates;
			--Ocupation level 2
			ocupation_ne3 : in std_logic;
			correspondence_J17 : in signalStates;
			Sw31_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R23_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne46 : in std_logic;
			correspondence_C41 : out signalStates;
			lock_C41 : out objectLock;
			--Ocupation level 1
			ocupation_ne3 : in std_logic;
			correspondence_J17 : in signalStates;
			Sw31_state : in singleSwitchStates;
			correspondence_J21 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_15;
	component railwaySignal_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			Lc11_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne49 : in std_logic;
			correspondence_J05 : out signalStates;
			lock_J05 : out objectLock;
			correspondence_J11 : in signalStates;
			--Ocupation level 2
			ocupation_ne53 : in std_logic;
			ocupation_ne3 : in std_logic;
			correspondence_J17 : in signalStates;
			Sw31_state : in singleSwitchStates;
			Sw33_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_16;
	component railwaySignal_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne49 : in std_logic;
			correspondence_J06 : out signalStates;
			lock_J06 : out objectLock;
			--Ocupation level 1
			ocupation_ne48 : in std_logic;
			ocupation_ne40 : in std_logic;
			correspondence_J24 : in signalStates;
			Sw27_state : in singleSwitchStates;
			Sw29_state : in singleSwitchStates;
			correspondence_J26 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_17;
	component railwaySignal_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne49 : in std_logic;
			correspondence_J11 : out signalStates;
			lock_J11 : out objectLock;
			--Ocupation level 1
			ocupation_ne53 : in std_logic;
			ocupation_ne3 : in std_logic;
			correspondence_J17 : in signalStates;
			Sw31_state : in singleSwitchStates;
			Sw33_state : in singleSwitchStates;
			correspondence_J21 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_18;
	component railwaySignal_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			Lc11_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne49 : in std_logic;
			correspondence_J12 : out signalStates;
			lock_J12 : out objectLock;
			correspondence_J06 : in signalStates;
			--Ocupation level 2
			ocupation_ne48 : in std_logic;
			ocupation_ne40 : in std_logic;
			correspondence_J24 : in signalStates;
			Sw27_state : in singleSwitchStates;
			Sw29_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_19;
	component railwaySignal_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R19_command : in routeCommands;
			Lc11_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne49 : in std_logic;
			correspondence_X33 : out signalStates;
			lock_X33 : out objectLock;
			--Ocupation level 1
			ocupation_ne53 : in std_logic;
			ocupation_ne3 : in std_logic;
			correspondence_J17 : in signalStates;
			Sw31_state : in singleSwitchStates;
			Sw33_state : in singleSwitchStates;
			correspondence_J21 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_20;
	component railwaySignal_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne50 : in std_logic;
			correspondence_J07 : out signalStates;
			lock_J07 : out objectLock;
			correspondence_J13 : in signalStates;
			--Ocupation level 2
			ocupation_ne53 : in std_logic;
			ocupation_ne3 : in std_logic;
			correspondence_J17 : in signalStates;
			Sw31_state : in singleSwitchStates;
			Sw33_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_21;
	component railwaySignal_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne50 : in std_logic;
			correspondence_J13 : out signalStates;
			lock_J13 : out objectLock;
			--Ocupation level 1
			ocupation_ne53 : in std_logic;
			ocupation_ne3 : in std_logic;
			correspondence_J17 : in signalStates;
			Sw31_state : in singleSwitchStates;
			Sw33_state : in singleSwitchStates;
			correspondence_J21 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_22;
	component railwaySignal_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			Lc09_state : in levelCrossingStates;
			--Ocupation level 0
			ocupation_ne50 : in std_logic;
			correspondence_J14 : out signalStates;
			lock_J14 : out objectLock;
			correspondence_B46 : in signalStates;
			--Ocupation level 2
			ocupation_ne48 : in std_logic;
			ocupation_ne40 : in std_logic;
			correspondence_J24 : in signalStates;
			Sw27_state : in singleSwitchStates;
			Sw29_state : in singleSwitchStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_23;
	component railwaySignal_24 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R27_command : in routeCommands;
			--Ocupation level 0
			ocupation_ne50 : in std_logic;
			correspondence_B46 : out signalStates;
			lock_B46 : out objectLock;
			--Ocupation level 1
			ocupation_ne48 : in std_logic;
			ocupation_ne40 : in std_logic;
			correspondence_J24 : in signalStates;
			Sw27_state : in singleSwitchStates;
			Sw29_state : in singleSwitchStates;
			correspondence_J26 : in signalStates;
			indication : in signal_type;
			command : out signal_type
		);
	end component railwaySignal_24;
	component node_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			R19_command : in routeCommands;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
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
			R4_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			R17_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			R18_command : in routeCommands;
			R20_command : in routeCommands;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
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
			R4_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			R25_command : in routeCommands;
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
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R22_command : in routeCommands;
			R26_command : in routeCommands;
			R27_command : in routeCommands;
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
			R10_command : in routeCommands;
			R19_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			state : out nodeStates;
			locking : out objectLock
		);
	end component node_6;
	component route_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			T02_state : in signalStates;
			T02_lock : in objectLock;
			T02_command : out routeCommands;
			S42_state : in signalStates;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			T04_state : in signalStates;
			T04_lock : in objectLock;
			T04_command : out routeCommands;
			J25_state : in signalStates;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			Lc11_state : in levelCrossingStates;
			Lc11_lock : in objectLock;
			Lc11_command : out routeCommands;
			J05_state : in signalStates;
			J05_lock : in objectLock;
			J05_command : out routeCommands;
			J11_state : in signalStates;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_lock : in objectLock;
			ne48_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			Sw27_state : in singleSwitchStates;
			Sw27_lock : in objectLock;
			Sw27_command : out routeCommands;
			Sw29_state : in singleSwitchStates;
			Sw29_lock : in objectLock;
			Sw29_command : out routeCommands;
			J06_state : in signalStates;
			J06_lock : in objectLock;
			J06_command : out routeCommands;
			J24_state : in signalStates;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne50_state : in nodeStates;
			ne50_lock : in objectLock;
			ne50_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_lock : in objectLock;
			Lc09_command : out routeCommands;
			J07_state : in signalStates;
			J07_lock : in objectLock;
			J07_command : out routeCommands;
			J13_state : in signalStates;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne46_state : in nodeStates;
			ne46_lock : in objectLock;
			ne46_command : out routeCommands;
			J09_state : in signalStates;
			J09_lock : in objectLock;
			J09_command : out routeCommands;
			X31_state : in signalStates;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne46_state : in nodeStates;
			ne46_lock : in objectLock;
			ne46_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			Sw27_state : in singleSwitchStates;
			Sw27_lock : in objectLock;
			Sw27_command : out routeCommands;
			J10_state : in signalStates;
			J10_lock : in objectLock;
			J10_command : out routeCommands;
			J24_state : in signalStates;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			ne53_state : in nodeStates;
			ne53_lock : in objectLock;
			ne53_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Sw31_state : in singleSwitchStates;
			Sw31_lock : in objectLock;
			Sw31_command : out routeCommands;
			Sw33_state : in singleSwitchStates;
			Sw33_lock : in objectLock;
			Sw33_command : out routeCommands;
			J11_state : in signalStates;
			J11_lock : in objectLock;
			J11_command : out routeCommands;
			J17_state : in signalStates;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			Lc11_state : in levelCrossingStates;
			Lc11_lock : in objectLock;
			Lc11_command : out routeCommands;
			J12_state : in signalStates;
			J12_lock : in objectLock;
			J12_command : out routeCommands;
			J06_state : in signalStates;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne50_state : in nodeStates;
			ne50_lock : in objectLock;
			ne50_command : out routeCommands;
			ne53_state : in nodeStates;
			ne53_lock : in objectLock;
			ne53_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Sw31_state : in singleSwitchStates;
			Sw31_lock : in objectLock;
			Sw31_command : out routeCommands;
			Sw33_state : in singleSwitchStates;
			Sw33_lock : in objectLock;
			Sw33_command : out routeCommands;
			J13_state : in signalStates;
			J13_lock : in objectLock;
			J13_command : out routeCommands;
			J17_state : in signalStates;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne50_state : in nodeStates;
			ne50_lock : in objectLock;
			ne50_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_lock : in objectLock;
			Lc09_command : out routeCommands;
			J14_state : in signalStates;
			J14_lock : in objectLock;
			J14_command : out routeCommands;
			B46_state : in signalStates;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne46_state : in nodeStates;
			ne46_lock : in objectLock;
			ne46_command : out routeCommands;
			Lc10_state : in levelCrossingStates;
			Lc10_lock : in objectLock;
			Lc10_command : out routeCommands;
			J16_state : in signalStates;
			J16_lock : in objectLock;
			J16_command : out routeCommands;
			J10_state : in signalStates;
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
			J17_state : in signalStates;
			J17_lock : in objectLock;
			J17_command : out routeCommands;
			J21_state : in signalStates;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			J21_state : in signalStates;
			J21_lock : in objectLock;
			J21_command : out routeCommands;
			T01_state : in signalStates;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			J24_state : in signalStates;
			J24_lock : in objectLock;
			J24_command : out routeCommands;
			J26_state : in signalStates;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			J25_state : in signalStates;
			J25_lock : in objectLock;
			J25_command : out routeCommands;
			S36_state : in signalStates;
			routeState : out std_logic
		);
	end component route_15;
	component route_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			J26_state : in signalStates;
			J26_lock : in objectLock;
			J26_command : out routeCommands;
			T03_state : in signalStates;
			routeState : out std_logic
		);
	end component route_16;
	component route_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne46_state : in nodeStates;
			ne46_lock : in objectLock;
			ne46_command : out routeCommands;
			Lc10_state : in levelCrossingStates;
			Lc10_lock : in objectLock;
			Lc10_command : out routeCommands;
			X31_state : in signalStates;
			X31_lock : in objectLock;
			X31_command : out routeCommands;
			C41_state : in signalStates;
			routeState : out std_logic
		);
	end component route_17;
	component route_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			ne53_state : in nodeStates;
			ne53_lock : in objectLock;
			ne53_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Lc11_state : in levelCrossingStates;
			Lc11_lock : in objectLock;
			Lc11_command : out routeCommands;
			Sw31_state : in singleSwitchStates;
			Sw31_lock : in objectLock;
			Sw31_command : out routeCommands;
			Sw33_state : in singleSwitchStates;
			Sw33_lock : in objectLock;
			Sw33_command : out routeCommands;
			X33_state : in signalStates;
			X33_lock : in objectLock;
			X33_command : out routeCommands;
			J17_state : in signalStates;
			routeState : out std_logic
		);
	end component route_18;
	component route_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			ne46_state : in nodeStates;
			ne46_lock : in objectLock;
			ne46_command : out routeCommands;
			Sw27_state : in singleSwitchStates;
			Sw27_lock : in objectLock;
			Sw27_command : out routeCommands;
			S36_state : in signalStates;
			S36_lock : in objectLock;
			S36_command : out routeCommands;
			J09_state : in signalStates;
			routeState : out std_logic
		);
	end component route_19;
	component route_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_lock : in objectLock;
			ne48_command : out routeCommands;
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			Sw27_state : in singleSwitchStates;
			Sw27_lock : in objectLock;
			Sw27_command : out routeCommands;
			Sw29_state : in singleSwitchStates;
			Sw29_lock : in objectLock;
			Sw29_command : out routeCommands;
			S36_state : in signalStates;
			S36_lock : in objectLock;
			S36_command : out routeCommands;
			J05_state : in signalStates;
			routeState : out std_logic
		);
	end component route_20;
	component route_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_lock : in objectLock;
			ne48_command : out routeCommands;
			ne50_state : in nodeStates;
			ne50_lock : in objectLock;
			ne50_command : out routeCommands;
			Sw27_state : in singleSwitchStates;
			Sw27_lock : in objectLock;
			Sw27_command : out routeCommands;
			Sw29_state : in singleSwitchStates;
			Sw29_lock : in objectLock;
			Sw29_command : out routeCommands;
			S36_state : in signalStates;
			S36_lock : in objectLock;
			S36_command : out routeCommands;
			J07_state : in signalStates;
			routeState : out std_logic
		);
	end component route_21;
	component route_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne46_state : in nodeStates;
			ne46_lock : in objectLock;
			ne46_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			Sw31_state : in singleSwitchStates;
			Sw31_lock : in objectLock;
			Sw31_command : out routeCommands;
			C41_state : in signalStates;
			C41_lock : in objectLock;
			C41_command : out routeCommands;
			J17_state : in signalStates;
			routeState : out std_logic
		);
	end component route_22;
	component route_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne46_state : in nodeStates;
			ne46_lock : in objectLock;
			ne46_command : out routeCommands;
			Sw31_state : in singleSwitchStates;
			Sw31_lock : in objectLock;
			Sw31_command : out routeCommands;
			S42_state : in signalStates;
			S42_lock : in objectLock;
			S42_command : out routeCommands;
			J16_state : in signalStates;
			routeState : out std_logic
		);
	end component route_23;
	component route_24 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne53_state : in nodeStates;
			ne53_lock : in objectLock;
			ne53_command : out routeCommands;
			ne49_state : in nodeStates;
			ne49_lock : in objectLock;
			ne49_command : out routeCommands;
			Sw31_state : in singleSwitchStates;
			Sw31_lock : in objectLock;
			Sw31_command : out routeCommands;
			Sw33_state : in singleSwitchStates;
			Sw33_lock : in objectLock;
			Sw33_command : out routeCommands;
			S42_state : in signalStates;
			S42_lock : in objectLock;
			S42_command : out routeCommands;
			J12_state : in signalStates;
			routeState : out std_logic
		);
	end component route_24;
	component route_25 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_lock : in objectLock;
			ne3_command : out routeCommands;
			ne53_state : in nodeStates;
			ne53_lock : in objectLock;
			ne53_command : out routeCommands;
			ne50_state : in nodeStates;
			ne50_lock : in objectLock;
			ne50_command : out routeCommands;
			Sw31_state : in singleSwitchStates;
			Sw31_lock : in objectLock;
			Sw31_command : out routeCommands;
			Sw33_state : in singleSwitchStates;
			Sw33_lock : in objectLock;
			Sw33_command : out routeCommands;
			S42_state : in signalStates;
			S42_lock : in objectLock;
			S42_command : out routeCommands;
			J14_state : in signalStates;
			routeState : out std_logic
		);
	end component route_25;
	component route_26 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			routeRequest : in std_logic;
			ne50_state : in nodeStates;
			ne50_lock : in objectLock;
			ne50_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_lock : in objectLock;
			ne48_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_lock : in objectLock;
			ne40_command : out routeCommands;
			Sw27_state : in singleSwitchStates;
			Sw27_lock : in objectLock;
			Sw27_command : out routeCommands;
			Sw29_state : in singleSwitchStates;
			Sw29_lock : in objectLock;
			Sw29_command : out routeCommands;
			B46_state : in signalStates;
			B46_lock : in objectLock;
			B46_command : out routeCommands;
			J24_state : in signalStates;
			routeState : out std_logic
		);
	end component route_26;
	signal state_Lc10 , state_Lc11 , state_Lc09 : levelCrossingStates;
	signal Lc10_locking , Lc11_locking , Lc09_locking : objectLock;
	signal state_Sw31 , state_Sw27 , state_Sw29 , state_Sw33 : singleSwitchStates;
	signal Sw31_locking , Sw27_locking , Sw29_locking , Sw33_locking : objectLock;
	signal state_T01 , state_T02 , state_J17 , state_J21 , state_S42 , state_T03 , state_T04 , state_J24 , state_J25 , state_J26 , state_S36 , state_J09 , state_J10 , state_J16 , state_X31 , state_C41 , state_J05 , state_J06 , state_J11 , state_J12 , state_X33 , state_J07 , state_J13 , state_J14 , state_B46 : signalStates;
	signal T01_locking , T02_locking , J17_locking , J21_locking , S42_locking , T03_locking , T04_locking , J24_locking , J25_locking , J26_locking , S36_locking , J09_locking , J10_locking , J16_locking , X31_locking , C41_locking , J05_locking , J06_locking , J11_locking , J12_locking , X33_locking , J07_locking , J13_locking , J14_locking , B46_locking : objectLock;
	signal state_ne3 , state_ne40 , state_ne46 , state_ne48 , state_ne49 , state_ne50 , state_ne53 : nodeStates;
	signal ne3_locking , ne40_locking , ne46_locking , ne48_locking , ne49_locking , ne50_locking , ne53_locking : objectLock;
	signal cmd_R1_ne3 , cmd_R2_ne40 , cmd_R3_ne49 , cmd_R4_ne49 , cmd_R4_ne48 , cmd_R4_ne40 , cmd_R5_ne50 , cmd_R6_ne46 , cmd_R7_ne46 , cmd_R7_ne40 , cmd_R8_ne49 , cmd_R8_ne53 , cmd_R8_ne3 , cmd_R9_ne49 , cmd_R10_ne50 , cmd_R10_ne53 , cmd_R10_ne3 , cmd_R11_ne50 , cmd_R12_ne46 , cmd_R13_ne3 , cmd_R14_ne3 , cmd_R15_ne40 , cmd_R16_ne40 , cmd_R17_ne40 , cmd_R18_ne46 , cmd_R19_ne49 , cmd_R19_ne53 , cmd_R19_ne3 , cmd_R20_ne40 , cmd_R20_ne46 , cmd_R21_ne40 , cmd_R21_ne48 , cmd_R21_ne49 , cmd_R22_ne40 , cmd_R22_ne48 , cmd_R22_ne50 , cmd_R23_ne46 , cmd_R23_ne3 , cmd_R24_ne3 , cmd_R24_ne46 , cmd_R25_ne3 , cmd_R25_ne53 , cmd_R25_ne49 , cmd_R26_ne3 , cmd_R26_ne53 , cmd_R26_ne50 , cmd_R27_ne50 , cmd_R27_ne48 , cmd_R27_ne40 : routeCommands;
	signal cmd_R3_Lc11 , cmd_R5_Lc09 , cmd_R9_Lc11 , cmd_R11_Lc09 , cmd_R12_Lc10 , cmd_R18_Lc10 , cmd_R19_Lc11 : routeCommands;
	signal cmd_R4_Sw27 , cmd_R4_Sw29 , cmd_R7_Sw27 , cmd_R8_Sw31 , cmd_R8_Sw33 , cmd_R10_Sw31 , cmd_R10_Sw33 , cmd_R19_Sw31 , cmd_R19_Sw33 , cmd_R20_Sw27 , cmd_R21_Sw27 , cmd_R21_Sw29 , cmd_R22_Sw27 , cmd_R22_Sw29 , cmd_R23_Sw31 , cmd_R24_Sw31 , cmd_R25_Sw31 , cmd_R25_Sw33 , cmd_R26_Sw31 , cmd_R26_Sw33 , cmd_R27_Sw27 , cmd_R27_Sw29 : routeCommands;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_J05 , cmd_R4_J06 , cmd_R5_J07 , cmd_R6_J09 , cmd_R7_J10 , cmd_R8_J11 , cmd_R9_J12 , cmd_R10_J13 , cmd_R11_J14 , cmd_R12_J16 , cmd_R13_J17 , cmd_R14_J21 , cmd_R15_J24 , cmd_R16_J25 , cmd_R17_J26 , cmd_R18_X31 , cmd_R19_X33 , cmd_R20_S36 , cmd_R21_S36 , cmd_R22_S36 , cmd_R23_C41 , cmd_R24_S42 , cmd_R25_S42 , cmd_R26_S42 , cmd_R27_B46 : routeCommands;
begin
	levelCrossing_Lc10 : levelCrossing_0 port map(clock => clock, reset => reset, R12_command => cmd_R12_Lc10, R18_command => cmd_R18_Lc10, ocupation_ne46 => ocupation(2), ocupation_ne3 => ocupation(0), ocupation_ne40 => ocupation(1), indication => levelCrossings_i(0), command  => levelCrossings_o(0), lock_Lc10 => Lc10_locking, correspondence_Lc10 => state_Lc10);
	levelCrossing_Lc11 : levelCrossing_1 port map(clock => clock, reset => reset, R3_command => cmd_R3_Lc11, R9_command => cmd_R9_Lc11, R19_command => cmd_R19_Lc11, ocupation_ne49 => ocupation(4), ocupation_ne48 => ocupation(3), ocupation_ne53 => ocupation(6), indication => levelCrossings_i(1), command  => levelCrossings_o(1), lock_Lc11 => Lc11_locking, correspondence_Lc11 => state_Lc11);
	levelCrossing_Lc09 : levelCrossing_2 port map(clock => clock, reset => reset, R5_command => cmd_R5_Lc09, R11_command => cmd_R11_Lc09, ocupation_ne50 => ocupation(5), ocupation_ne48 => ocupation(3), ocupation_ne53 => ocupation(6), indication => levelCrossings_i(2), command  => levelCrossings_o(2), lock_Lc09 => Lc09_locking, correspondence_Lc09 => state_Lc09);
	singleSwitch_Sw31 : singleSwitch_0 port map(clock => clock, reset => reset, R8_command => cmd_R8_Sw31, R10_command => cmd_R10_Sw31, R19_command => cmd_R19_Sw31, R23_command => cmd_R23_Sw31, R24_command => cmd_R24_Sw31, R25_command => cmd_R25_Sw31, R26_command => cmd_R26_Sw31, indication => singleSwitches_i(0), command => singleSwitches_o(0), lock_Sw31 => Sw31_locking, correspondence_Sw31 => state_Sw31);
	singleSwitch_Sw27 : singleSwitch_1 port map(clock => clock, reset => reset, R4_command => cmd_R4_Sw27, R7_command => cmd_R7_Sw27, R20_command => cmd_R20_Sw27, R21_command => cmd_R21_Sw27, R22_command => cmd_R22_Sw27, R27_command => cmd_R27_Sw27, indication => singleSwitches_i(1), command => singleSwitches_o(1), lock_Sw27 => Sw27_locking, correspondence_Sw27 => state_Sw27);
	singleSwitch_Sw29 : singleSwitch_2 port map(clock => clock, reset => reset, R4_command => cmd_R4_Sw29, R21_command => cmd_R21_Sw29, R22_command => cmd_R22_Sw29, R27_command => cmd_R27_Sw29, indication => singleSwitches_i(2), command => singleSwitches_o(2), lock_Sw29 => Sw29_locking, correspondence_Sw29 => state_Sw29);
	singleSwitch_Sw33 : singleSwitch_3 port map(clock => clock, reset => reset, R8_command => cmd_R8_Sw33, R10_command => cmd_R10_Sw33, R19_command => cmd_R19_Sw33, R25_command => cmd_R25_Sw33, R26_command => cmd_R26_Sw33, indication => singleSwitches_i(3), command => singleSwitches_o(3), lock_Sw33 => Sw33_locking, correspondence_Sw33 => state_Sw33);
	railwaySignal_T01 : railwaySignal_0 port map(clock => clock, reset => reset, ocupation_ne3 => ocupation(0), indication.msb => signals_i.msb(0), indication.lsb => signals_i.lsb(0), command.msb => signals_o.msb(0), command.lsb => signals_o.lsb(0), lock_T01 => T01_locking, correspondence_T01 => state_T01);
	railwaySignal_T02 : railwaySignal_1 port map(clock => clock, reset => reset, R1_command => cmd_R1_T02, ocupation_ne3 => ocupation(0), ocupation_ne53 => ocupation(6), ocupation_ne49 => ocupation(4), ocupation_ne50 => ocupation(5), ocupation_ne46 => ocupation(2), correspondence_S42 => state_S42, correspondence_J16 => state_J16, correspondence_J12 => state_J12, correspondence_J14 => state_J14, Sw31_state => state_Sw31, Sw33_state => state_Sw33, indication.msb => signals_i.msb(1), indication.lsb => signals_i.lsb(1), command.msb => signals_o.msb(1), command.lsb => signals_o.lsb(1), lock_T02 => T02_locking, correspondence_T02 => state_T02);
	railwaySignal_J17 : railwaySignal_2 port map(clock => clock, reset => reset, R13_command => cmd_R13_J17, ocupation_ne3 => ocupation(0), correspondence_J21 => state_J21, correspondence_T01 => state_T01, indication.msb => signals_i.msb(2), indication.lsb => signals_i.lsb(2), command.msb => signals_o.msb(2), command.lsb => signals_o.lsb(2), lock_J17 => J17_locking, correspondence_J17 => state_J17);
	railwaySignal_J21 : railwaySignal_3 port map(clock => clock, reset => reset, R14_command => cmd_R14_J21, ocupation_ne3 => ocupation(0), correspondence_T01 => state_T01, indication.msb => signals_i.msb(3), indication.lsb => signals_i.lsb(3), command.msb => signals_o.msb(3), command.lsb => signals_o.lsb(3), lock_J21 => J21_locking, correspondence_J21 => state_J21);
	railwaySignal_S42 : railwaySignal_4 port map(clock => clock, reset => reset, R24_command => cmd_R24_S42, R25_command => cmd_R25_S42, R26_command => cmd_R26_S42, ocupation_ne3 => ocupation(0), ocupation_ne46 => ocupation(2), ocupation_ne53 => ocupation(6), ocupation_ne49 => ocupation(4), ocupation_ne50 => ocupation(5), correspondence_J16 => state_J16, correspondence_J12 => state_J12, correspondence_J14 => state_J14, correspondence_J10 => state_J10, correspondence_J06 => state_J06, correspondence_B46 => state_B46, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc10_state => state_Lc10, Lc11_state => state_Lc11, Lc09_state => state_Lc09, indication.msb => signals_i.msb(4), indication.lsb => signals_i.lsb(4), command.msb => signals_o.msb(4), command.lsb => signals_o.lsb(4), lock_S42 => S42_locking, correspondence_S42 => state_S42);
	railwaySignal_T03 : railwaySignal_5 port map(clock => clock, reset => reset, ocupation_ne40 => ocupation(1), indication.msb => signals_i.msb(5), indication.lsb => signals_i.lsb(5), command.msb => signals_o.msb(5), command.lsb => signals_o.lsb(5), lock_T03 => T03_locking, correspondence_T03 => state_T03);
	railwaySignal_T04 : railwaySignal_6 port map(clock => clock, reset => reset, R2_command => cmd_R2_T04, ocupation_ne40 => ocupation(1), correspondence_J25 => state_J25, correspondence_S36 => state_S36, indication.msb => signals_i.msb(6), indication.lsb => signals_i.lsb(6), command.msb => signals_o.msb(6), command.lsb => signals_o.lsb(6), lock_T04 => T04_locking, correspondence_T04 => state_T04);
	railwaySignal_J24 : railwaySignal_7 port map(clock => clock, reset => reset, R15_command => cmd_R15_J24, ocupation_ne40 => ocupation(1), correspondence_J26 => state_J26, correspondence_T03 => state_T03, indication.msb => signals_i.msb(7), indication.lsb => signals_i.lsb(7), command.msb => signals_o.msb(7), command.lsb => signals_o.lsb(7), lock_J24 => J24_locking, correspondence_J24 => state_J24);
	railwaySignal_J25 : railwaySignal_8 port map(clock => clock, reset => reset, R16_command => cmd_R16_J25, ocupation_ne40 => ocupation(1), ocupation_ne49 => ocupation(4), ocupation_ne48 => ocupation(3), ocupation_ne50 => ocupation(5), ocupation_ne46 => ocupation(2), correspondence_S36 => state_S36, correspondence_J09 => state_J09, correspondence_J05 => state_J05, correspondence_J07 => state_J07, Sw27_state => state_Sw27, Sw29_state => state_Sw29, indication.msb => signals_i.msb(8), indication.lsb => signals_i.lsb(8), command.msb => signals_o.msb(8), command.lsb => signals_o.lsb(8), lock_J25 => J25_locking, correspondence_J25 => state_J25);
	railwaySignal_J26 : railwaySignal_9 port map(clock => clock, reset => reset, R17_command => cmd_R17_J26, ocupation_ne40 => ocupation(1), correspondence_T03 => state_T03, indication.msb => signals_i.msb(9), indication.lsb => signals_i.lsb(9), command.msb => signals_o.msb(9), command.lsb => signals_o.lsb(9), lock_J26 => J26_locking, correspondence_J26 => state_J26);
	railwaySignal_S36 : railwaySignal_10 port map(clock => clock, reset => reset, R20_command => cmd_R20_S36, R21_command => cmd_R21_S36, R22_command => cmd_R22_S36, ocupation_ne40 => ocupation(1), ocupation_ne46 => ocupation(2), ocupation_ne48 => ocupation(3), ocupation_ne49 => ocupation(4), ocupation_ne50 => ocupation(5), correspondence_J09 => state_J09, correspondence_J05 => state_J05, correspondence_J07 => state_J07, correspondence_X31 => state_X31, correspondence_J11 => state_J11, correspondence_J13 => state_J13, Sw27_state => state_Sw27, Sw29_state => state_Sw29, Lc11_state => state_Lc11, Lc09_state => state_Lc09, indication.msb => signals_i.msb(10), indication.lsb => signals_i.lsb(10), command.msb => signals_o.msb(10), command.lsb => signals_o.lsb(10), lock_S36 => S36_locking, correspondence_S36 => state_S36);
	railwaySignal_J09 : railwaySignal_11 port map(clock => clock, reset => reset, R6_command => cmd_R6_J09, ocupation_ne46 => ocupation(2), correspondence_X31 => state_X31, correspondence_C41 => state_C41, indication.msb => signals_i.msb(11), indication.lsb => signals_i.lsb(11), command.msb => signals_o.msb(11), command.lsb => signals_o.lsb(11), lock_J09 => J09_locking, correspondence_J09 => state_J09);
	railwaySignal_J10 : railwaySignal_12 port map(clock => clock, reset => reset, R7_command => cmd_R7_J10, ocupation_ne46 => ocupation(2), ocupation_ne40 => ocupation(1), correspondence_J24 => state_J24, correspondence_J26 => state_J26, Sw27_state => state_Sw27, indication.msb => signals_i.msb(12), indication.lsb => signals_i.lsb(12), command.msb => signals_o.msb(12), command.lsb => signals_o.lsb(12), lock_J10 => J10_locking, correspondence_J10 => state_J10);
	railwaySignal_J16 : railwaySignal_13 port map(clock => clock, reset => reset, R12_command => cmd_R12_J16, ocupation_ne46 => ocupation(2), ocupation_ne40 => ocupation(1), correspondence_J10 => state_J10, correspondence_J24 => state_J24, Sw27_state => state_Sw27, Lc10_state => state_Lc10, indication.msb => signals_i.msb(13), indication.lsb => signals_i.lsb(13), command.msb => signals_o.msb(13), command.lsb => signals_o.lsb(13), lock_J16 => J16_locking, correspondence_J16 => state_J16);
	railwaySignal_X31 : railwaySignal_14 port map(clock => clock, reset => reset, R18_command => cmd_R18_X31, ocupation_ne46 => ocupation(2), ocupation_ne3 => ocupation(0), correspondence_C41 => state_C41, correspondence_J17 => state_J17, Sw31_state => state_Sw31, Lc10_state => state_Lc10, indication.msb => signals_i.msb(14), indication.lsb => signals_i.lsb(14), command.msb => signals_o.msb(14), command.lsb => signals_o.lsb(14), lock_X31 => X31_locking, correspondence_X31 => state_X31);
	railwaySignal_C41 : railwaySignal_15 port map(clock => clock, reset => reset, R23_command => cmd_R23_C41, ocupation_ne46 => ocupation(2), ocupation_ne3 => ocupation(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, indication.msb => signals_i.msb(15), indication.lsb => signals_i.lsb(15), command.msb => signals_o.msb(15), command.lsb => signals_o.lsb(15), lock_C41 => C41_locking, correspondence_C41 => state_C41);
	railwaySignal_J05 : railwaySignal_16 port map(clock => clock, reset => reset, R3_command => cmd_R3_J05, ocupation_ne49 => ocupation(4), ocupation_ne53 => ocupation(6), ocupation_ne3 => ocupation(0), correspondence_J11 => state_J11, correspondence_J17 => state_J17, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc11_state => state_Lc11, indication.msb => signals_i.msb(16), indication.lsb => signals_i.lsb(16), command.msb => signals_o.msb(16), command.lsb => signals_o.lsb(16), lock_J05 => J05_locking, correspondence_J05 => state_J05);
	railwaySignal_J06 : railwaySignal_17 port map(clock => clock, reset => reset, R4_command => cmd_R4_J06, ocupation_ne49 => ocupation(4), ocupation_ne48 => ocupation(3), ocupation_ne40 => ocupation(1), correspondence_J24 => state_J24, correspondence_J26 => state_J26, Sw27_state => state_Sw27, Sw29_state => state_Sw29, indication.msb => signals_i.msb(17), indication.lsb => signals_i.lsb(17), command.msb => signals_o.msb(17), command.lsb => signals_o.lsb(17), lock_J06 => J06_locking, correspondence_J06 => state_J06);
	railwaySignal_J11 : railwaySignal_18 port map(clock => clock, reset => reset, R8_command => cmd_R8_J11, ocupation_ne49 => ocupation(4), ocupation_ne53 => ocupation(6), ocupation_ne3 => ocupation(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, Sw33_state => state_Sw33, indication.msb => signals_i.msb(18), indication.lsb => signals_i.lsb(18), command.msb => signals_o.msb(18), command.lsb => signals_o.lsb(18), lock_J11 => J11_locking, correspondence_J11 => state_J11);
	railwaySignal_J12 : railwaySignal_19 port map(clock => clock, reset => reset, R9_command => cmd_R9_J12, ocupation_ne49 => ocupation(4), ocupation_ne48 => ocupation(3), ocupation_ne40 => ocupation(1), correspondence_J06 => state_J06, correspondence_J24 => state_J24, Sw27_state => state_Sw27, Sw29_state => state_Sw29, Lc11_state => state_Lc11, indication.msb => signals_i.msb(19), indication.lsb => signals_i.lsb(19), command.msb => signals_o.msb(19), command.lsb => signals_o.lsb(19), lock_J12 => J12_locking, correspondence_J12 => state_J12);
	railwaySignal_X33 : railwaySignal_20 port map(clock => clock, reset => reset, R19_command => cmd_R19_X33, ocupation_ne49 => ocupation(4), ocupation_ne53 => ocupation(6), ocupation_ne3 => ocupation(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc11_state => state_Lc11, indication.msb => signals_i.msb(20), indication.lsb => signals_i.lsb(20), command.msb => signals_o.msb(20), command.lsb => signals_o.lsb(20), lock_X33 => X33_locking, correspondence_X33 => state_X33);
	railwaySignal_J07 : railwaySignal_21 port map(clock => clock, reset => reset, R5_command => cmd_R5_J07, ocupation_ne50 => ocupation(5), ocupation_ne53 => ocupation(6), ocupation_ne3 => ocupation(0), correspondence_J13 => state_J13, correspondence_J17 => state_J17, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc09_state => state_Lc09, indication.msb => signals_i.msb(21), indication.lsb => signals_i.lsb(21), command.msb => signals_o.msb(21), command.lsb => signals_o.lsb(21), lock_J07 => J07_locking, correspondence_J07 => state_J07);
	railwaySignal_J13 : railwaySignal_22 port map(clock => clock, reset => reset, R10_command => cmd_R10_J13, ocupation_ne50 => ocupation(5), ocupation_ne53 => ocupation(6), ocupation_ne3 => ocupation(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, Sw33_state => state_Sw33, indication.msb => signals_i.msb(22), indication.lsb => signals_i.lsb(22), command.msb => signals_o.msb(22), command.lsb => signals_o.lsb(22), lock_J13 => J13_locking, correspondence_J13 => state_J13);
	railwaySignal_J14 : railwaySignal_23 port map(clock => clock, reset => reset, R11_command => cmd_R11_J14, ocupation_ne50 => ocupation(5), ocupation_ne48 => ocupation(3), ocupation_ne40 => ocupation(1), correspondence_B46 => state_B46, correspondence_J24 => state_J24, Sw27_state => state_Sw27, Sw29_state => state_Sw29, Lc09_state => state_Lc09, indication.msb => signals_i.msb(23), indication.lsb => signals_i.lsb(23), command.msb => signals_o.msb(23), command.lsb => signals_o.lsb(23), lock_J14 => J14_locking, correspondence_J14 => state_J14);
	railwaySignal_B46 : railwaySignal_24 port map(clock => clock, reset => reset, R27_command => cmd_R27_B46, ocupation_ne50 => ocupation(5), ocupation_ne48 => ocupation(3), ocupation_ne40 => ocupation(1), correspondence_J24 => state_J24, correspondence_J26 => state_J26, Sw27_state => state_Sw27, Sw29_state => state_Sw29, indication.msb => signals_i.msb(24), indication.lsb => signals_i.lsb(24), command.msb => signals_o.msb(24), command.lsb => signals_o.lsb(24), lock_B46 => B46_locking, correspondence_B46 => state_B46);
	node_ne3 : node_0 port map(clock => clock, ocupation => ocupation(0), reset => reset, R1_command => cmd_R1_ne3, R8_command => cmd_R8_ne3, R10_command => cmd_R10_ne3, R13_command => cmd_R13_ne3, R14_command => cmd_R14_ne3, R19_command => cmd_R19_ne3, R23_command => cmd_R23_ne3, R24_command => cmd_R24_ne3, R25_command => cmd_R25_ne3, R26_command => cmd_R26_ne3, state => state_ne3, locking => ne3_locking);
	node_ne40 : node_1 port map(clock => clock, ocupation => ocupation(1), reset => reset, R2_command => cmd_R2_ne40, R4_command => cmd_R4_ne40, R7_command => cmd_R7_ne40, R15_command => cmd_R15_ne40, R16_command => cmd_R16_ne40, R17_command => cmd_R17_ne40, R20_command => cmd_R20_ne40, R21_command => cmd_R21_ne40, R22_command => cmd_R22_ne40, R27_command => cmd_R27_ne40, state => state_ne40, locking => ne40_locking);
	node_ne46 : node_2 port map(clock => clock, ocupation => ocupation(2), reset => reset, R6_command => cmd_R6_ne46, R7_command => cmd_R7_ne46, R12_command => cmd_R12_ne46, R18_command => cmd_R18_ne46, R20_command => cmd_R20_ne46, R23_command => cmd_R23_ne46, R24_command => cmd_R24_ne46, state => state_ne46, locking => ne46_locking);
	node_ne48 : node_3 port map(clock => clock, ocupation => ocupation(3), reset => reset, R4_command => cmd_R4_ne48, R21_command => cmd_R21_ne48, R22_command => cmd_R22_ne48, R27_command => cmd_R27_ne48, state => state_ne48, locking => ne48_locking);
	node_ne49 : node_4 port map(clock => clock, ocupation => ocupation(4), reset => reset, R3_command => cmd_R3_ne49, R4_command => cmd_R4_ne49, R8_command => cmd_R8_ne49, R9_command => cmd_R9_ne49, R19_command => cmd_R19_ne49, R21_command => cmd_R21_ne49, R25_command => cmd_R25_ne49, state => state_ne49, locking => ne49_locking);
	node_ne50 : node_5 port map(clock => clock, ocupation => ocupation(5), reset => reset, R5_command => cmd_R5_ne50, R10_command => cmd_R10_ne50, R11_command => cmd_R11_ne50, R22_command => cmd_R22_ne50, R26_command => cmd_R26_ne50, R27_command => cmd_R27_ne50, state => state_ne50, locking => ne50_locking);
	node_ne53 : node_6 port map(clock => clock, ocupation => ocupation(6), reset => reset, R8_command => cmd_R8_ne53, R10_command => cmd_R10_ne53, R19_command => cmd_R19_ne53, R25_command => cmd_R25_ne53, R26_command => cmd_R26_ne53, state => state_ne53, locking => ne53_locking);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), reset => reset, ne3_command => cmd_R1_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, T02_state => state_T02, T02_lock => T02_locking, T02_command => cmd_R1_T02, S42_state => state_S42, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), reset => reset, ne40_command => cmd_R2_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, T04_state => state_T04, T04_lock => T04_locking, T04_command => cmd_R2_T04, J25_state => state_J25, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), reset => reset, ne49_command => cmd_R3_ne49, ne49_state => state_ne49, ne49_lock => ne49_locking, Lc11_command => cmd_R3_Lc11, Lc11_state => state_Lc11, Lc11_lock => Lc11_locking, J05_state => state_J05, J05_lock => J05_locking, J05_command => cmd_R3_J05, J11_state => state_J11, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), reset => reset, ne40_command => cmd_R4_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, ne48_command => cmd_R4_ne48, ne48_state => state_ne48, ne48_lock => ne48_locking, ne49_command => cmd_R4_ne49, ne49_state => state_ne49, ne49_lock => ne49_locking, Sw27_command => cmd_R4_Sw27, Sw27_state => state_Sw27, Sw27_lock => Sw27_locking, Sw29_command => cmd_R4_Sw29, Sw29_state => state_Sw29, Sw29_lock => Sw29_locking, J06_state => state_J06, J06_lock => J06_locking, J06_command => cmd_R4_J06, J24_state => state_J24, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), reset => reset, ne50_command => cmd_R5_ne50, ne50_state => state_ne50, ne50_lock => ne50_locking, Lc09_command => cmd_R5_Lc09, Lc09_state => state_Lc09, Lc09_lock => Lc09_locking, J07_state => state_J07, J07_lock => J07_locking, J07_command => cmd_R5_J07, J13_state => state_J13, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), reset => reset, ne46_command => cmd_R6_ne46, ne46_state => state_ne46, ne46_lock => ne46_locking, J09_state => state_J09, J09_lock => J09_locking, J09_command => cmd_R6_J09, X31_state => state_X31, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), reset => reset, ne40_command => cmd_R7_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, ne46_command => cmd_R7_ne46, ne46_state => state_ne46, ne46_lock => ne46_locking, Sw27_command => cmd_R7_Sw27, Sw27_state => state_Sw27, Sw27_lock => Sw27_locking, J10_state => state_J10, J10_lock => J10_locking, J10_command => cmd_R7_J10, J24_state => state_J24, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), reset => reset, ne3_command => cmd_R8_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne49_command => cmd_R8_ne49, ne49_state => state_ne49, ne49_lock => ne49_locking, ne53_command => cmd_R8_ne53, ne53_state => state_ne53, ne53_lock => ne53_locking, Sw31_command => cmd_R8_Sw31, Sw31_state => state_Sw31, Sw31_lock => Sw31_locking, Sw33_command => cmd_R8_Sw33, Sw33_state => state_Sw33, Sw33_lock => Sw33_locking, J11_state => state_J11, J11_lock => J11_locking, J11_command => cmd_R8_J11, J17_state => state_J17, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), reset => reset, ne49_command => cmd_R9_ne49, ne49_state => state_ne49, ne49_lock => ne49_locking, Lc11_command => cmd_R9_Lc11, Lc11_state => state_Lc11, Lc11_lock => Lc11_locking, J12_state => state_J12, J12_lock => J12_locking, J12_command => cmd_R9_J12, J06_state => state_J06, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), reset => reset, ne3_command => cmd_R10_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne50_command => cmd_R10_ne50, ne50_state => state_ne50, ne50_lock => ne50_locking, ne53_command => cmd_R10_ne53, ne53_state => state_ne53, ne53_lock => ne53_locking, Sw31_command => cmd_R10_Sw31, Sw31_state => state_Sw31, Sw31_lock => Sw31_locking, Sw33_command => cmd_R10_Sw33, Sw33_state => state_Sw33, Sw33_lock => Sw33_locking, J13_state => state_J13, J13_lock => J13_locking, J13_command => cmd_R10_J13, J17_state => state_J17, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), reset => reset, ne50_command => cmd_R11_ne50, ne50_state => state_ne50, ne50_lock => ne50_locking, Lc09_command => cmd_R11_Lc09, Lc09_state => state_Lc09, Lc09_lock => Lc09_locking, J14_state => state_J14, J14_lock => J14_locking, J14_command => cmd_R11_J14, B46_state => state_B46, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), reset => reset, ne46_command => cmd_R12_ne46, ne46_state => state_ne46, ne46_lock => ne46_locking, Lc10_command => cmd_R12_Lc10, Lc10_state => state_Lc10, Lc10_lock => Lc10_locking, J16_state => state_J16, J16_lock => J16_locking, J16_command => cmd_R12_J16, J10_state => state_J10, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), reset => reset, ne3_command => cmd_R13_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, J17_state => state_J17, J17_lock => J17_locking, J17_command => cmd_R13_J17, J21_state => state_J21, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), reset => reset, ne3_command => cmd_R14_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, J21_state => state_J21, J21_lock => J21_locking, J21_command => cmd_R14_J21, T01_state => state_T01, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), reset => reset, ne40_command => cmd_R15_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, J24_state => state_J24, J24_lock => J24_locking, J24_command => cmd_R15_J24, J26_state => state_J26, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), reset => reset, ne40_command => cmd_R16_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, J25_state => state_J25, J25_lock => J25_locking, J25_command => cmd_R16_J25, S36_state => state_S36, routeState => routes_o(15));
	route_R17 : route_16 port map(clock => clock, routeRequest => routes_i(16), reset => reset, ne40_command => cmd_R17_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, J26_state => state_J26, J26_lock => J26_locking, J26_command => cmd_R17_J26, T03_state => state_T03, routeState => routes_o(16));
	route_R18 : route_17 port map(clock => clock, routeRequest => routes_i(17), reset => reset, ne46_command => cmd_R18_ne46, ne46_state => state_ne46, ne46_lock => ne46_locking, Lc10_command => cmd_R18_Lc10, Lc10_state => state_Lc10, Lc10_lock => Lc10_locking, X31_state => state_X31, X31_lock => X31_locking, X31_command => cmd_R18_X31, C41_state => state_C41, routeState => routes_o(17));
	route_R19 : route_18 port map(clock => clock, routeRequest => routes_i(18), reset => reset, ne3_command => cmd_R19_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne49_command => cmd_R19_ne49, ne49_state => state_ne49, ne49_lock => ne49_locking, ne53_command => cmd_R19_ne53, ne53_state => state_ne53, ne53_lock => ne53_locking, Lc11_command => cmd_R19_Lc11, Lc11_state => state_Lc11, Lc11_lock => Lc11_locking, Sw31_command => cmd_R19_Sw31, Sw31_state => state_Sw31, Sw31_lock => Sw31_locking, Sw33_command => cmd_R19_Sw33, Sw33_state => state_Sw33, Sw33_lock => Sw33_locking, X33_state => state_X33, X33_lock => X33_locking, X33_command => cmd_R19_X33, J17_state => state_J17, routeState => routes_o(18));
	route_R20 : route_19 port map(clock => clock, routeRequest => routes_i(19), reset => reset, ne40_command => cmd_R20_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, ne46_command => cmd_R20_ne46, ne46_state => state_ne46, ne46_lock => ne46_locking, Sw27_command => cmd_R20_Sw27, Sw27_state => state_Sw27, Sw27_lock => Sw27_locking, S36_state => state_S36, S36_lock => S36_locking, S36_command => cmd_R20_S36, J09_state => state_J09, routeState => routes_o(19));
	route_R21 : route_20 port map(clock => clock, routeRequest => routes_i(20), reset => reset, ne40_command => cmd_R21_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, ne48_command => cmd_R21_ne48, ne48_state => state_ne48, ne48_lock => ne48_locking, ne49_command => cmd_R21_ne49, ne49_state => state_ne49, ne49_lock => ne49_locking, Sw27_command => cmd_R21_Sw27, Sw27_state => state_Sw27, Sw27_lock => Sw27_locking, Sw29_command => cmd_R21_Sw29, Sw29_state => state_Sw29, Sw29_lock => Sw29_locking, S36_state => state_S36, S36_lock => S36_locking, S36_command => cmd_R21_S36, J05_state => state_J05, routeState => routes_o(20));
	route_R22 : route_21 port map(clock => clock, routeRequest => routes_i(21), reset => reset, ne40_command => cmd_R22_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, ne48_command => cmd_R22_ne48, ne48_state => state_ne48, ne48_lock => ne48_locking, ne50_command => cmd_R22_ne50, ne50_state => state_ne50, ne50_lock => ne50_locking, Sw27_command => cmd_R22_Sw27, Sw27_state => state_Sw27, Sw27_lock => Sw27_locking, Sw29_command => cmd_R22_Sw29, Sw29_state => state_Sw29, Sw29_lock => Sw29_locking, S36_state => state_S36, S36_lock => S36_locking, S36_command => cmd_R22_S36, J07_state => state_J07, routeState => routes_o(21));
	route_R23 : route_22 port map(clock => clock, routeRequest => routes_i(22), reset => reset, ne3_command => cmd_R23_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne46_command => cmd_R23_ne46, ne46_state => state_ne46, ne46_lock => ne46_locking, Sw31_command => cmd_R23_Sw31, Sw31_state => state_Sw31, Sw31_lock => Sw31_locking, C41_state => state_C41, C41_lock => C41_locking, C41_command => cmd_R23_C41, J17_state => state_J17, routeState => routes_o(22));
	route_R24 : route_23 port map(clock => clock, routeRequest => routes_i(23), reset => reset, ne3_command => cmd_R24_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne46_command => cmd_R24_ne46, ne46_state => state_ne46, ne46_lock => ne46_locking, Sw31_command => cmd_R24_Sw31, Sw31_state => state_Sw31, Sw31_lock => Sw31_locking, S42_state => state_S42, S42_lock => S42_locking, S42_command => cmd_R24_S42, J16_state => state_J16, routeState => routes_o(23));
	route_R25 : route_24 port map(clock => clock, routeRequest => routes_i(24), reset => reset, ne3_command => cmd_R25_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne49_command => cmd_R25_ne49, ne49_state => state_ne49, ne49_lock => ne49_locking, ne53_command => cmd_R25_ne53, ne53_state => state_ne53, ne53_lock => ne53_locking, Sw31_command => cmd_R25_Sw31, Sw31_state => state_Sw31, Sw31_lock => Sw31_locking, Sw33_command => cmd_R25_Sw33, Sw33_state => state_Sw33, Sw33_lock => Sw33_locking, S42_state => state_S42, S42_lock => S42_locking, S42_command => cmd_R25_S42, J12_state => state_J12, routeState => routes_o(24));
	route_R26 : route_25 port map(clock => clock, routeRequest => routes_i(25), reset => reset, ne3_command => cmd_R26_ne3, ne3_state => state_ne3, ne3_lock => ne3_locking, ne50_command => cmd_R26_ne50, ne50_state => state_ne50, ne50_lock => ne50_locking, ne53_command => cmd_R26_ne53, ne53_state => state_ne53, ne53_lock => ne53_locking, Sw31_command => cmd_R26_Sw31, Sw31_state => state_Sw31, Sw31_lock => Sw31_locking, Sw33_command => cmd_R26_Sw33, Sw33_state => state_Sw33, Sw33_lock => Sw33_locking, S42_state => state_S42, S42_lock => S42_locking, S42_command => cmd_R26_S42, J14_state => state_J14, routeState => routes_o(25));
	route_R27 : route_26 port map(clock => clock, routeRequest => routes_i(26), reset => reset, ne40_command => cmd_R27_ne40, ne40_state => state_ne40, ne40_lock => ne40_locking, ne48_command => cmd_R27_ne48, ne48_state => state_ne48, ne48_lock => ne48_locking, ne50_command => cmd_R27_ne50, ne50_state => state_ne50, ne50_lock => ne50_locking, Sw27_command => cmd_R27_Sw27, Sw27_state => state_Sw27, Sw27_lock => Sw27_locking, Sw29_command => cmd_R27_Sw29, Sw29_state => state_Sw29, Sw29_lock => Sw29_locking, B46_state => state_B46, B46_lock => B46_locking, B46_command => cmd_R27_B46, J24_state => state_J24, routeState => routes_o(26));
	processed <= processing;
end Behavioral;