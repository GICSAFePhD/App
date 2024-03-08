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
			correspondence_Lc08 : out levelCrossingStates
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
			correspondence_Lc06 : out levelCrossingStates
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
			correspondence_Sw04 : out singleSwitchStates
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
			correspondence_Sw06 : out singleSwitchStates
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
			correspondence_Sw12 : out singleSwitchStates
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
			correspondence_Sw07 : out singleSwitchStates
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
			correspondence_Sw13 : out singleSwitchStates
		);
	end component singleSwitch_4;
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
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates
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
			state : out nodeStates
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
			state : out nodeStates
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
			state : out nodeStates
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
			state : out nodeStates
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R9_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates
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
			state : out nodeStates
		);
	end component node_6;
	component node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates
		);
	end component node_7;
	component node_8 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R18_command : in routeCommands;
			state : out nodeStates
		);
	end component node_8;
	component node_9 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R20_command : in routeCommands;
			state : out nodeStates
		);
	end component node_9;
	component node_10 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates
		);
	end component node_10;
	component route_0 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne13_state : in nodeStates;
			ne13_command : out routeCommands;
			Lc08_state : in levelCrossingStates;
			Lc08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne15_state : in nodeStates;
			ne15_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne22_state : in nodeStates;
			ne22_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne22_state : in nodeStates;
			ne22_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne13_state : in nodeStates;
			ne13_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne8_state : in nodeStates;
			ne8_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			ne15_state : in nodeStates;
			ne15_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			ne13_state : in nodeStates;
			ne13_command : out routeCommands;
			Lc08_state : in levelCrossingStates;
			Lc08_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_15;
	component route_16 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne15_state : in nodeStates;
			ne15_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_16;
	component route_17 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne8_state : in nodeStates;
			ne8_command : out routeCommands;
			ne22_state : in nodeStates;
			ne22_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_17;
	component route_18 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne8_state : in nodeStates;
			ne8_command : out routeCommands;
			ne24_state : in nodeStates;
			ne24_command : out routeCommands;
			ne12_state : in nodeStates;
			ne12_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_18;
	component route_19 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_19;
	component route_20 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_command : out routeCommands;
			ne24_state : in nodeStates;
			ne24_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_20;

 signal state_Lc08 , state_Lc06 : levelCrossingStates;
 signal state_Sw04 , state_Sw06 , state_Sw12 , state_Sw07 , state_Sw13 : singleSwitchStates;
 signal state_ne1 , state_ne2 , state_ne8 , state_ne9 , state_ne12 , state_ne13 , state_ne14 , state_ne15 , state_ne22 , state_ne23 , state_ne24 : nodeStates;
 signal cmd_R1_ne13 , cmd_R2_ne14 , cmd_R3_ne15 , cmd_R4_ne22 , cmd_R5_ne22 , cmd_R5_ne8 , cmd_R6_ne23 , cmd_R6_ne12 , cmd_R7_ne14 , cmd_R8_ne14 , cmd_R8_ne9 , cmd_R8_ne1 , cmd_R9_ne13 , cmd_R9_ne2 , cmd_R10_ne8 , cmd_R10_ne1 , cmd_R11_ne1 , cmd_R11_ne8 , cmd_R12_ne1 , cmd_R12_ne9 , cmd_R12_ne14 , cmd_R13_ne1 , cmd_R13_ne9 , cmd_R13_ne15 , cmd_R14_ne12 , cmd_R14_ne2 , cmd_R15_ne2 , cmd_R15_ne12 , cmd_R16_ne2 , cmd_R16_ne13 , cmd_R17_ne15 , cmd_R17_ne9 , cmd_R17_ne1 , cmd_R18_ne8 , cmd_R18_ne22 , cmd_R19_ne8 , cmd_R19_ne24 , cmd_R19_ne12 , cmd_R20_ne12 , cmd_R20_ne23 , cmd_R21_ne12 , cmd_R21_ne24 , cmd_R21_ne8 : routeCommands;
 signal cmd_R1_Lc08 , cmd_R7_Lc06 , cmd_R8_Lc06 , cmd_R16_Lc08 : routeCommands;
 signal cmd_R5_Sw12 , cmd_R6_Sw13 , cmd_R8_Sw04 , cmd_R8_Sw07 , cmd_R9_Sw06 , cmd_R10_Sw04 , cmd_R11_Sw04 , cmd_R12_Sw04 , cmd_R12_Sw07 , cmd_R13_Sw04 , cmd_R13_Sw07 , cmd_R14_Sw06 , cmd_R15_Sw06 , cmd_R16_Sw06 , cmd_R17_Sw04 , cmd_R17_Sw07 , cmd_R18_Sw12 , cmd_R19_Sw12 , cmd_R19_Sw13 , cmd_R20_Sw13 , cmd_R21_Sw12 , cmd_R21_Sw13 : routeCommands;
begin
	levelCrossing_Lc08 : levelCrossing_0 port map(clock => clock, R1_command => cmd_R1_Lc08, R16_command => cmd_R16_Lc08, ocupation_ne13 => ocupation(5), ocupation_ne2 => ocupation(1), indication => levelCrossings_i(0), command  => levelCrossings_o(0), correspondence_Lc08 => state_Lc08);
	levelCrossing_Lc06 : levelCrossing_1 port map(clock => clock, R7_command => cmd_R7_Lc06, R8_command => cmd_R8_Lc06, ocupation_ne14 => ocupation(6), ocupation_ne9 => ocupation(3), indication => levelCrossings_i(1), command  => levelCrossings_o(1), correspondence_Lc06 => state_Lc06);
	singleSwitch_Sw04 : singleSwitch_0 port map(clock => clock, R8_command => cmd_R8_Sw04, R10_command => cmd_R10_Sw04, R11_command => cmd_R11_Sw04, R12_command => cmd_R12_Sw04, R13_command => cmd_R13_Sw04, R17_command => cmd_R17_Sw04, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence_Sw04 => state_Sw04);
	singleSwitch_Sw06 : singleSwitch_1 port map(clock => clock, R9_command => cmd_R9_Sw06, R14_command => cmd_R14_Sw06, R15_command => cmd_R15_Sw06, R16_command => cmd_R16_Sw06, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence_Sw06 => state_Sw06);
	singleSwitch_Sw12 : singleSwitch_2 port map(clock => clock, R5_command => cmd_R5_Sw12, R18_command => cmd_R18_Sw12, R19_command => cmd_R19_Sw12, R21_command => cmd_R21_Sw12, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence_Sw12 => state_Sw12);
	singleSwitch_Sw07 : singleSwitch_3 port map(clock => clock, R8_command => cmd_R8_Sw07, R12_command => cmd_R12_Sw07, R13_command => cmd_R13_Sw07, R17_command => cmd_R17_Sw07, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence_Sw07 => state_Sw07);
	singleSwitch_Sw13 : singleSwitch_4 port map(clock => clock, R6_command => cmd_R6_Sw13, R19_command => cmd_R19_Sw13, R20_command => cmd_R20_Sw13, R21_command => cmd_R21_Sw13, indication => singleSwitches_i(4), command => singleSwitches_o(4), correspondence_Sw13 => state_Sw13);
	node_ne1 : node_0 port map(clock => clock, ocupation => ocupation(0), R8_command => cmd_R8_ne1, R10_command => cmd_R10_ne1, R11_command => cmd_R11_ne1, R12_command => cmd_R12_ne1, R13_command => cmd_R13_ne1, R17_command => cmd_R17_ne1, state => state_ne1);
	node_ne2 : node_1 port map(clock => clock, ocupation => ocupation(1), R9_command => cmd_R9_ne2, R14_command => cmd_R14_ne2, R15_command => cmd_R15_ne2, R16_command => cmd_R16_ne2, state => state_ne2);
	node_ne8 : node_2 port map(clock => clock, ocupation => ocupation(2), R5_command => cmd_R5_ne8, R10_command => cmd_R10_ne8, R11_command => cmd_R11_ne8, R18_command => cmd_R18_ne8, R19_command => cmd_R19_ne8, R21_command => cmd_R21_ne8, state => state_ne8);
	node_ne9 : node_3 port map(clock => clock, ocupation => ocupation(3), R8_command => cmd_R8_ne9, R12_command => cmd_R12_ne9, R13_command => cmd_R13_ne9, R17_command => cmd_R17_ne9, state => state_ne9);
	node_ne12 : node_4 port map(clock => clock, ocupation => ocupation(4), R6_command => cmd_R6_ne12, R14_command => cmd_R14_ne12, R15_command => cmd_R15_ne12, R19_command => cmd_R19_ne12, R20_command => cmd_R20_ne12, R21_command => cmd_R21_ne12, state => state_ne12);
	node_ne13 : node_5 port map(clock => clock, ocupation => ocupation(5), R1_command => cmd_R1_ne13, R9_command => cmd_R9_ne13, R16_command => cmd_R16_ne13, state => state_ne13);
	node_ne14 : node_6 port map(clock => clock, ocupation => ocupation(6), R2_command => cmd_R2_ne14, R7_command => cmd_R7_ne14, R8_command => cmd_R8_ne14, R12_command => cmd_R12_ne14, state => state_ne14);
	node_ne15 : node_7 port map(clock => clock, ocupation => ocupation(7), R3_command => cmd_R3_ne15, R13_command => cmd_R13_ne15, R17_command => cmd_R17_ne15, state => state_ne15);
	node_ne22 : node_8 port map(clock => clock, ocupation => ocupation(8), R4_command => cmd_R4_ne22, R5_command => cmd_R5_ne22, R18_command => cmd_R18_ne22, state => state_ne22);
	node_ne23 : node_9 port map(clock => clock, ocupation => ocupation(9), R6_command => cmd_R6_ne23, R20_command => cmd_R20_ne23, state => state_ne23);
	node_ne24 : node_10 port map(clock => clock, ocupation => ocupation(10), R19_command => cmd_R19_ne24, R21_command => cmd_R21_ne24, state => state_ne24);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne13_command => cmd_R1_ne13, ne13_state => state_ne13, Lc08_command => cmd_R1_Lc08, Lc08_state => state_Lc08, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne14_command => cmd_R2_ne14, ne14_state => state_ne14, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne15_command => cmd_R3_ne15, ne15_state => state_ne15, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne22_command => cmd_R4_ne22, ne22_state => state_ne22, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne8_command => cmd_R5_ne8, ne8_state => state_ne8, ne22_command => cmd_R5_ne22, ne22_state => state_ne22, Sw12_command => cmd_R5_Sw12, Sw12_state => state_Sw12, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne12_command => cmd_R6_ne12, ne12_state => state_ne12, ne23_command => cmd_R6_ne23, ne23_state => state_ne23, Sw13_command => cmd_R6_Sw13, Sw13_state => state_Sw13, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne14_command => cmd_R7_ne14, ne14_state => state_ne14, Lc06_command => cmd_R7_Lc06, Lc06_state => state_Lc06, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne1_command => cmd_R8_ne1, ne1_state => state_ne1, ne9_command => cmd_R8_ne9, ne9_state => state_ne9, ne14_command => cmd_R8_ne14, ne14_state => state_ne14, Lc06_command => cmd_R8_Lc06, Lc06_state => state_Lc06, Sw04_command => cmd_R8_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R8_Sw07, Sw07_state => state_Sw07, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne2_command => cmd_R9_ne2, ne2_state => state_ne2, ne13_command => cmd_R9_ne13, ne13_state => state_ne13, Sw06_command => cmd_R9_Sw06, Sw06_state => state_Sw06, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne1_command => cmd_R10_ne1, ne1_state => state_ne1, ne8_command => cmd_R10_ne8, ne8_state => state_ne8, Sw04_command => cmd_R10_Sw04, Sw04_state => state_Sw04, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), ne1_command => cmd_R11_ne1, ne1_state => state_ne1, ne8_command => cmd_R11_ne8, ne8_state => state_ne8, Sw04_command => cmd_R11_Sw04, Sw04_state => state_Sw04, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), ne1_command => cmd_R12_ne1, ne1_state => state_ne1, ne9_command => cmd_R12_ne9, ne9_state => state_ne9, ne14_command => cmd_R12_ne14, ne14_state => state_ne14, Sw04_command => cmd_R12_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R12_Sw07, Sw07_state => state_Sw07, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), ne1_command => cmd_R13_ne1, ne1_state => state_ne1, ne9_command => cmd_R13_ne9, ne9_state => state_ne9, ne15_command => cmd_R13_ne15, ne15_state => state_ne15, Sw04_command => cmd_R13_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R13_Sw07, Sw07_state => state_Sw07, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), ne2_command => cmd_R14_ne2, ne2_state => state_ne2, ne12_command => cmd_R14_ne12, ne12_state => state_ne12, Sw06_command => cmd_R14_Sw06, Sw06_state => state_Sw06, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), ne2_command => cmd_R15_ne2, ne2_state => state_ne2, ne12_command => cmd_R15_ne12, ne12_state => state_ne12, Sw06_command => cmd_R15_Sw06, Sw06_state => state_Sw06, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), ne2_command => cmd_R16_ne2, ne2_state => state_ne2, ne13_command => cmd_R16_ne13, ne13_state => state_ne13, Lc08_command => cmd_R16_Lc08, Lc08_state => state_Lc08, Sw06_command => cmd_R16_Sw06, Sw06_state => state_Sw06, routeState => routes_o(15));
	route_R17 : route_16 port map(clock => clock, routeRequest => routes_i(16), ne1_command => cmd_R17_ne1, ne1_state => state_ne1, ne9_command => cmd_R17_ne9, ne9_state => state_ne9, ne15_command => cmd_R17_ne15, ne15_state => state_ne15, Sw04_command => cmd_R17_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R17_Sw07, Sw07_state => state_Sw07, routeState => routes_o(16));
	route_R18 : route_17 port map(clock => clock, routeRequest => routes_i(17), ne8_command => cmd_R18_ne8, ne8_state => state_ne8, ne22_command => cmd_R18_ne22, ne22_state => state_ne22, Sw12_command => cmd_R18_Sw12, Sw12_state => state_Sw12, routeState => routes_o(17));
	route_R19 : route_18 port map(clock => clock, routeRequest => routes_i(18), ne8_command => cmd_R19_ne8, ne8_state => state_ne8, ne12_command => cmd_R19_ne12, ne12_state => state_ne12, ne24_command => cmd_R19_ne24, ne24_state => state_ne24, Sw12_command => cmd_R19_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R19_Sw13, Sw13_state => state_Sw13, routeState => routes_o(18));
	route_R20 : route_19 port map(clock => clock, routeRequest => routes_i(19), ne12_command => cmd_R20_ne12, ne12_state => state_ne12, ne23_command => cmd_R20_ne23, ne23_state => state_ne23, Sw13_command => cmd_R20_Sw13, Sw13_state => state_Sw13, routeState => routes_o(19));
	route_R21 : route_20 port map(clock => clock, routeRequest => routes_i(20), ne8_command => cmd_R21_ne8, ne8_state => state_ne8, ne12_command => cmd_R21_ne12, ne12_state => state_ne12, ne24_command => cmd_R21_ne24, ne24_state => state_ne24, Sw12_command => cmd_R21_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R21_Sw13, Sw13_state => state_Sw13, routeState => routes_o(20));
end Behavioral;