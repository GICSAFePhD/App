--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 329;
			N_SIGNALS : natural := 82;
			N_ROUTES : natural := 91;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLEWITCHES : natural := 2;
			N_SCISSORCROSSINGS : natural := 1;
			N_TRACKCIRCUITS : natural := 53
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
			scissorCrossings_i : in std_logic;
			scissorCrossings_o : out std_logic;
			doubleSwitches_i : in dSwitches_type;
			doubleSwitches_o : out dSwitches_type;
			reset : in std_logic
		);
	end entity network;
architecture Behavioral of network is
	component levelCrossing_0 is
		port(
			clock : in std_logic;
			ocupation_ne95 : in std_logic;
			ocupation_ne9 : in std_logic;
			ocupation_ne59 : in std_logic;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc01 : out levelCrossingStates
		);
	end component levelCrossing_0;
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			R23_command : in routeCommands;
			R38_command : in routeCommands;
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_68W02 : out singleSwitchStates
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			R41_command : in routeCommands;
			R42_command : in routeCommands;
			R43_command : in routeCommands;
			R44_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_69W03 : out singleSwitchStates
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			R3_command : in routeCommands;
			R42_command : in routeCommands;
			R44_command : in routeCommands;
			R45_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_69W04 : out singleSwitchStates
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic;
			R36_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R89_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw06 : out singleSwitchStates
		);
	end component singleSwitch_3;
	component singleSwitch_4 is
		port(
			clock : in std_logic;
			R27_command : in routeCommands;
			R48_command : in routeCommands;
			R50_command : in routeCommands;
			R51_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_70W02 : out singleSwitchStates
		);
	end component singleSwitch_4;
	component singleSwitch_5 is
		port(
			clock : in std_logic;
			R28_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R48_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_70W01 : out singleSwitchStates
		);
	end component singleSwitch_5;
	component singleSwitch_6 is
		port(
			clock : in std_logic;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R59_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw09 : out singleSwitchStates
		);
	end component singleSwitch_6;
	component singleSwitch_7 is
		port(
			clock : in std_logic;
			R52_command : in routeCommands;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R55_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw08 : out singleSwitchStates
		);
	end component singleSwitch_7;
	component singleSwitch_8 is
		port(
			clock : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R73_command : in routeCommands;
			R74_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw12 : out singleSwitchStates
		);
	end component singleSwitch_8;
	component singleSwitch_9 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R67_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R77_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw04 : out singleSwitchStates
		);
	end component singleSwitch_9;
	component singleSwitch_10 is
		port(
			clock : in std_logic;
			R60_command : in routeCommands;
			R61_command : in routeCommands;
			R62_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_71W01 : out singleSwitchStates
		);
	end component singleSwitch_10;
	component singleSwitch_11 is
		port(
			clock : in std_logic;
			R4_command : in routeCommands;
			R61_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_71W02 : out singleSwitchStates
		);
	end component singleSwitch_11;
	component singleSwitch_12 is
		port(
			clock : in std_logic;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw11 : out singleSwitchStates
		);
	end component singleSwitch_12;
	component singleSwitch_13 is
		port(
			clock : in std_logic;
			R8_command : in routeCommands;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw13 : out singleSwitchStates
		);
	end component singleSwitch_13;
	component singleSwitch_14 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			R86_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw41 : out singleSwitchStates
		);
	end component singleSwitch_14;
	component doubleSwitch is
		port(
			clock : in std_logic;
			indication : in dSwitch_type;
			command_in : in dSwitch_type;
			command_out : out dSwitch_type;
			correspondence : out dSwitch_type
		);
	end component doubleSwitch;
	component railwaySignal is
		port(
			clock : in std_logic;
			indication : in signal_type;
			command_in : in signal_type;
			command_out : out signal_type;
			correspondence : out signal_type
		);
	end component railwaySignal;
	component node_0 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R38_command : in routeCommands;
			R39_command : in routeCommands;
			state : out nodeStates
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R10_command : in routeCommands;
			R32_command : in routeCommands;
			state : out nodeStates
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R23_command : in routeCommands;
			R40_command : in routeCommands;
			state : out nodeStates
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			R26_command : in routeCommands;
			R38_command : in routeCommands;
			R39_command : in routeCommands;
			R40_command : in routeCommands;
			state : out nodeStates
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R42_command : in routeCommands;
			R44_command : in routeCommands;
			state : out nodeStates
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R45_command : in routeCommands;
			state : out nodeStates
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R41_command : in routeCommands;
			R43_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			state : out nodeStates
		);
	end component node_6;
	component node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R27_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R48_command : in routeCommands;
			R50_command : in routeCommands;
			state : out nodeStates
		);
	end component node_7;
	component node_8 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R28_command : in routeCommands;
			R49_command : in routeCommands;
			R51_command : in routeCommands;
			state : out nodeStates
		);
	end component node_8;
	component node_9 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R11_command : in routeCommands;
			R27_command : in routeCommands;
			R48_command : in routeCommands;
			R50_command : in routeCommands;
			R51_command : in routeCommands;
			R62_command : in routeCommands;
			state : out nodeStates
		);
	end component node_9;
	component node_10 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R57_command : in routeCommands;
			R59_command : in routeCommands;
			state : out nodeStates
		);
	end component node_10;
	component node_11 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R52_command : in routeCommands;
			R53_command : in routeCommands;
			R54_command : in routeCommands;
			R55_command : in routeCommands;
			R73_command : in routeCommands;
			R74_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			state : out nodeStates
		);
	end component node_11;
	component node_12 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R67_command : in routeCommands;
			R68_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R77_command : in routeCommands;
			state : out nodeStates
		);
	end component node_12;
	component node_13 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R69_command : in routeCommands;
			R77_command : in routeCommands;
			R78_command : in routeCommands;
			R79_command : in routeCommands;
			state : out nodeStates
		);
	end component node_13;
	component node_14 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R61_command : in routeCommands;
			state : out nodeStates
		);
	end component node_14;
	component node_15 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R12_command : in routeCommands;
			R60_command : in routeCommands;
			R61_command : in routeCommands;
			R62_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			state : out nodeStates
		);
	end component node_15;
	component node_16 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			state : out nodeStates
		);
	end component node_16;
	component node_17 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R61_command : in routeCommands;
			state : out nodeStates
		);
	end component node_17;
	component node_18 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R25_command : in routeCommands;
			R41_command : in routeCommands;
			R42_command : in routeCommands;
			R43_command : in routeCommands;
			R44_command : in routeCommands;
			state : out nodeStates
		);
	end component node_18;
	component node_19 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R21_command : in routeCommands;
			R28_command : in routeCommands;
			R46_command : in routeCommands;
			R47_command : in routeCommands;
			R48_command : in routeCommands;
			state : out nodeStates
		);
	end component node_19;
	component node_20 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R11_command : in routeCommands;
			R13_command : in routeCommands;
			R62_command : in routeCommands;
			state : out nodeStates
		);
	end component node_20;
	component node_21 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R29_command : in routeCommands;
			R30_command : in routeCommands;
			state : out nodeStates
		);
	end component node_21;
	component node_22 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R14_command : in routeCommands;
			R29_command : in routeCommands;
			R87_command : in routeCommands;
			state : out nodeStates
		);
	end component node_22;
	component node_23 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R15_command : in routeCommands;
			R33_command : in routeCommands;
			R36_command : in routeCommands;
			R63_command : in routeCommands;
			R64_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R89_command : in routeCommands;
			state : out nodeStates
		);
	end component node_23;
	component node_24 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R36_command : in routeCommands;
			R65_command : in routeCommands;
			R66_command : in routeCommands;
			R89_command : in routeCommands;
			state : out nodeStates
		);
	end component node_24;
	component node_25 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R69_command : in routeCommands;
			R70_command : in routeCommands;
			R77_command : in routeCommands;
			state : out nodeStates
		);
	end component node_25;
	component node_26 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R52_command : in routeCommands;
			R55_command : in routeCommands;
			R67_command : in routeCommands;
			R68_command : in routeCommands;
			state : out nodeStates
		);
	end component node_26;
	component node_27 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R70_command : in routeCommands;
			R80_command : in routeCommands;
			state : out nodeStates
		);
	end component node_27;
	component node_28 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			state : out nodeStates
		);
	end component node_28;
	component node_29 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			state : out nodeStates
		);
	end component node_29;
	component node_30 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R71_command : in routeCommands;
			R72_command : in routeCommands;
			state : out nodeStates
		);
	end component node_30;
	component node_31 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R74_command : in routeCommands;
			state : out nodeStates
		);
	end component node_31;
	component node_32 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R76_command : in routeCommands;
			state : out nodeStates
		);
	end component node_32;
	component node_33 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R73_command : in routeCommands;
			R75_command : in routeCommands;
			R76_command : in routeCommands;
			state : out nodeStates
		);
	end component node_33;
	component node_34 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			R33_command : in routeCommands;
			state : out nodeStates
		);
	end component node_34;
	component node_35 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R18_command : in routeCommands;
			R37_command : in routeCommands;
			R82_command : in routeCommands;
			R83_command : in routeCommands;
			R90_command : in routeCommands;
			state : out nodeStates
		);
	end component node_35;
	component node_36 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R17_command : in routeCommands;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			R41_command : in routeCommands;
			R44_command : in routeCommands;
			state : out nodeStates
		);
	end component node_36;
	component node_37 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R9_command : in routeCommands;
			R16_command : in routeCommands;
			R33_command : in routeCommands;
			R34_command : in routeCommands;
			state : out nodeStates
		);
	end component node_37;
	component node_38 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R18_command : in routeCommands;
			R31_command : in routeCommands;
			R37_command : in routeCommands;
			R90_command : in routeCommands;
			state : out nodeStates
		);
	end component node_38;
	component node_39 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R9_command : in routeCommands;
			R19_command : in routeCommands;
			R34_command : in routeCommands;
			state : out nodeStates
		);
	end component node_39;
	component node_40 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R22_command : in routeCommands;
			R31_command : in routeCommands;
			R32_command : in routeCommands;
			R37_command : in routeCommands;
			R90_command : in routeCommands;
			state : out nodeStates
		);
	end component node_40;
	component node_41 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R20_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			R86_command : in routeCommands;
			state : out nodeStates
		);
	end component node_41;
	component node_42 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R12_command : in routeCommands;
			R20_command : in routeCommands;
			R78_command : in routeCommands;
			R84_command : in routeCommands;
			state : out nodeStates
		);
	end component node_42;
	component node_43 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R13_command : in routeCommands;
			R60_command : in routeCommands;
			R62_command : in routeCommands;
			state : out nodeStates
		);
	end component node_43;
	component node_44 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R21_command : in routeCommands;
			R28_command : in routeCommands;
			R30_command : in routeCommands;
			R46_command : in routeCommands;
			state : out nodeStates
		);
	end component node_44;
	component node_45 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R9_command : in routeCommands;
			R19_command : in routeCommands;
			state : out nodeStates
		);
	end component node_45;
	component node_46 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R10_command : in routeCommands;
			R22_command : in routeCommands;
			R32_command : in routeCommands;
			state : out nodeStates
		);
	end component node_46;
	component node_47 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R78_command : in routeCommands;
			R79_command : in routeCommands;
			R80_command : in routeCommands;
			R86_command : in routeCommands;
			state : out nodeStates
		);
	end component node_47;
	component node_48 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R65_command : in routeCommands;
			R81_command : in routeCommands;
			R82_command : in routeCommands;
			R89_command : in routeCommands;
			R90_command : in routeCommands;
			R91_command : in routeCommands;
			state : out nodeStates
		);
	end component node_48;
	component node_49 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R14_command : in routeCommands;
			R87_command : in routeCommands;
			R88_command : in routeCommands;
			state : out nodeStates
		);
	end component node_49;
	component node_50 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R42_command : in routeCommands;
			R44_command : in routeCommands;
			R45_command : in routeCommands;
			R81_command : in routeCommands;
			R91_command : in routeCommands;
			state : out nodeStates
		);
	end component node_50;
	component node_51 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R14_command : in routeCommands;
			R35_command : in routeCommands;
			R36_command : in routeCommands;
			R37_command : in routeCommands;
			R66_command : in routeCommands;
			R83_command : in routeCommands;
			R88_command : in routeCommands;
			state : out nodeStates
		);
	end component node_51;
	component node_52 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R54_command : in routeCommands;
			R56_command : in routeCommands;
			R58_command : in routeCommands;
			R59_command : in routeCommands;
			R84_command : in routeCommands;
			R85_command : in routeCommands;
			state : out nodeStates
		);
	end component node_52;
	component route_0 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			s69W04_state : in singleSwitchStates;
			s69W04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne47_state : in nodeStates;
			ne47_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_command : out routeCommands;
			s71W02_state : in singleSwitchStates;
			s71W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne84_state : in nodeStates;
			ne84_command : out routeCommands;
			ne82_state : in nodeStates;
			ne82_command : out routeCommands;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne84_state : in nodeStates;
			ne84_command : out routeCommands;
			ne85_state : in nodeStates;
			ne85_command : out routeCommands;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne89_state : in nodeStates;
			ne89_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne90_state : in nodeStates;
			ne90_command : out routeCommands;
			ne91_state : in nodeStates;
			ne91_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne105_state : in nodeStates;
			ne105_command : out routeCommands;
			ne98_state : in nodeStates;
			ne98_command : out routeCommands;
			ne96_state : in nodeStates;
			ne96_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne4_state : in nodeStates;
			ne4_command : out routeCommands;
			ne106_state : in nodeStates;
			ne106_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			ne65_state : in nodeStates;
			ne65_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne65_state : in nodeStates;
			ne65_command : out routeCommands;
			ne102_state : in nodeStates;
			ne102_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne70_state : in nodeStates;
			ne70_command : out routeCommands;
			ne104_state : in nodeStates;
			ne104_command : out routeCommands;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			ne93_state : in nodeStates;
			ne93_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne93_state : in nodeStates;
			ne93_command : out routeCommands;
			ne96_state : in nodeStates;
			ne96_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_15;
	component route_16 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_16;
	component route_17 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne97_state : in nodeStates;
			ne97_command : out routeCommands;
			ne94_state : in nodeStates;
			ne94_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_17;
	component route_18 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne98_state : in nodeStates;
			ne98_command : out routeCommands;
			ne105_state : in nodeStates;
			ne105_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_18;
	component route_19 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_19;
	component route_20 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne103_state : in nodeStates;
			ne103_command : out routeCommands;
			ne64_state : in nodeStates;
			ne64_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_20;
	component route_21 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne106_state : in nodeStates;
			ne106_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_21;
	component route_22 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			s68W02_state : in singleSwitchStates;
			s68W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_22;
	component route_23 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_23;
	component route_24 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			ne59_state : in nodeStates;
			ne59_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_24;
	component route_25 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_25;
	component route_26 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			s70W02_state : in singleSwitchStates;
			s70W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_26;
	component route_27 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne24_state : in nodeStates;
			ne24_command : out routeCommands;
			ne64_state : in nodeStates;
			ne64_command : out routeCommands;
			ne103_state : in nodeStates;
			ne103_command : out routeCommands;
			s70W01_state : in singleSwitchStates;
			s70W01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_27;
	component route_28 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne67_state : in nodeStates;
			ne67_command : out routeCommands;
			ne70_state : in nodeStates;
			ne70_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_28;
	component route_29 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne67_state : in nodeStates;
			ne67_command : out routeCommands;
			ne103_state : in nodeStates;
			ne103_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_29;
	component route_30 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			ne97_state : in nodeStates;
			ne97_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_30;
	component route_31 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			ne106_state : in nodeStates;
			ne106_command : out routeCommands;
			ne4_state : in nodeStates;
			ne4_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_31;
	component route_32 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne96_state : in nodeStates;
			ne96_command : out routeCommands;
			ne93_state : in nodeStates;
			ne93_command : out routeCommands;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_32;
	component route_33 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne96_state : in nodeStates;
			ne96_command : out routeCommands;
			ne98_state : in nodeStates;
			ne98_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_33;
	component route_34 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_34;
	component route_35 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			ne79_state : in nodeStates;
			ne79_command : out routeCommands;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_35;
	component route_36 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			ne94_state : in nodeStates;
			ne94_command : out routeCommands;
			ne97_state : in nodeStates;
			ne97_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_36;
	component route_37 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			s68W02_state : in singleSwitchStates;
			s68W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_37;
	component route_38 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			s68W02_state : in singleSwitchStates;
			s68W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_38;
	component route_39 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			s68W02_state : in singleSwitchStates;
			s68W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_39;
	component route_40 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			ne59_state : in nodeStates;
			ne59_command : out routeCommands;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			s69W03_state : in singleSwitchStates;
			s69W03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_40;
	component route_41 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne59_state : in nodeStates;
			ne59_command : out routeCommands;
			ne11_state : in nodeStates;
			ne11_command : out routeCommands;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			s69W03_state : in singleSwitchStates;
			s69W03_command : out routeCommands;
			s69W04_state : in singleSwitchStates;
			s69W04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_41;
	component route_42 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne59_state : in nodeStates;
			ne59_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			s69W03_state : in singleSwitchStates;
			s69W03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_42;
	component route_43 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			ne11_state : in nodeStates;
			ne11_command : out routeCommands;
			ne59_state : in nodeStates;
			ne59_command : out routeCommands;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			s69W03_state : in singleSwitchStates;
			s69W03_command : out routeCommands;
			s69W04_state : in singleSwitchStates;
			s69W04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_43;
	component route_44 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			s69W04_state : in singleSwitchStates;
			s69W04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_44;
	component route_45 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			ne64_state : in nodeStates;
			ne64_command : out routeCommands;
			ne103_state : in nodeStates;
			ne103_command : out routeCommands;
			s70W01_state : in singleSwitchStates;
			s70W01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_45;
	component route_46 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne64_state : in nodeStates;
			ne64_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			s70W01_state : in singleSwitchStates;
			s70W01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_46;
	component route_47 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne64_state : in nodeStates;
			ne64_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			s70W01_state : in singleSwitchStates;
			s70W01_command : out routeCommands;
			s70W02_state : in singleSwitchStates;
			s70W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_47;
	component route_48 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne24_state : in nodeStates;
			ne24_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_48;
	component route_49 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			s70W02_state : in singleSwitchStates;
			s70W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_49;
	component route_50 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			ne24_state : in nodeStates;
			ne24_command : out routeCommands;
			s70W02_state : in singleSwitchStates;
			s70W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_50;
	component route_51 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne83_state : in nodeStates;
			ne83_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_51;
	component route_52 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne29_state : in nodeStates;
			ne29_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_52;
	component route_53 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			ne29_state : in nodeStates;
			ne29_command : out routeCommands;
			ne110_state : in nodeStates;
			ne110_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			Sw09_state : in singleSwitchStates;
			Sw09_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_53;
	component route_54 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			ne83_state : in nodeStates;
			ne83_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_54;
	component route_55 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			ne110_state : in nodeStates;
			ne110_command : out routeCommands;
			Sw09_state : in singleSwitchStates;
			Sw09_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_55;
	component route_56 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne29_state : in nodeStates;
			ne29_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_56;
	component route_57 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne110_state : in nodeStates;
			ne110_command : out routeCommands;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			Sw09_state : in singleSwitchStates;
			Sw09_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_57;
	component route_58 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne110_state : in nodeStates;
			ne110_command : out routeCommands;
			ne29_state : in nodeStates;
			ne29_command : out routeCommands;
			Sw09_state : in singleSwitchStates;
			Sw09_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_58;
	component route_59 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne102_state : in nodeStates;
			ne102_command : out routeCommands;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_59;
	component route_60 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			ne43_state : in nodeStates;
			ne43_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_command : out routeCommands;
			s71W02_state : in singleSwitchStates;
			s71W02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_60;
	component route_61 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			ne102_state : in nodeStates;
			ne102_command : out routeCommands;
			ne65_state : in nodeStates;
			ne65_command : out routeCommands;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_61;
	component route_62 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_62;
	component route_63 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_63;
	component route_64 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			ne79_state : in nodeStates;
			ne79_command : out routeCommands;
			ne77_state : in nodeStates;
			ne77_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_64;
	component route_65 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			ne79_state : in nodeStates;
			ne79_command : out routeCommands;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_65;
	component route_66 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne83_state : in nodeStates;
			ne83_command : out routeCommands;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_66;
	component route_67 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			ne83_state : in nodeStates;
			ne83_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_67;
	component route_68 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			ne82_state : in nodeStates;
			ne82_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_68;
	component route_69 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			ne82_state : in nodeStates;
			ne82_command : out routeCommands;
			ne84_state : in nodeStates;
			ne84_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_69;
	component route_70 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne88_state : in nodeStates;
			ne88_command : out routeCommands;
			ne86_state : in nodeStates;
			ne86_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_70;
	component route_71 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne86_state : in nodeStates;
			ne86_command : out routeCommands;
			ne88_state : in nodeStates;
			ne88_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_71;
	component route_72 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne86_state : in nodeStates;
			ne86_command : out routeCommands;
			ne87_state : in nodeStates;
			ne87_command : out routeCommands;
			ne91_state : in nodeStates;
			ne91_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_72;
	component route_73 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			ne89_state : in nodeStates;
			ne89_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_73;
	component route_74 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			ne91_state : in nodeStates;
			ne91_command : out routeCommands;
			ne87_state : in nodeStates;
			ne87_command : out routeCommands;
			ne86_state : in nodeStates;
			ne86_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_74;
	component route_75 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			ne91_state : in nodeStates;
			ne91_command : out routeCommands;
			ne90_state : in nodeStates;
			ne90_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_75;
	component route_76 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			ne82_state : in nodeStates;
			ne82_command : out routeCommands;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_76;
	component route_77 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			ne85_state : in nodeStates;
			ne85_command : out routeCommands;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_77;
	component route_78 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne85_state : in nodeStates;
			ne85_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_78;
	component route_79 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne85_state : in nodeStates;
			ne85_command : out routeCommands;
			ne84_state : in nodeStates;
			ne84_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_79;
	component route_80 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne77_state : in nodeStates;
			ne77_command : out routeCommands;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_80;
	component route_81 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne94_state : in nodeStates;
			ne94_command : out routeCommands;
			ne77_state : in nodeStates;
			ne77_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_81;
	component route_82 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne94_state : in nodeStates;
			ne94_command : out routeCommands;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_82;
	component route_83 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne110_state : in nodeStates;
			ne110_command : out routeCommands;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_83;
	component route_84 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne110_state : in nodeStates;
			ne110_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_84;
	component route_85 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne85_state : in nodeStates;
			ne85_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_85;
	component route_86 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne104_state : in nodeStates;
			ne104_command : out routeCommands;
			ne70_state : in nodeStates;
			ne70_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_86;
	component route_87 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			ne104_state : in nodeStates;
			ne104_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_87;
	component route_88 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne77_state : in nodeStates;
			ne77_command : out routeCommands;
			ne79_state : in nodeStates;
			ne79_command : out routeCommands;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_88;
	component route_89 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne77_state : in nodeStates;
			ne77_command : out routeCommands;
			ne94_state : in nodeStates;
			ne94_command : out routeCommands;
			ne97_state : in nodeStates;
			ne97_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_89;
	component route_90 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			ne77_state : in nodeStates;
			ne77_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_90;

 signal state_Lc01 : levelCrossingStates;
 signal state_68W02 , state_69W03 , state_69W04 , state_Sw06 , state_70W02 , state_70W01 , state_Sw09 , state_Sw08 , state_Sw12 , state_Sw04 , state_71W01 , state_71W02 , state_Sw11 , state_Sw13 , state_Sw41 : singleSwitchStates;
 signal state_ne1 , state_ne4 , state_ne7 , state_ne9 , state_ne11 , state_ne14 , state_ne17 , state_ne23 , state_ne24 , state_ne26 , state_ne29 , state_ne30 , state_ne32 , state_ne41 , state_ne43 , state_ne44 , state_ne47 , state_ne48 , state_ne59 , state_ne64 , state_ne65 , state_ne67 , state_ne70 , state_ne78 , state_ne79 , state_ne82 , state_ne83 , state_ne84 , state_ne86 , state_ne87 , state_ne88 , state_ne89 , state_ne90 , state_ne91 , state_ne93 , state_ne94 , state_ne95 , state_ne96 , state_ne97 , state_ne98 , state_ne99 , state_ne100 , state_ne101 , state_ne102 , state_ne103 , state_ne105 , state_ne106 , state_ne85 , state_ne77 , state_ne104 , state_ne52 , state_ne21 , state_ne110 : nodeStates;
 signal cmd_R1_ne1 , cmd_R2_ne7 , cmd_R3_ne14 , cmd_R3_ne52 , cmd_R4_ne47 , cmd_R4_ne48 , cmd_R5_ne84 , cmd_R5_ne82 , cmd_R5_ne32 , cmd_R6_ne84 , cmd_R6_ne85 , cmd_R6_ne100 , cmd_R6_ne101 , cmd_R6_ne44 , cmd_R7_ne89 , cmd_R7_ne30 , cmd_R8_ne90 , cmd_R8_ne91 , cmd_R8_ne30 , cmd_R9_ne105 , cmd_R9_ne98 , cmd_R9_ne96 , cmd_R10_ne4 , cmd_R10_ne106 , cmd_R11_ne26 , cmd_R11_ne65 , cmd_R12_ne44 , cmd_R12_ne101 , cmd_R13_ne65 , cmd_R13_ne102 , cmd_R14_ne70 , cmd_R14_ne104 , cmd_R14_ne21 , cmd_R15_ne78 , cmd_R15_ne93 , cmd_R16_ne93 , cmd_R16_ne96 , cmd_R17_ne95 , cmd_R18_ne97 , cmd_R18_ne94 , cmd_R19_ne98 , cmd_R19_ne105 , cmd_R20_ne101 , cmd_R20_ne100 , cmd_R21_ne103 , cmd_R21_ne64 , cmd_R22_ne106 , cmd_R22_ne99 , cmd_R23_ne7 , cmd_R23_ne9 , cmd_R24_ne9 , cmd_R24_ne95 , cmd_R25_ne95 , cmd_R25_ne59 , cmd_R26_ne95 , cmd_R26_ne9 , cmd_R27_ne23 , cmd_R27_ne26 , cmd_R28_ne24 , cmd_R28_ne64 , cmd_R28_ne103 , cmd_R29_ne67 , cmd_R29_ne70 , cmd_R30_ne67 , cmd_R30_ne103 , cmd_R31_ne99 , cmd_R31_ne97 , cmd_R32_ne99 , cmd_R32_ne106 , cmd_R32_ne4 , cmd_R33_ne96 , cmd_R33_ne93 , cmd_R33_ne78 , cmd_R34_ne96 , cmd_R34_ne98 , cmd_R35_ne21 , cmd_R36_ne21 , cmd_R36_ne79 , cmd_R36_ne78 , cmd_R37_ne21 , cmd_R37_ne94 , cmd_R37_ne97 , cmd_R37_ne99 , cmd_R38_ne1 , cmd_R38_ne9 , cmd_R39_ne9 , cmd_R39_ne1 , cmd_R40_ne9 , cmd_R40_ne7 , cmd_R41_ne17 , cmd_R41_ne59 , cmd_R41_ne95 , cmd_R42_ne59 , cmd_R42_ne11 , cmd_R42_ne52 , cmd_R43_ne59 , cmd_R43_ne17 , cmd_R44_ne52 , cmd_R44_ne11 , cmd_R44_ne59 , cmd_R44_ne95 , cmd_R45_ne52 , cmd_R45_ne14 , cmd_R46_ne23 , cmd_R46_ne64 , cmd_R46_ne103 , cmd_R47_ne64 , cmd_R47_ne23 , cmd_R48_ne64 , cmd_R48_ne23 , cmd_R48_ne26 , cmd_R49_ne24 , cmd_R50_ne26 , cmd_R50_ne23 , cmd_R51_ne26 , cmd_R51_ne24 , cmd_R52_ne83 , cmd_R52_ne30 , cmd_R53_ne29 , cmd_R53_ne30 , cmd_R54_ne30 , cmd_R54_ne29 , cmd_R54_ne110 , cmd_R55_ne30 , cmd_R55_ne83 , cmd_R56_ne32 , cmd_R56_ne110 , cmd_R57_ne29 , cmd_R58_ne110 , cmd_R58_ne32 , cmd_R59_ne110 , cmd_R59_ne29 , cmd_R60_ne102 , cmd_R60_ne44 , cmd_R61_ne44 , cmd_R61_ne43 , cmd_R61_ne48 , cmd_R62_ne44 , cmd_R62_ne102 , cmd_R62_ne65 , cmd_R62_ne26 , cmd_R63_ne17 , cmd_R63_ne78 , cmd_R64_ne78 , cmd_R64_ne17 , cmd_R65_ne78 , cmd_R65_ne79 , cmd_R65_ne77 , cmd_R66_ne78 , cmd_R66_ne79 , cmd_R66_ne21 , cmd_R67_ne83 , cmd_R67_ne32 , cmd_R68_ne32 , cmd_R68_ne83 , cmd_R69_ne32 , cmd_R69_ne82 , cmd_R69_ne41 , cmd_R70_ne32 , cmd_R70_ne82 , cmd_R70_ne84 , cmd_R71_ne88 , cmd_R71_ne86 , cmd_R72_ne86 , cmd_R72_ne88 , cmd_R73_ne86 , cmd_R73_ne87 , cmd_R73_ne91 , cmd_R73_ne30 , cmd_R74_ne30 , cmd_R74_ne89 , cmd_R75_ne30 , cmd_R75_ne91 , cmd_R75_ne87 , cmd_R75_ne86 , cmd_R76_ne30 , cmd_R76_ne91 , cmd_R76_ne90 , cmd_R77_ne41 , cmd_R77_ne82 , cmd_R77_ne32 , cmd_R78_ne41 , cmd_R78_ne85 , cmd_R78_ne100 , cmd_R78_ne101 , cmd_R78_ne44 , cmd_R79_ne85 , cmd_R79_ne41 , cmd_R80_ne85 , cmd_R80_ne84 , cmd_R81_ne77 , cmd_R81_ne52 , cmd_R82_ne94 , cmd_R82_ne77 , cmd_R83_ne94 , cmd_R83_ne21 , cmd_R84_ne110 , cmd_R84_ne100 , cmd_R84_ne101 , cmd_R84_ne44 , cmd_R85_ne100 , cmd_R85_ne110 , cmd_R86_ne100 , cmd_R86_ne85 , cmd_R87_ne104 , cmd_R87_ne70 , cmd_R88_ne21 , cmd_R88_ne104 , cmd_R89_ne77 , cmd_R89_ne79 , cmd_R89_ne78 , cmd_R90_ne77 , cmd_R90_ne94 , cmd_R90_ne97 , cmd_R90_ne99 , cmd_R91_ne52 , cmd_R91_ne77 : routeCommands;
 signal cmd_R25_Lc01 , cmd_R26_Lc01 : routeCommands;
 signal cmd_R3_69W04 , cmd_R4_71W02 , cmd_R5_Sw04 , cmd_R5_Sw05 , cmd_R6_Sw05 , cmd_R6_Sw41 , cmd_R7_Sw12 , cmd_R8_Sw12 , cmd_R8_Sw13 , cmd_R14_Sw03 , cmd_R23_68W02 , cmd_R27_70W02 , cmd_R28_70W01 , cmd_R36_Sw06 , cmd_R36_Sw07 , cmd_R37_Sw07 , cmd_R38_68W02 , cmd_R39_68W02 , cmd_R40_68W02 , cmd_R41_69W03 , cmd_R42_69W03 , cmd_R42_69W04 , cmd_R43_69W03 , cmd_R44_69W03 , cmd_R44_69W04 , cmd_R45_69W04 , cmd_R46_70W01 , cmd_R47_70W01 , cmd_R48_70W01 , cmd_R48_70W02 , cmd_R50_70W02 , cmd_R51_70W02 , cmd_R52_Sw08 , cmd_R53_Sw08 , cmd_R54_Sw08 , cmd_R54_Sw09 , cmd_R55_Sw08 , cmd_R56_Sw09 , cmd_R58_Sw09 , cmd_R59_Sw09 , cmd_R60_71W01 , cmd_R61_71W01 , cmd_R61_71W02 , cmd_R62_71W01 , cmd_R63_Sw06 , cmd_R64_Sw06 , cmd_R65_Sw06 , cmd_R65_Sw07 , cmd_R66_Sw06 , cmd_R66_Sw07 , cmd_R67_Sw04 , cmd_R68_Sw04 , cmd_R69_Sw04 , cmd_R69_Sw05 , cmd_R70_Sw04 , cmd_R70_Sw05 , cmd_R71_Sw11 , cmd_R72_Sw11 , cmd_R73_Sw11 , cmd_R73_Sw12 , cmd_R73_Sw13 , cmd_R74_Sw12 , cmd_R75_Sw11 , cmd_R75_Sw12 , cmd_R75_Sw13 , cmd_R76_Sw12 , cmd_R76_Sw13 , cmd_R77_Sw04 , cmd_R77_Sw05 , cmd_R78_Sw05 , cmd_R78_Sw41 , cmd_R79_Sw05 , cmd_R80_Sw05 , cmd_R82_Sw07 , cmd_R83_Sw07 , cmd_R84_Sw41 , cmd_R85_Sw41 , cmd_R86_Sw41 , cmd_R89_Sw06 , cmd_R89_Sw07 , cmd_R90_Sw07 : routeCommands;
begin
	levelCrossing_Lc01 : levelCrossing_0 port map(clock => clock, R25_command => cmd_R25_Lc01, R26_command => cmd_R26_Lc01, ocupation_ne95 => ocupation(36), ocupation_ne9 => ocupation(3), ocupation_ne59 => ocupation(18), indication => levelCrossings_i, command  => levelCrossings_o, correspondence_Lc01 => state_Lc01);
	singleSwitch_68W02 : singleSwitch_0 port map(clock => clock, R23_command => cmd_R23_68W02, R38_command => cmd_R38_68W02, R39_command => cmd_R39_68W02, R40_command => cmd_R40_68W02, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence_68W02 => state_68W02);
	singleSwitch_69W03 : singleSwitch_1 port map(clock => clock, R41_command => cmd_R41_69W03, R42_command => cmd_R42_69W03, R43_command => cmd_R43_69W03, R44_command => cmd_R44_69W03, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence_69W03 => state_69W03);
	singleSwitch_69W04 : singleSwitch_2 port map(clock => clock, R3_command => cmd_R3_69W04, R42_command => cmd_R42_69W04, R44_command => cmd_R44_69W04, R45_command => cmd_R45_69W04, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence_69W04 => state_69W04);
	singleSwitch_Sw06 : singleSwitch_3 port map(clock => clock, R36_command => cmd_R36_Sw06, R63_command => cmd_R63_Sw06, R64_command => cmd_R64_Sw06, R65_command => cmd_R65_Sw06, R66_command => cmd_R66_Sw06, R89_command => cmd_R89_Sw06, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence_Sw06 => state_Sw06);
	singleSwitch_70W02 : singleSwitch_4 port map(clock => clock, R27_command => cmd_R27_70W02, R48_command => cmd_R48_70W02, R50_command => cmd_R50_70W02, R51_command => cmd_R51_70W02, indication => singleSwitches_i(4), command => singleSwitches_o(4), correspondence_70W02 => state_70W02);
	singleSwitch_70W01 : singleSwitch_5 port map(clock => clock, R28_command => cmd_R28_70W01, R46_command => cmd_R46_70W01, R47_command => cmd_R47_70W01, R48_command => cmd_R48_70W01, indication => singleSwitches_i(5), command => singleSwitches_o(5), correspondence_70W01 => state_70W01);
	singleSwitch_Sw09 : singleSwitch_6 port map(clock => clock, R54_command => cmd_R54_Sw09, R56_command => cmd_R56_Sw09, R58_command => cmd_R58_Sw09, R59_command => cmd_R59_Sw09, indication => singleSwitches_i(6), command => singleSwitches_o(6), correspondence_Sw09 => state_Sw09);
	singleSwitch_Sw08 : singleSwitch_7 port map(clock => clock, R52_command => cmd_R52_Sw08, R53_command => cmd_R53_Sw08, R54_command => cmd_R54_Sw08, R55_command => cmd_R55_Sw08, indication => singleSwitches_i(7), command => singleSwitches_o(7), correspondence_Sw08 => state_Sw08);
	singleSwitch_Sw12 : singleSwitch_8 port map(clock => clock, R7_command => cmd_R7_Sw12, R8_command => cmd_R8_Sw12, R73_command => cmd_R73_Sw12, R74_command => cmd_R74_Sw12, R75_command => cmd_R75_Sw12, R76_command => cmd_R76_Sw12, indication => singleSwitches_i(8), command => singleSwitches_o(8), correspondence_Sw12 => state_Sw12);
	singleSwitch_Sw04 : singleSwitch_9 port map(clock => clock, R5_command => cmd_R5_Sw04, R67_command => cmd_R67_Sw04, R68_command => cmd_R68_Sw04, R69_command => cmd_R69_Sw04, R70_command => cmd_R70_Sw04, R77_command => cmd_R77_Sw04, indication => singleSwitches_i(9), command => singleSwitches_o(9), correspondence_Sw04 => state_Sw04);
	singleSwitch_71W01 : singleSwitch_10 port map(clock => clock, R60_command => cmd_R60_71W01, R61_command => cmd_R61_71W01, R62_command => cmd_R62_71W01, indication => singleSwitches_i(10), command => singleSwitches_o(10), correspondence_71W01 => state_71W01);
	singleSwitch_71W02 : singleSwitch_11 port map(clock => clock, R4_command => cmd_R4_71W02, R61_command => cmd_R61_71W02, indication => singleSwitches_i(11), command => singleSwitches_o(11), correspondence_71W02 => state_71W02);
	singleSwitch_Sw11 : singleSwitch_12 port map(clock => clock, R71_command => cmd_R71_Sw11, R72_command => cmd_R72_Sw11, R73_command => cmd_R73_Sw11, R75_command => cmd_R75_Sw11, indication => singleSwitches_i(12), command => singleSwitches_o(12), correspondence_Sw11 => state_Sw11);
	singleSwitch_Sw13 : singleSwitch_13 port map(clock => clock, R8_command => cmd_R8_Sw13, R73_command => cmd_R73_Sw13, R75_command => cmd_R75_Sw13, R76_command => cmd_R76_Sw13, indication => singleSwitches_i(13), command => singleSwitches_o(13), correspondence_Sw13 => state_Sw13);
	singleSwitch_Sw41 : singleSwitch_14 port map(clock => clock, R6_command => cmd_R6_Sw41, R78_command => cmd_R78_Sw41, R84_command => cmd_R84_Sw41, R85_command => cmd_R85_Sw41, R86_command => cmd_R86_Sw41, indication => singleSwitches_i(14), command => singleSwitches_o(14), correspondence_Sw41 => state_Sw41);
	node_ne1 : node_0 port map(clock => clock, ocupation => ocupation(0), R1_command => cmd_R1_ne1, R38_command => cmd_R38_ne1, R39_command => cmd_R39_ne1, state => state_ne1);
	node_ne4 : node_1 port map(clock => clock, ocupation => ocupation(1), R10_command => cmd_R10_ne4, R32_command => cmd_R32_ne4, state => state_ne4);
	node_ne7 : node_2 port map(clock => clock, ocupation => ocupation(2), R2_command => cmd_R2_ne7, R23_command => cmd_R23_ne7, R40_command => cmd_R40_ne7, state => state_ne7);
	node_ne9 : node_3 port map(clock => clock, ocupation => ocupation(3), R23_command => cmd_R23_ne9, R24_command => cmd_R24_ne9, R26_command => cmd_R26_ne9, R38_command => cmd_R38_ne9, R39_command => cmd_R39_ne9, R40_command => cmd_R40_ne9, state => state_ne9);
	node_ne11 : node_4 port map(clock => clock, ocupation => ocupation(4), R42_command => cmd_R42_ne11, R44_command => cmd_R44_ne11, state => state_ne11);
	node_ne14 : node_5 port map(clock => clock, ocupation => ocupation(5), R3_command => cmd_R3_ne14, R45_command => cmd_R45_ne14, state => state_ne14);
	node_ne17 : node_6 port map(clock => clock, ocupation => ocupation(6), R41_command => cmd_R41_ne17, R43_command => cmd_R43_ne17, R63_command => cmd_R63_ne17, R64_command => cmd_R64_ne17, state => state_ne17);
	node_ne23 : node_7 port map(clock => clock, ocupation => ocupation(7), R27_command => cmd_R27_ne23, R46_command => cmd_R46_ne23, R47_command => cmd_R47_ne23, R48_command => cmd_R48_ne23, R50_command => cmd_R50_ne23, state => state_ne23);
	node_ne24 : node_8 port map(clock => clock, ocupation => ocupation(8), R28_command => cmd_R28_ne24, R49_command => cmd_R49_ne24, R51_command => cmd_R51_ne24, state => state_ne24);
	node_ne26 : node_9 port map(clock => clock, ocupation => ocupation(9), R11_command => cmd_R11_ne26, R27_command => cmd_R27_ne26, R48_command => cmd_R48_ne26, R50_command => cmd_R50_ne26, R51_command => cmd_R51_ne26, R62_command => cmd_R62_ne26, state => state_ne26);
	node_ne29 : node_10 port map(clock => clock, ocupation => ocupation(10), R53_command => cmd_R53_ne29, R54_command => cmd_R54_ne29, R57_command => cmd_R57_ne29, R59_command => cmd_R59_ne29, state => state_ne29);
	node_ne30 : node_11 port map(clock => clock, ocupation => ocupation(11), R7_command => cmd_R7_ne30, R8_command => cmd_R8_ne30, R52_command => cmd_R52_ne30, R53_command => cmd_R53_ne30, R54_command => cmd_R54_ne30, R55_command => cmd_R55_ne30, R73_command => cmd_R73_ne30, R74_command => cmd_R74_ne30, R75_command => cmd_R75_ne30, R76_command => cmd_R76_ne30, state => state_ne30);
	node_ne32 : node_12 port map(clock => clock, ocupation => ocupation(12), R5_command => cmd_R5_ne32, R56_command => cmd_R56_ne32, R58_command => cmd_R58_ne32, R67_command => cmd_R67_ne32, R68_command => cmd_R68_ne32, R69_command => cmd_R69_ne32, R70_command => cmd_R70_ne32, R77_command => cmd_R77_ne32, state => state_ne32);
	node_ne41 : node_13 port map(clock => clock, ocupation => ocupation(13), R69_command => cmd_R69_ne41, R77_command => cmd_R77_ne41, R78_command => cmd_R78_ne41, R79_command => cmd_R79_ne41, state => state_ne41);
	node_ne43 : node_14 port map(clock => clock, ocupation => ocupation(14), R61_command => cmd_R61_ne43, state => state_ne43);
	node_ne44 : node_15 port map(clock => clock, ocupation => ocupation(15), R6_command => cmd_R6_ne44, R12_command => cmd_R12_ne44, R60_command => cmd_R60_ne44, R61_command => cmd_R61_ne44, R62_command => cmd_R62_ne44, R78_command => cmd_R78_ne44, R84_command => cmd_R84_ne44, state => state_ne44);
	node_ne47 : node_16 port map(clock => clock, ocupation => ocupation(16), R4_command => cmd_R4_ne47, state => state_ne47);
	node_ne48 : node_17 port map(clock => clock, ocupation => ocupation(17), R4_command => cmd_R4_ne48, R61_command => cmd_R61_ne48, state => state_ne48);
	node_ne59 : node_18 port map(clock => clock, ocupation => ocupation(18), R25_command => cmd_R25_ne59, R41_command => cmd_R41_ne59, R42_command => cmd_R42_ne59, R43_command => cmd_R43_ne59, R44_command => cmd_R44_ne59, state => state_ne59);
	node_ne64 : node_19 port map(clock => clock, ocupation => ocupation(19), R21_command => cmd_R21_ne64, R28_command => cmd_R28_ne64, R46_command => cmd_R46_ne64, R47_command => cmd_R47_ne64, R48_command => cmd_R48_ne64, state => state_ne64);
	node_ne65 : node_20 port map(clock => clock, ocupation => ocupation(20), R11_command => cmd_R11_ne65, R13_command => cmd_R13_ne65, R62_command => cmd_R62_ne65, state => state_ne65);
	node_ne67 : node_21 port map(clock => clock, ocupation => ocupation(21), R29_command => cmd_R29_ne67, R30_command => cmd_R30_ne67, state => state_ne67);
	node_ne70 : node_22 port map(clock => clock, ocupation => ocupation(22), R14_command => cmd_R14_ne70, R29_command => cmd_R29_ne70, R87_command => cmd_R87_ne70, state => state_ne70);
	node_ne78 : node_23 port map(clock => clock, ocupation => ocupation(23), R15_command => cmd_R15_ne78, R33_command => cmd_R33_ne78, R36_command => cmd_R36_ne78, R63_command => cmd_R63_ne78, R64_command => cmd_R64_ne78, R65_command => cmd_R65_ne78, R66_command => cmd_R66_ne78, R89_command => cmd_R89_ne78, state => state_ne78);
	node_ne79 : node_24 port map(clock => clock, ocupation => ocupation(24), R36_command => cmd_R36_ne79, R65_command => cmd_R65_ne79, R66_command => cmd_R66_ne79, R89_command => cmd_R89_ne79, state => state_ne79);
	node_ne82 : node_25 port map(clock => clock, ocupation => ocupation(25), R5_command => cmd_R5_ne82, R69_command => cmd_R69_ne82, R70_command => cmd_R70_ne82, R77_command => cmd_R77_ne82, state => state_ne82);
	node_ne83 : node_26 port map(clock => clock, ocupation => ocupation(26), R52_command => cmd_R52_ne83, R55_command => cmd_R55_ne83, R67_command => cmd_R67_ne83, R68_command => cmd_R68_ne83, state => state_ne83);
	node_ne84 : node_27 port map(clock => clock, ocupation => ocupation(27), R5_command => cmd_R5_ne84, R6_command => cmd_R6_ne84, R70_command => cmd_R70_ne84, R80_command => cmd_R80_ne84, state => state_ne84);
	node_ne86 : node_28 port map(clock => clock, ocupation => ocupation(28), R71_command => cmd_R71_ne86, R72_command => cmd_R72_ne86, R73_command => cmd_R73_ne86, R75_command => cmd_R75_ne86, state => state_ne86);
	node_ne87 : node_29 port map(clock => clock, ocupation => ocupation(29), R73_command => cmd_R73_ne87, R75_command => cmd_R75_ne87, state => state_ne87);
	node_ne88 : node_30 port map(clock => clock, ocupation => ocupation(30), R71_command => cmd_R71_ne88, R72_command => cmd_R72_ne88, state => state_ne88);
	node_ne89 : node_31 port map(clock => clock, ocupation => ocupation(31), R7_command => cmd_R7_ne89, R74_command => cmd_R74_ne89, state => state_ne89);
	node_ne90 : node_32 port map(clock => clock, ocupation => ocupation(32), R8_command => cmd_R8_ne90, R76_command => cmd_R76_ne90, state => state_ne90);
	node_ne91 : node_33 port map(clock => clock, ocupation => ocupation(33), R8_command => cmd_R8_ne91, R73_command => cmd_R73_ne91, R75_command => cmd_R75_ne91, R76_command => cmd_R76_ne91, state => state_ne91);
	node_ne93 : node_34 port map(clock => clock, ocupation => ocupation(34), R15_command => cmd_R15_ne93, R16_command => cmd_R16_ne93, R33_command => cmd_R33_ne93, state => state_ne93);
	node_ne94 : node_35 port map(clock => clock, ocupation => ocupation(35), R18_command => cmd_R18_ne94, R37_command => cmd_R37_ne94, R82_command => cmd_R82_ne94, R83_command => cmd_R83_ne94, R90_command => cmd_R90_ne94, state => state_ne94);
	node_ne95 : node_36 port map(clock => clock, ocupation => ocupation(36), R17_command => cmd_R17_ne95, R24_command => cmd_R24_ne95, R25_command => cmd_R25_ne95, R26_command => cmd_R26_ne95, R41_command => cmd_R41_ne95, R44_command => cmd_R44_ne95, state => state_ne95);
	node_ne96 : node_37 port map(clock => clock, ocupation => ocupation(37), R9_command => cmd_R9_ne96, R16_command => cmd_R16_ne96, R33_command => cmd_R33_ne96, R34_command => cmd_R34_ne96, state => state_ne96);
	node_ne97 : node_38 port map(clock => clock, ocupation => ocupation(38), R18_command => cmd_R18_ne97, R31_command => cmd_R31_ne97, R37_command => cmd_R37_ne97, R90_command => cmd_R90_ne97, state => state_ne97);
	node_ne98 : node_39 port map(clock => clock, ocupation => ocupation(39), R9_command => cmd_R9_ne98, R19_command => cmd_R19_ne98, R34_command => cmd_R34_ne98, state => state_ne98);
	node_ne99 : node_40 port map(clock => clock, ocupation => ocupation(40), R22_command => cmd_R22_ne99, R31_command => cmd_R31_ne99, R32_command => cmd_R32_ne99, R37_command => cmd_R37_ne99, R90_command => cmd_R90_ne99, state => state_ne99);
	node_ne100 : node_41 port map(clock => clock, ocupation => ocupation(41), R6_command => cmd_R6_ne100, R20_command => cmd_R20_ne100, R78_command => cmd_R78_ne100, R84_command => cmd_R84_ne100, R85_command => cmd_R85_ne100, R86_command => cmd_R86_ne100, state => state_ne100);
	node_ne101 : node_42 port map(clock => clock, ocupation => ocupation(42), R6_command => cmd_R6_ne101, R12_command => cmd_R12_ne101, R20_command => cmd_R20_ne101, R78_command => cmd_R78_ne101, R84_command => cmd_R84_ne101, state => state_ne101);
	node_ne102 : node_43 port map(clock => clock, ocupation => ocupation(43), R13_command => cmd_R13_ne102, R60_command => cmd_R60_ne102, R62_command => cmd_R62_ne102, state => state_ne102);
	node_ne103 : node_44 port map(clock => clock, ocupation => ocupation(44), R21_command => cmd_R21_ne103, R28_command => cmd_R28_ne103, R30_command => cmd_R30_ne103, R46_command => cmd_R46_ne103, state => state_ne103);
	node_ne105 : node_45 port map(clock => clock, ocupation => ocupation(45), R9_command => cmd_R9_ne105, R19_command => cmd_R19_ne105, state => state_ne105);
	node_ne106 : node_46 port map(clock => clock, ocupation => ocupation(46), R10_command => cmd_R10_ne106, R22_command => cmd_R22_ne106, R32_command => cmd_R32_ne106, state => state_ne106);
	node_ne85 : node_47 port map(clock => clock, ocupation => ocupation(47), R6_command => cmd_R6_ne85, R78_command => cmd_R78_ne85, R79_command => cmd_R79_ne85, R80_command => cmd_R80_ne85, R86_command => cmd_R86_ne85, state => state_ne85);
	node_ne77 : node_48 port map(clock => clock, ocupation => ocupation(48), R65_command => cmd_R65_ne77, R81_command => cmd_R81_ne77, R82_command => cmd_R82_ne77, R89_command => cmd_R89_ne77, R90_command => cmd_R90_ne77, R91_command => cmd_R91_ne77, state => state_ne77);
	node_ne104 : node_49 port map(clock => clock, ocupation => ocupation(49), R14_command => cmd_R14_ne104, R87_command => cmd_R87_ne104, R88_command => cmd_R88_ne104, state => state_ne104);
	node_ne52 : node_50 port map(clock => clock, ocupation => ocupation(50), R3_command => cmd_R3_ne52, R42_command => cmd_R42_ne52, R44_command => cmd_R44_ne52, R45_command => cmd_R45_ne52, R81_command => cmd_R81_ne52, R91_command => cmd_R91_ne52, state => state_ne52);
	node_ne21 : node_51 port map(clock => clock, ocupation => ocupation(51), R14_command => cmd_R14_ne21, R35_command => cmd_R35_ne21, R36_command => cmd_R36_ne21, R37_command => cmd_R37_ne21, R66_command => cmd_R66_ne21, R83_command => cmd_R83_ne21, R88_command => cmd_R88_ne21, state => state_ne21);
	node_ne110 : node_52 port map(clock => clock, ocupation => ocupation(52), R54_command => cmd_R54_ne110, R56_command => cmd_R56_ne110, R58_command => cmd_R58_ne110, R59_command => cmd_R59_ne110, R84_command => cmd_R84_ne110, R85_command => cmd_R85_ne110, state => state_ne110);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne1_command => cmd_R1_ne1, ne1_state => state_ne1, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne7_command => cmd_R2_ne7, ne7_state => state_ne7, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne14_command => cmd_R3_ne14, ne14_state => state_ne14, ne52_command => cmd_R3_ne52, ne52_state => state_ne52, s69W04_command => cmd_R3_69W04, s69W04_state => state_69W04, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne47_command => cmd_R4_ne47, ne47_state => state_ne47, ne48_command => cmd_R4_ne48, ne48_state => state_ne48, s71W02_command => cmd_R4_71W02, s71W02_state => state_71W02, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne32_command => cmd_R5_ne32, ne32_state => state_ne32, ne82_command => cmd_R5_ne82, ne82_state => state_ne82, ne84_command => cmd_R5_ne84, ne84_state => state_ne84, Sw04_command => cmd_R5_Sw04, Sw04_state => state_Sw04, Sw05_command => cmd_R5_Sw05, Sw05_state => state_Sw05, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne44_command => cmd_R6_ne44, ne44_state => state_ne44, ne84_command => cmd_R6_ne84, ne84_state => state_ne84, ne100_command => cmd_R6_ne100, ne100_state => state_ne100, ne101_command => cmd_R6_ne101, ne101_state => state_ne101, ne85_command => cmd_R6_ne85, ne85_state => state_ne85, Sw05_command => cmd_R6_Sw05, Sw05_state => state_Sw05, Sw41_command => cmd_R6_Sw41, Sw41_state => state_Sw41, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne30_command => cmd_R7_ne30, ne30_state => state_ne30, ne89_command => cmd_R7_ne89, ne89_state => state_ne89, Sw12_command => cmd_R7_Sw12, Sw12_state => state_Sw12, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne30_command => cmd_R8_ne30, ne30_state => state_ne30, ne90_command => cmd_R8_ne90, ne90_state => state_ne90, ne91_command => cmd_R8_ne91, ne91_state => state_ne91, Sw12_command => cmd_R8_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R8_Sw13, Sw13_state => state_Sw13, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne96_command => cmd_R9_ne96, ne96_state => state_ne96, ne98_command => cmd_R9_ne98, ne98_state => state_ne98, ne105_command => cmd_R9_ne105, ne105_state => state_ne105, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne4_command => cmd_R10_ne4, ne4_state => state_ne4, ne106_command => cmd_R10_ne106, ne106_state => state_ne106, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), ne26_command => cmd_R11_ne26, ne26_state => state_ne26, ne65_command => cmd_R11_ne65, ne65_state => state_ne65, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), ne44_command => cmd_R12_ne44, ne44_state => state_ne44, ne101_command => cmd_R12_ne101, ne101_state => state_ne101, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), ne65_command => cmd_R13_ne65, ne65_state => state_ne65, ne102_command => cmd_R13_ne102, ne102_state => state_ne102, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), ne70_command => cmd_R14_ne70, ne70_state => state_ne70, ne104_command => cmd_R14_ne104, ne104_state => state_ne104, ne21_command => cmd_R14_ne21, ne21_state => state_ne21, Sw03_command => cmd_R14_Sw03, Sw03_state => state_Sw03, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), ne78_command => cmd_R15_ne78, ne78_state => state_ne78, ne93_command => cmd_R15_ne93, ne93_state => state_ne93, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), ne93_command => cmd_R16_ne93, ne93_state => state_ne93, ne96_command => cmd_R16_ne96, ne96_state => state_ne96, routeState => routes_o(15));
	route_R17 : route_16 port map(clock => clock, routeRequest => routes_i(16), ne95_command => cmd_R17_ne95, ne95_state => state_ne95, routeState => routes_o(16));
	route_R18 : route_17 port map(clock => clock, routeRequest => routes_i(17), ne94_command => cmd_R18_ne94, ne94_state => state_ne94, ne97_command => cmd_R18_ne97, ne97_state => state_ne97, routeState => routes_o(17));
	route_R19 : route_18 port map(clock => clock, routeRequest => routes_i(18), ne98_command => cmd_R19_ne98, ne98_state => state_ne98, ne105_command => cmd_R19_ne105, ne105_state => state_ne105, routeState => routes_o(18));
	route_R20 : route_19 port map(clock => clock, routeRequest => routes_i(19), ne100_command => cmd_R20_ne100, ne100_state => state_ne100, ne101_command => cmd_R20_ne101, ne101_state => state_ne101, routeState => routes_o(19));
	route_R21 : route_20 port map(clock => clock, routeRequest => routes_i(20), ne64_command => cmd_R21_ne64, ne64_state => state_ne64, ne103_command => cmd_R21_ne103, ne103_state => state_ne103, routeState => routes_o(20));
	route_R22 : route_21 port map(clock => clock, routeRequest => routes_i(21), ne99_command => cmd_R22_ne99, ne99_state => state_ne99, ne106_command => cmd_R22_ne106, ne106_state => state_ne106, routeState => routes_o(21));
	route_R23 : route_22 port map(clock => clock, routeRequest => routes_i(22), ne7_command => cmd_R23_ne7, ne7_state => state_ne7, ne9_command => cmd_R23_ne9, ne9_state => state_ne9, s68W02_command => cmd_R23_68W02, s68W02_state => state_68W02, routeState => routes_o(22));
	route_R24 : route_23 port map(clock => clock, routeRequest => routes_i(23), ne9_command => cmd_R24_ne9, ne9_state => state_ne9, ne95_command => cmd_R24_ne95, ne95_state => state_ne95, routeState => routes_o(23));
	route_R25 : route_24 port map(clock => clock, routeRequest => routes_i(24), ne59_command => cmd_R25_ne59, ne59_state => state_ne59, ne95_command => cmd_R25_ne95, ne95_state => state_ne95, Lc01_command => cmd_R25_Lc01, Lc01_state => state_Lc01, routeState => routes_o(24));
	route_R26 : route_25 port map(clock => clock, routeRequest => routes_i(25), ne9_command => cmd_R26_ne9, ne9_state => state_ne9, ne95_command => cmd_R26_ne95, ne95_state => state_ne95, Lc01_command => cmd_R26_Lc01, Lc01_state => state_Lc01, routeState => routes_o(25));
	route_R27 : route_26 port map(clock => clock, routeRequest => routes_i(26), ne23_command => cmd_R27_ne23, ne23_state => state_ne23, ne26_command => cmd_R27_ne26, ne26_state => state_ne26, s70W02_command => cmd_R27_70W02, s70W02_state => state_70W02, routeState => routes_o(26));
	route_R28 : route_27 port map(clock => clock, routeRequest => routes_i(27), ne24_command => cmd_R28_ne24, ne24_state => state_ne24, ne64_command => cmd_R28_ne64, ne64_state => state_ne64, ne103_command => cmd_R28_ne103, ne103_state => state_ne103, s70W01_command => cmd_R28_70W01, s70W01_state => state_70W01, routeState => routes_o(27));
	route_R29 : route_28 port map(clock => clock, routeRequest => routes_i(28), ne67_command => cmd_R29_ne67, ne67_state => state_ne67, ne70_command => cmd_R29_ne70, ne70_state => state_ne70, routeState => routes_o(28));
	route_R30 : route_29 port map(clock => clock, routeRequest => routes_i(29), ne67_command => cmd_R30_ne67, ne67_state => state_ne67, ne103_command => cmd_R30_ne103, ne103_state => state_ne103, routeState => routes_o(29));
	route_R31 : route_30 port map(clock => clock, routeRequest => routes_i(30), ne97_command => cmd_R31_ne97, ne97_state => state_ne97, ne99_command => cmd_R31_ne99, ne99_state => state_ne99, routeState => routes_o(30));
	route_R32 : route_31 port map(clock => clock, routeRequest => routes_i(31), ne4_command => cmd_R32_ne4, ne4_state => state_ne4, ne99_command => cmd_R32_ne99, ne99_state => state_ne99, ne106_command => cmd_R32_ne106, ne106_state => state_ne106, routeState => routes_o(31));
	route_R33 : route_32 port map(clock => clock, routeRequest => routes_i(32), ne78_command => cmd_R33_ne78, ne78_state => state_ne78, ne93_command => cmd_R33_ne93, ne93_state => state_ne93, ne96_command => cmd_R33_ne96, ne96_state => state_ne96, routeState => routes_o(32));
	route_R34 : route_33 port map(clock => clock, routeRequest => routes_i(33), ne96_command => cmd_R34_ne96, ne96_state => state_ne96, ne98_command => cmd_R34_ne98, ne98_state => state_ne98, routeState => routes_o(33));
	route_R35 : route_34 port map(clock => clock, routeRequest => routes_i(34), ne21_command => cmd_R35_ne21, ne21_state => state_ne21, routeState => routes_o(34));
	route_R36 : route_35 port map(clock => clock, routeRequest => routes_i(35), ne78_command => cmd_R36_ne78, ne78_state => state_ne78, ne79_command => cmd_R36_ne79, ne79_state => state_ne79, ne21_command => cmd_R36_ne21, ne21_state => state_ne21, Sw06_command => cmd_R36_Sw06, Sw06_state => state_Sw06, Sw07_command => cmd_R36_Sw07, Sw07_state => state_Sw07, routeState => routes_o(35));
	route_R37 : route_36 port map(clock => clock, routeRequest => routes_i(36), ne94_command => cmd_R37_ne94, ne94_state => state_ne94, ne97_command => cmd_R37_ne97, ne97_state => state_ne97, ne99_command => cmd_R37_ne99, ne99_state => state_ne99, ne21_command => cmd_R37_ne21, ne21_state => state_ne21, Sw07_command => cmd_R37_Sw07, Sw07_state => state_Sw07, routeState => routes_o(36));
	route_R38 : route_37 port map(clock => clock, routeRequest => routes_i(37), ne1_command => cmd_R38_ne1, ne1_state => state_ne1, ne9_command => cmd_R38_ne9, ne9_state => state_ne9, s68W02_command => cmd_R38_68W02, s68W02_state => state_68W02, routeState => routes_o(37));
	route_R39 : route_38 port map(clock => clock, routeRequest => routes_i(38), ne1_command => cmd_R39_ne1, ne1_state => state_ne1, ne9_command => cmd_R39_ne9, ne9_state => state_ne9, s68W02_command => cmd_R39_68W02, s68W02_state => state_68W02, routeState => routes_o(38));
	route_R40 : route_39 port map(clock => clock, routeRequest => routes_i(39), ne7_command => cmd_R40_ne7, ne7_state => state_ne7, ne9_command => cmd_R40_ne9, ne9_state => state_ne9, s68W02_command => cmd_R40_68W02, s68W02_state => state_68W02, routeState => routes_o(39));
	route_R41 : route_40 port map(clock => clock, routeRequest => routes_i(40), ne17_command => cmd_R41_ne17, ne17_state => state_ne17, ne59_command => cmd_R41_ne59, ne59_state => state_ne59, ne95_command => cmd_R41_ne95, ne95_state => state_ne95, s69W03_command => cmd_R41_69W03, s69W03_state => state_69W03, routeState => routes_o(40));
	route_R42 : route_41 port map(clock => clock, routeRequest => routes_i(41), ne11_command => cmd_R42_ne11, ne11_state => state_ne11, ne59_command => cmd_R42_ne59, ne59_state => state_ne59, ne52_command => cmd_R42_ne52, ne52_state => state_ne52, s69W03_command => cmd_R42_69W03, s69W03_state => state_69W03, s69W04_command => cmd_R42_69W04, s69W04_state => state_69W04, routeState => routes_o(41));
	route_R43 : route_42 port map(clock => clock, routeRequest => routes_i(42), ne17_command => cmd_R43_ne17, ne17_state => state_ne17, ne59_command => cmd_R43_ne59, ne59_state => state_ne59, s69W03_command => cmd_R43_69W03, s69W03_state => state_69W03, routeState => routes_o(42));
	route_R44 : route_43 port map(clock => clock, routeRequest => routes_i(43), ne11_command => cmd_R44_ne11, ne11_state => state_ne11, ne59_command => cmd_R44_ne59, ne59_state => state_ne59, ne95_command => cmd_R44_ne95, ne95_state => state_ne95, ne52_command => cmd_R44_ne52, ne52_state => state_ne52, s69W03_command => cmd_R44_69W03, s69W03_state => state_69W03, s69W04_command => cmd_R44_69W04, s69W04_state => state_69W04, routeState => routes_o(43));
	route_R45 : route_44 port map(clock => clock, routeRequest => routes_i(44), ne14_command => cmd_R45_ne14, ne14_state => state_ne14, ne52_command => cmd_R45_ne52, ne52_state => state_ne52, s69W04_command => cmd_R45_69W04, s69W04_state => state_69W04, routeState => routes_o(44));
	route_R46 : route_45 port map(clock => clock, routeRequest => routes_i(45), ne23_command => cmd_R46_ne23, ne23_state => state_ne23, ne64_command => cmd_R46_ne64, ne64_state => state_ne64, ne103_command => cmd_R46_ne103, ne103_state => state_ne103, s70W01_command => cmd_R46_70W01, s70W01_state => state_70W01, routeState => routes_o(45));
	route_R47 : route_46 port map(clock => clock, routeRequest => routes_i(46), ne23_command => cmd_R47_ne23, ne23_state => state_ne23, ne64_command => cmd_R47_ne64, ne64_state => state_ne64, s70W01_command => cmd_R47_70W01, s70W01_state => state_70W01, routeState => routes_o(46));
	route_R48 : route_47 port map(clock => clock, routeRequest => routes_i(47), ne23_command => cmd_R48_ne23, ne23_state => state_ne23, ne26_command => cmd_R48_ne26, ne26_state => state_ne26, ne64_command => cmd_R48_ne64, ne64_state => state_ne64, s70W01_command => cmd_R48_70W01, s70W01_state => state_70W01, s70W02_command => cmd_R48_70W02, s70W02_state => state_70W02, routeState => routes_o(47));
	route_R49 : route_48 port map(clock => clock, routeRequest => routes_i(48), ne24_command => cmd_R49_ne24, ne24_state => state_ne24, routeState => routes_o(48));
	route_R50 : route_49 port map(clock => clock, routeRequest => routes_i(49), ne23_command => cmd_R50_ne23, ne23_state => state_ne23, ne26_command => cmd_R50_ne26, ne26_state => state_ne26, s70W02_command => cmd_R50_70W02, s70W02_state => state_70W02, routeState => routes_o(49));
	route_R51 : route_50 port map(clock => clock, routeRequest => routes_i(50), ne24_command => cmd_R51_ne24, ne24_state => state_ne24, ne26_command => cmd_R51_ne26, ne26_state => state_ne26, s70W02_command => cmd_R51_70W02, s70W02_state => state_70W02, routeState => routes_o(50));
	route_R52 : route_51 port map(clock => clock, routeRequest => routes_i(51), ne30_command => cmd_R52_ne30, ne30_state => state_ne30, ne83_command => cmd_R52_ne83, ne83_state => state_ne83, Sw08_command => cmd_R52_Sw08, Sw08_state => state_Sw08, routeState => routes_o(51));
	route_R53 : route_52 port map(clock => clock, routeRequest => routes_i(52), ne29_command => cmd_R53_ne29, ne29_state => state_ne29, ne30_command => cmd_R53_ne30, ne30_state => state_ne30, Sw08_command => cmd_R53_Sw08, Sw08_state => state_Sw08, routeState => routes_o(52));
	route_R54 : route_53 port map(clock => clock, routeRequest => routes_i(53), ne29_command => cmd_R54_ne29, ne29_state => state_ne29, ne30_command => cmd_R54_ne30, ne30_state => state_ne30, ne110_command => cmd_R54_ne110, ne110_state => state_ne110, Sw08_command => cmd_R54_Sw08, Sw08_state => state_Sw08, Sw09_command => cmd_R54_Sw09, Sw09_state => state_Sw09, routeState => routes_o(53));
	route_R55 : route_54 port map(clock => clock, routeRequest => routes_i(54), ne30_command => cmd_R55_ne30, ne30_state => state_ne30, ne83_command => cmd_R55_ne83, ne83_state => state_ne83, Sw08_command => cmd_R55_Sw08, Sw08_state => state_Sw08, routeState => routes_o(54));
	route_R56 : route_55 port map(clock => clock, routeRequest => routes_i(55), ne32_command => cmd_R56_ne32, ne32_state => state_ne32, ne110_command => cmd_R56_ne110, ne110_state => state_ne110, Sw09_command => cmd_R56_Sw09, Sw09_state => state_Sw09, routeState => routes_o(55));
	route_R57 : route_56 port map(clock => clock, routeRequest => routes_i(56), ne29_command => cmd_R57_ne29, ne29_state => state_ne29, routeState => routes_o(56));
	route_R58 : route_57 port map(clock => clock, routeRequest => routes_i(57), ne32_command => cmd_R58_ne32, ne32_state => state_ne32, ne110_command => cmd_R58_ne110, ne110_state => state_ne110, Sw09_command => cmd_R58_Sw09, Sw09_state => state_Sw09, routeState => routes_o(57));
	route_R59 : route_58 port map(clock => clock, routeRequest => routes_i(58), ne29_command => cmd_R59_ne29, ne29_state => state_ne29, ne110_command => cmd_R59_ne110, ne110_state => state_ne110, Sw09_command => cmd_R59_Sw09, Sw09_state => state_Sw09, routeState => routes_o(58));
	route_R60 : route_59 port map(clock => clock, routeRequest => routes_i(59), ne44_command => cmd_R60_ne44, ne44_state => state_ne44, ne102_command => cmd_R60_ne102, ne102_state => state_ne102, s71W01_command => cmd_R60_71W01, s71W01_state => state_71W01, routeState => routes_o(59));
	route_R61 : route_60 port map(clock => clock, routeRequest => routes_i(60), ne43_command => cmd_R61_ne43, ne43_state => state_ne43, ne44_command => cmd_R61_ne44, ne44_state => state_ne44, ne48_command => cmd_R61_ne48, ne48_state => state_ne48, s71W01_command => cmd_R61_71W01, s71W01_state => state_71W01, s71W02_command => cmd_R61_71W02, s71W02_state => state_71W02, routeState => routes_o(60));
	route_R62 : route_61 port map(clock => clock, routeRequest => routes_i(61), ne26_command => cmd_R62_ne26, ne26_state => state_ne26, ne44_command => cmd_R62_ne44, ne44_state => state_ne44, ne65_command => cmd_R62_ne65, ne65_state => state_ne65, ne102_command => cmd_R62_ne102, ne102_state => state_ne102, s71W01_command => cmd_R62_71W01, s71W01_state => state_71W01, routeState => routes_o(61));
	route_R63 : route_62 port map(clock => clock, routeRequest => routes_i(62), ne17_command => cmd_R63_ne17, ne17_state => state_ne17, ne78_command => cmd_R63_ne78, ne78_state => state_ne78, Sw06_command => cmd_R63_Sw06, Sw06_state => state_Sw06, routeState => routes_o(62));
	route_R64 : route_63 port map(clock => clock, routeRequest => routes_i(63), ne17_command => cmd_R64_ne17, ne17_state => state_ne17, ne78_command => cmd_R64_ne78, ne78_state => state_ne78, Sw06_command => cmd_R64_Sw06, Sw06_state => state_Sw06, routeState => routes_o(63));
	route_R65 : route_64 port map(clock => clock, routeRequest => routes_i(64), ne78_command => cmd_R65_ne78, ne78_state => state_ne78, ne79_command => cmd_R65_ne79, ne79_state => state_ne79, ne77_command => cmd_R65_ne77, ne77_state => state_ne77, Sw06_command => cmd_R65_Sw06, Sw06_state => state_Sw06, Sw07_command => cmd_R65_Sw07, Sw07_state => state_Sw07, routeState => routes_o(64));
	route_R66 : route_65 port map(clock => clock, routeRequest => routes_i(65), ne78_command => cmd_R66_ne78, ne78_state => state_ne78, ne79_command => cmd_R66_ne79, ne79_state => state_ne79, ne21_command => cmd_R66_ne21, ne21_state => state_ne21, Sw06_command => cmd_R66_Sw06, Sw06_state => state_Sw06, Sw07_command => cmd_R66_Sw07, Sw07_state => state_Sw07, routeState => routes_o(65));
	route_R67 : route_66 port map(clock => clock, routeRequest => routes_i(66), ne32_command => cmd_R67_ne32, ne32_state => state_ne32, ne83_command => cmd_R67_ne83, ne83_state => state_ne83, Sw04_command => cmd_R67_Sw04, Sw04_state => state_Sw04, routeState => routes_o(66));
	route_R68 : route_67 port map(clock => clock, routeRequest => routes_i(67), ne32_command => cmd_R68_ne32, ne32_state => state_ne32, ne83_command => cmd_R68_ne83, ne83_state => state_ne83, Sw04_command => cmd_R68_Sw04, Sw04_state => state_Sw04, routeState => routes_o(67));
	route_R69 : route_68 port map(clock => clock, routeRequest => routes_i(68), ne32_command => cmd_R69_ne32, ne32_state => state_ne32, ne41_command => cmd_R69_ne41, ne41_state => state_ne41, ne82_command => cmd_R69_ne82, ne82_state => state_ne82, Sw04_command => cmd_R69_Sw04, Sw04_state => state_Sw04, Sw05_command => cmd_R69_Sw05, Sw05_state => state_Sw05, routeState => routes_o(68));
	route_R70 : route_69 port map(clock => clock, routeRequest => routes_i(69), ne32_command => cmd_R70_ne32, ne32_state => state_ne32, ne82_command => cmd_R70_ne82, ne82_state => state_ne82, ne84_command => cmd_R70_ne84, ne84_state => state_ne84, Sw04_command => cmd_R70_Sw04, Sw04_state => state_Sw04, Sw05_command => cmd_R70_Sw05, Sw05_state => state_Sw05, routeState => routes_o(69));
	route_R71 : route_70 port map(clock => clock, routeRequest => routes_i(70), ne86_command => cmd_R71_ne86, ne86_state => state_ne86, ne88_command => cmd_R71_ne88, ne88_state => state_ne88, Sw11_command => cmd_R71_Sw11, Sw11_state => state_Sw11, routeState => routes_o(70));
	route_R72 : route_71 port map(clock => clock, routeRequest => routes_i(71), ne86_command => cmd_R72_ne86, ne86_state => state_ne86, ne88_command => cmd_R72_ne88, ne88_state => state_ne88, Sw11_command => cmd_R72_Sw11, Sw11_state => state_Sw11, routeState => routes_o(71));
	route_R73 : route_72 port map(clock => clock, routeRequest => routes_i(72), ne30_command => cmd_R73_ne30, ne30_state => state_ne30, ne86_command => cmd_R73_ne86, ne86_state => state_ne86, ne87_command => cmd_R73_ne87, ne87_state => state_ne87, ne91_command => cmd_R73_ne91, ne91_state => state_ne91, Sw11_command => cmd_R73_Sw11, Sw11_state => state_Sw11, Sw12_command => cmd_R73_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R73_Sw13, Sw13_state => state_Sw13, routeState => routes_o(72));
	route_R74 : route_73 port map(clock => clock, routeRequest => routes_i(73), ne30_command => cmd_R74_ne30, ne30_state => state_ne30, ne89_command => cmd_R74_ne89, ne89_state => state_ne89, Sw12_command => cmd_R74_Sw12, Sw12_state => state_Sw12, routeState => routes_o(73));
	route_R75 : route_74 port map(clock => clock, routeRequest => routes_i(74), ne30_command => cmd_R75_ne30, ne30_state => state_ne30, ne86_command => cmd_R75_ne86, ne86_state => state_ne86, ne87_command => cmd_R75_ne87, ne87_state => state_ne87, ne91_command => cmd_R75_ne91, ne91_state => state_ne91, Sw11_command => cmd_R75_Sw11, Sw11_state => state_Sw11, Sw12_command => cmd_R75_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R75_Sw13, Sw13_state => state_Sw13, routeState => routes_o(74));
	route_R76 : route_75 port map(clock => clock, routeRequest => routes_i(75), ne30_command => cmd_R76_ne30, ne30_state => state_ne30, ne90_command => cmd_R76_ne90, ne90_state => state_ne90, ne91_command => cmd_R76_ne91, ne91_state => state_ne91, Sw12_command => cmd_R76_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R76_Sw13, Sw13_state => state_Sw13, routeState => routes_o(75));
	route_R77 : route_76 port map(clock => clock, routeRequest => routes_i(76), ne32_command => cmd_R77_ne32, ne32_state => state_ne32, ne41_command => cmd_R77_ne41, ne41_state => state_ne41, ne82_command => cmd_R77_ne82, ne82_state => state_ne82, Sw04_command => cmd_R77_Sw04, Sw04_state => state_Sw04, Sw05_command => cmd_R77_Sw05, Sw05_state => state_Sw05, routeState => routes_o(76));
	route_R78 : route_77 port map(clock => clock, routeRequest => routes_i(77), ne41_command => cmd_R78_ne41, ne41_state => state_ne41, ne44_command => cmd_R78_ne44, ne44_state => state_ne44, ne100_command => cmd_R78_ne100, ne100_state => state_ne100, ne101_command => cmd_R78_ne101, ne101_state => state_ne101, ne85_command => cmd_R78_ne85, ne85_state => state_ne85, Sw05_command => cmd_R78_Sw05, Sw05_state => state_Sw05, Sw41_command => cmd_R78_Sw41, Sw41_state => state_Sw41, routeState => routes_o(77));
	route_R79 : route_78 port map(clock => clock, routeRequest => routes_i(78), ne41_command => cmd_R79_ne41, ne41_state => state_ne41, ne85_command => cmd_R79_ne85, ne85_state => state_ne85, Sw05_command => cmd_R79_Sw05, Sw05_state => state_Sw05, routeState => routes_o(78));
	route_R80 : route_79 port map(clock => clock, routeRequest => routes_i(79), ne84_command => cmd_R80_ne84, ne84_state => state_ne84, ne85_command => cmd_R80_ne85, ne85_state => state_ne85, Sw05_command => cmd_R80_Sw05, Sw05_state => state_Sw05, routeState => routes_o(79));
	route_R81 : route_80 port map(clock => clock, routeRequest => routes_i(80), ne77_command => cmd_R81_ne77, ne77_state => state_ne77, ne52_command => cmd_R81_ne52, ne52_state => state_ne52, routeState => routes_o(80));
	route_R82 : route_81 port map(clock => clock, routeRequest => routes_i(81), ne94_command => cmd_R82_ne94, ne94_state => state_ne94, ne77_command => cmd_R82_ne77, ne77_state => state_ne77, Sw07_command => cmd_R82_Sw07, Sw07_state => state_Sw07, routeState => routes_o(81));
	route_R83 : route_82 port map(clock => clock, routeRequest => routes_i(82), ne94_command => cmd_R83_ne94, ne94_state => state_ne94, ne21_command => cmd_R83_ne21, ne21_state => state_ne21, Sw07_command => cmd_R83_Sw07, Sw07_state => state_Sw07, routeState => routes_o(82));
	route_R84 : route_83 port map(clock => clock, routeRequest => routes_i(83), ne44_command => cmd_R84_ne44, ne44_state => state_ne44, ne100_command => cmd_R84_ne100, ne100_state => state_ne100, ne101_command => cmd_R84_ne101, ne101_state => state_ne101, ne110_command => cmd_R84_ne110, ne110_state => state_ne110, Sw41_command => cmd_R84_Sw41, Sw41_state => state_Sw41, routeState => routes_o(83));
	route_R85 : route_84 port map(clock => clock, routeRequest => routes_i(84), ne100_command => cmd_R85_ne100, ne100_state => state_ne100, ne110_command => cmd_R85_ne110, ne110_state => state_ne110, Sw41_command => cmd_R85_Sw41, Sw41_state => state_Sw41, routeState => routes_o(84));
	route_R86 : route_85 port map(clock => clock, routeRequest => routes_i(85), ne100_command => cmd_R86_ne100, ne100_state => state_ne100, ne85_command => cmd_R86_ne85, ne85_state => state_ne85, Sw41_command => cmd_R86_Sw41, Sw41_state => state_Sw41, routeState => routes_o(85));
	route_R87 : route_86 port map(clock => clock, routeRequest => routes_i(86), ne70_command => cmd_R87_ne70, ne70_state => state_ne70, ne104_command => cmd_R87_ne104, ne104_state => state_ne104, routeState => routes_o(86));
	route_R88 : route_87 port map(clock => clock, routeRequest => routes_i(87), ne104_command => cmd_R88_ne104, ne104_state => state_ne104, ne21_command => cmd_R88_ne21, ne21_state => state_ne21, routeState => routes_o(87));
	route_R89 : route_88 port map(clock => clock, routeRequest => routes_i(88), ne78_command => cmd_R89_ne78, ne78_state => state_ne78, ne79_command => cmd_R89_ne79, ne79_state => state_ne79, ne77_command => cmd_R89_ne77, ne77_state => state_ne77, Sw06_command => cmd_R89_Sw06, Sw06_state => state_Sw06, Sw07_command => cmd_R89_Sw07, Sw07_state => state_Sw07, routeState => routes_o(88));
	route_R90 : route_89 port map(clock => clock, routeRequest => routes_i(89), ne94_command => cmd_R90_ne94, ne94_state => state_ne94, ne97_command => cmd_R90_ne97, ne97_state => state_ne97, ne99_command => cmd_R90_ne99, ne99_state => state_ne99, ne77_command => cmd_R90_ne77, ne77_state => state_ne77, Sw07_command => cmd_R90_Sw07, Sw07_state => state_Sw07, routeState => routes_o(89));
	route_R91 : route_90 port map(clock => clock, routeRequest => routes_i(90), ne77_command => cmd_R91_ne77, ne77_state => state_ne77, ne52_command => cmd_R91_ne52, ne52_state => state_ne52, routeState => routes_o(90));
end Behavioral;