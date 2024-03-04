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
			R2_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw01 : out singleSwitchStates
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			R2_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw03 : out singleSwitchStates
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			R7_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw02 : out singleSwitchStates
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw05 : out singleSwitchStates
		);
	end component singleSwitch_3;
	component singleSwitch_4 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw08 : out singleSwitchStates
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
			R2_command : in routeCommands;
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
			R2_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			state : out nodeStates
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R14_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			state : out nodeStates
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R12_command : in routeCommands;
			R17_command : in routeCommands;
			R21_command : in routeCommands;
			state : out nodeStates
		);
	end component node_6;
	component node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R18_command : in routeCommands;
			state : out nodeStates
		);
	end component node_7;
	component node_8 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R19_command : in routeCommands;
			state : out nodeStates
		);
	end component node_8;
	component node_9 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			state : out nodeStates
		);
	end component node_9;
	component node_10 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R20_command : in routeCommands;
			R22_command : in routeCommands;
			state : out nodeStates
		);
	end component node_10;
	component route_0 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne4_state : in nodeStates;
			ne4_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne6_state : in nodeStates;
			ne6_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne10_state : in nodeStates;
			ne10_command : out routeCommands;
			ne5_state : in nodeStates;
			ne5_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne11_state : in nodeStates;
			ne11_command : out routeCommands;
			ne5_state : in nodeStates;
			ne5_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne5_state : in nodeStates;
			ne5_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			ne6_state : in nodeStates;
			ne6_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne4_state : in nodeStates;
			ne4_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			ne5_state : in nodeStates;
			ne5_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			ne4_state : in nodeStates;
			ne4_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_15;
	component route_16 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_16;
	component route_17 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne5_state : in nodeStates;
			ne5_command : out routeCommands;
			ne10_state : in nodeStates;
			ne10_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_17;
	component route_18 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne5_state : in nodeStates;
			ne5_command : out routeCommands;
			ne11_state : in nodeStates;
			ne11_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_18;
	component route_19 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_19;
	component route_20 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_20;
	component route_21 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_21;

 signal  : levelCrossingStates;
 signal state_Sw01 , state_Sw03 , state_Sw02 , state_Sw05 , state_Sw08 : singleSwitchStates;
 signal state_ne1 , state_ne2 , state_ne3 , state_ne4 , state_ne5 , state_ne6 , state_ne7 , state_ne10 , state_ne11 , state_ne41 , state_ne42 : nodeStates;
 signal cmd_R1_ne4 , cmd_R2_ne6 , cmd_R2_ne2 , cmd_R2_ne1 , cmd_R3_ne10 , cmd_R3_ne5 , cmd_R4_ne41 , cmd_R5_ne42 , cmd_R5_ne41 , cmd_R6_ne11 , cmd_R6_ne5 , cmd_R7_ne5 , cmd_R7_ne3 , cmd_R8_ne7 , cmd_R8_ne41 , cmd_R9_ne7 , cmd_R10_ne3 , cmd_R10_ne1 , cmd_R11_ne1 , cmd_R11_ne3 , cmd_R12_ne1 , cmd_R12_ne2 , cmd_R12_ne7 , cmd_R13_ne1 , cmd_R13_ne2 , cmd_R13_ne6 , cmd_R14_ne4 , cmd_R14_ne3 , cmd_R15_ne3 , cmd_R15_ne5 , cmd_R16_ne3 , cmd_R16_ne4 , cmd_R17_ne7 , cmd_R17_ne2 , cmd_R17_ne1 , cmd_R18_ne5 , cmd_R18_ne10 , cmd_R19_ne5 , cmd_R19_ne11 , cmd_R20_ne42 , cmd_R21_ne41 , cmd_R21_ne7 , cmd_R22_ne41 , cmd_R22_ne42 : routeCommands;
 signal  : routeCommands;
 signal cmd_R2_Sw01 , cmd_R2_Sw03 , cmd_R3_Sw05 , cmd_R5_Sw08 , cmd_R6_Sw05 , cmd_R7_Sw02 , cmd_R8_Sw08 , cmd_R10_Sw01 , cmd_R11_Sw01 , cmd_R12_Sw01 , cmd_R12_Sw03 , cmd_R13_Sw01 , cmd_R13_Sw03 , cmd_R14_Sw02 , cmd_R15_Sw02 , cmd_R16_Sw02 , cmd_R17_Sw01 , cmd_R17_Sw03 , cmd_R18_Sw05 , cmd_R19_Sw05 , cmd_R21_Sw08 , cmd_R22_Sw08 : routeCommands;
begin
	singleSwitch_Sw01 : singleSwitch_0 port map(clock => clock, R2_command => cmd_R2_Sw01, R10_command => cmd_R10_Sw01, R11_command => cmd_R11_Sw01, R12_command => cmd_R12_Sw01, R13_command => cmd_R13_Sw01, R17_command => cmd_R17_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence_Sw01 => state_Sw01);
	singleSwitch_Sw03 : singleSwitch_1 port map(clock => clock, R2_command => cmd_R2_Sw03, R12_command => cmd_R12_Sw03, R13_command => cmd_R13_Sw03, R17_command => cmd_R17_Sw03, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence_Sw03 => state_Sw03);
	singleSwitch_Sw02 : singleSwitch_2 port map(clock => clock, R7_command => cmd_R7_Sw02, R14_command => cmd_R14_Sw02, R15_command => cmd_R15_Sw02, R16_command => cmd_R16_Sw02, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence_Sw02 => state_Sw02);
	singleSwitch_Sw05 : singleSwitch_3 port map(clock => clock, R3_command => cmd_R3_Sw05, R6_command => cmd_R6_Sw05, R18_command => cmd_R18_Sw05, R19_command => cmd_R19_Sw05, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence_Sw05 => state_Sw05);
	singleSwitch_Sw08 : singleSwitch_4 port map(clock => clock, R5_command => cmd_R5_Sw08, R8_command => cmd_R8_Sw08, R21_command => cmd_R21_Sw08, R22_command => cmd_R22_Sw08, indication => singleSwitches_i(4), command => singleSwitches_o(4), correspondence_Sw08 => state_Sw08);
	node_ne1 : node_0 port map(clock => clock, ocupation => ocupation(0), R2_command => cmd_R2_ne1, R10_command => cmd_R10_ne1, R11_command => cmd_R11_ne1, R12_command => cmd_R12_ne1, R13_command => cmd_R13_ne1, R17_command => cmd_R17_ne1, state => state_ne1);
	node_ne2 : node_1 port map(clock => clock, ocupation => ocupation(1), R2_command => cmd_R2_ne2, R12_command => cmd_R12_ne2, R13_command => cmd_R13_ne2, R17_command => cmd_R17_ne2, state => state_ne2);
	node_ne3 : node_2 port map(clock => clock, ocupation => ocupation(2), R7_command => cmd_R7_ne3, R10_command => cmd_R10_ne3, R11_command => cmd_R11_ne3, R14_command => cmd_R14_ne3, R15_command => cmd_R15_ne3, R16_command => cmd_R16_ne3, state => state_ne3);
	node_ne4 : node_3 port map(clock => clock, ocupation => ocupation(3), R1_command => cmd_R1_ne4, R14_command => cmd_R14_ne4, R16_command => cmd_R16_ne4, state => state_ne4);
	node_ne5 : node_4 port map(clock => clock, ocupation => ocupation(4), R3_command => cmd_R3_ne5, R6_command => cmd_R6_ne5, R7_command => cmd_R7_ne5, R15_command => cmd_R15_ne5, R18_command => cmd_R18_ne5, R19_command => cmd_R19_ne5, state => state_ne5);
	node_ne6 : node_5 port map(clock => clock, ocupation => ocupation(5), R2_command => cmd_R2_ne6, R13_command => cmd_R13_ne6, state => state_ne6);
	node_ne7 : node_6 port map(clock => clock, ocupation => ocupation(6), R8_command => cmd_R8_ne7, R9_command => cmd_R9_ne7, R12_command => cmd_R12_ne7, R17_command => cmd_R17_ne7, R21_command => cmd_R21_ne7, state => state_ne7);
	node_ne10 : node_7 port map(clock => clock, ocupation => ocupation(7), R3_command => cmd_R3_ne10, R18_command => cmd_R18_ne10, state => state_ne10);
	node_ne11 : node_8 port map(clock => clock, ocupation => ocupation(8), R6_command => cmd_R6_ne11, R19_command => cmd_R19_ne11, state => state_ne11);
	node_ne41 : node_9 port map(clock => clock, ocupation => ocupation(9), R4_command => cmd_R4_ne41, R5_command => cmd_R5_ne41, R8_command => cmd_R8_ne41, R21_command => cmd_R21_ne41, R22_command => cmd_R22_ne41, state => state_ne41);
	node_ne42 : node_10 port map(clock => clock, ocupation => ocupation(10), R5_command => cmd_R5_ne42, R20_command => cmd_R20_ne42, R22_command => cmd_R22_ne42, state => state_ne42);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne4_command => cmd_R1_ne4, ne4_state => state_ne4, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne1_command => cmd_R2_ne1, ne1_state => state_ne1, ne2_command => cmd_R2_ne2, ne2_state => state_ne2, ne6_command => cmd_R2_ne6, ne6_state => state_ne6, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R2_Sw03, Sw03_state => state_Sw03, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne5_command => cmd_R3_ne5, ne5_state => state_ne5, ne10_command => cmd_R3_ne10, ne10_state => state_ne10, Sw05_command => cmd_R3_Sw05, Sw05_state => state_Sw05, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne41_command => cmd_R4_ne41, ne41_state => state_ne41, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne41_command => cmd_R5_ne41, ne41_state => state_ne41, ne42_command => cmd_R5_ne42, ne42_state => state_ne42, Sw08_command => cmd_R5_Sw08, Sw08_state => state_Sw08, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne5_command => cmd_R6_ne5, ne5_state => state_ne5, ne11_command => cmd_R6_ne11, ne11_state => state_ne11, Sw05_command => cmd_R6_Sw05, Sw05_state => state_Sw05, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne3_command => cmd_R7_ne3, ne3_state => state_ne3, ne5_command => cmd_R7_ne5, ne5_state => state_ne5, Sw02_command => cmd_R7_Sw02, Sw02_state => state_Sw02, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne7_command => cmd_R8_ne7, ne7_state => state_ne7, ne41_command => cmd_R8_ne41, ne41_state => state_ne41, Sw08_command => cmd_R8_Sw08, Sw08_state => state_Sw08, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne7_command => cmd_R9_ne7, ne7_state => state_ne7, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne1_command => cmd_R10_ne1, ne1_state => state_ne1, ne3_command => cmd_R10_ne3, ne3_state => state_ne3, Sw01_command => cmd_R10_Sw01, Sw01_state => state_Sw01, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), ne1_command => cmd_R11_ne1, ne1_state => state_ne1, ne3_command => cmd_R11_ne3, ne3_state => state_ne3, Sw01_command => cmd_R11_Sw01, Sw01_state => state_Sw01, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), ne1_command => cmd_R12_ne1, ne1_state => state_ne1, ne2_command => cmd_R12_ne2, ne2_state => state_ne2, ne7_command => cmd_R12_ne7, ne7_state => state_ne7, Sw01_command => cmd_R12_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R12_Sw03, Sw03_state => state_Sw03, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), ne1_command => cmd_R13_ne1, ne1_state => state_ne1, ne2_command => cmd_R13_ne2, ne2_state => state_ne2, ne6_command => cmd_R13_ne6, ne6_state => state_ne6, Sw01_command => cmd_R13_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R13_Sw03, Sw03_state => state_Sw03, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), ne3_command => cmd_R14_ne3, ne3_state => state_ne3, ne4_command => cmd_R14_ne4, ne4_state => state_ne4, Sw02_command => cmd_R14_Sw02, Sw02_state => state_Sw02, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), ne3_command => cmd_R15_ne3, ne3_state => state_ne3, ne5_command => cmd_R15_ne5, ne5_state => state_ne5, Sw02_command => cmd_R15_Sw02, Sw02_state => state_Sw02, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), ne3_command => cmd_R16_ne3, ne3_state => state_ne3, ne4_command => cmd_R16_ne4, ne4_state => state_ne4, Sw02_command => cmd_R16_Sw02, Sw02_state => state_Sw02, routeState => routes_o(15));
	route_R17 : route_16 port map(clock => clock, routeRequest => routes_i(16), ne1_command => cmd_R17_ne1, ne1_state => state_ne1, ne2_command => cmd_R17_ne2, ne2_state => state_ne2, ne7_command => cmd_R17_ne7, ne7_state => state_ne7, Sw01_command => cmd_R17_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R17_Sw03, Sw03_state => state_Sw03, routeState => routes_o(16));
	route_R18 : route_17 port map(clock => clock, routeRequest => routes_i(17), ne5_command => cmd_R18_ne5, ne5_state => state_ne5, ne10_command => cmd_R18_ne10, ne10_state => state_ne10, Sw05_command => cmd_R18_Sw05, Sw05_state => state_Sw05, routeState => routes_o(17));
	route_R19 : route_18 port map(clock => clock, routeRequest => routes_i(18), ne5_command => cmd_R19_ne5, ne5_state => state_ne5, ne11_command => cmd_R19_ne11, ne11_state => state_ne11, Sw05_command => cmd_R19_Sw05, Sw05_state => state_Sw05, routeState => routes_o(18));
	route_R20 : route_19 port map(clock => clock, routeRequest => routes_i(19), ne42_command => cmd_R20_ne42, ne42_state => state_ne42, routeState => routes_o(19));
	route_R21 : route_20 port map(clock => clock, routeRequest => routes_i(20), ne7_command => cmd_R21_ne7, ne7_state => state_ne7, ne41_command => cmd_R21_ne41, ne41_state => state_ne41, Sw08_command => cmd_R21_Sw08, Sw08_state => state_Sw08, routeState => routes_o(20));
	route_R22 : route_21 port map(clock => clock, routeRequest => routes_i(21), ne41_command => cmd_R22_ne41, ne41_state => state_ne41, ne42_command => cmd_R22_ne42, ne42_state => state_ne42, Sw08_command => cmd_R22_Sw08, Sw08_state => state_Sw08, routeState => routes_o(21));
end Behavioral;