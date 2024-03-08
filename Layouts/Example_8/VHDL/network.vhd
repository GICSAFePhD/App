--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 56;
			N_SIGNALS : natural := 16;
			N_ROUTES : natural := 13;
			N_LEVELCROSSINGS : natural := 4;
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
			ocupation_ne3 : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne27 : in std_logic;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc06 : out levelCrossingStates
		);
	end component levelCrossing_0;
	component levelCrossing_1 is
		port(
			clock : in std_logic;
			ocupation_ne23 : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne27 : in std_logic;
			R3_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc07 : out levelCrossingStates
		);
	end component levelCrossing_1;
	component levelCrossing_2 is
		port(
			clock : in std_logic;
			ocupation_ne23 : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne27 : in std_logic;
			R4_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc09 : out levelCrossingStates
		);
	end component levelCrossing_2;
	component levelCrossing_3 is
		port(
			clock : in std_logic;
			ocupation_ne25 : in std_logic;
			ocupation_ne23 : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc05 : out levelCrossingStates
		);
	end component levelCrossing_3;
	component levelCrossing_4 is
		port(
			clock : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne3 : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc03 : out levelCrossingStates
		);
	end component levelCrossing_4;
	component levelCrossing_5 is
		port(
			clock : in std_logic;
			ocupation_ne26 : in std_logic;
			ocupation_ne3 : in std_logic;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Lc04 : out levelCrossingStates
		);
	end component levelCrossing_5;
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw12 : out singleSwitchStates
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw11 : out singleSwitchStates
		);
	end component singleSwitch_1;
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
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R6_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			state : out nodeStates
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			state : out nodeStates
		);
	end component node_4;
	component route_0 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc03_command : out routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			Lc07_state : in levelCrossingStates;
			Lc07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne25_state : in nodeStates;
			ne25_command : out routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc05_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne25_state : in nodeStates;
			ne25_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc05_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			Lc07_state : in levelCrossingStates;
			Lc07_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			ne25_state : in nodeStates;
			ne25_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			ne27_state : in nodeStates;
			ne27_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc04_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			ne27_state : in nodeStates;
			ne27_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_12;

 signal state_Lc06 , state_Lc07 , state_Lc09 , state_Lc05 , state_Lc03 , state_Lc04 : levelCrossingStates;
 signal state_Sw12 , state_Sw11 : singleSwitchStates;
 signal state_ne3 , state_ne23 , state_ne25 , state_ne26 , state_ne27 : nodeStates;
 signal cmd_R1_ne26 , cmd_R2_ne26 , cmd_R3_ne23 , cmd_R4_ne23 , cmd_R5_ne25 , cmd_R6_ne25 , cmd_R6_ne23 , cmd_R7_ne3 , cmd_R8_ne23 , cmd_R9_ne23 , cmd_R9_ne25 , cmd_R10_ne23 , cmd_R10_ne27 , cmd_R10_ne3 , cmd_R11_ne26 , cmd_R11_ne3 , cmd_R12_ne3 , cmd_R12_ne26 , cmd_R13_ne3 , cmd_R13_ne27 , cmd_R13_ne23 : routeCommands;
 signal cmd_R1_Lc03 , cmd_R2_Lc03 , cmd_R2_Lc04 , cmd_R3_Lc07 , cmd_R4_Lc09 , cmd_R5_Lc05 , cmd_R6_Lc05 , cmd_R7_Lc06 , cmd_R8_Lc07 , cmd_R9_Lc09 , cmd_R10_Lc09 , cmd_R11_Lc04 , cmd_R12_Lc06 , cmd_R13_Lc06 : routeCommands;
 signal cmd_R6_Sw11 , cmd_R9_Sw11 , cmd_R10_Sw11 , cmd_R10_Sw12 , cmd_R11_Sw12 , cmd_R12_Sw12 , cmd_R13_Sw11 , cmd_R13_Sw12 : routeCommands;
begin
	levelCrossing_Lc06 : levelCrossing_0 port map(clock => clock, R7_command => cmd_R7_Lc06, R12_command => cmd_R12_Lc06, R13_command => cmd_R13_Lc06, ocupation_ne3 => ocupation(0), ocupation_ne26 => ocupation(3), ocupation_ne27 => ocupation(4), indication => levelCrossings_i(0), command  => levelCrossings_o(0), correspondence_Lc06 => state_Lc06);
	levelCrossing_Lc07 : levelCrossing_1 port map(clock => clock, R3_command => cmd_R3_Lc07, R8_command => cmd_R8_Lc07, ocupation_ne23 => ocupation(1), ocupation_ne25 => ocupation(2), ocupation_ne27 => ocupation(4), indication => levelCrossings_i(1), command  => levelCrossings_o(1), correspondence_Lc07 => state_Lc07);
	levelCrossing_Lc09 : levelCrossing_2 port map(clock => clock, R4_command => cmd_R4_Lc09, R9_command => cmd_R9_Lc09, R10_command => cmd_R10_Lc09, ocupation_ne23 => ocupation(1), ocupation_ne25 => ocupation(2), ocupation_ne27 => ocupation(4), indication => levelCrossings_i(2), command  => levelCrossings_o(2), correspondence_Lc09 => state_Lc09);
	levelCrossing_Lc05 : levelCrossing_3 port map(clock => clock, R5_command => cmd_R5_Lc05, R6_command => cmd_R6_Lc05, ocupation_ne25 => ocupation(2), ocupation_ne23 => ocupation(1), indication => levelCrossings_i(3), command  => levelCrossings_o(3), correspondence_Lc05 => state_Lc05);
	levelCrossing_Lc03 : levelCrossing_4 port map(clock => clock, R1_command => cmd_R1_Lc03, R2_command => cmd_R2_Lc03, ocupation_ne26 => ocupation(3), ocupation_ne3 => ocupation(0), indication => levelCrossings_i(4), command  => levelCrossings_o(4), correspondence_Lc03 => state_Lc03);
	levelCrossing_Lc04 : levelCrossing_5 port map(clock => clock, R2_command => cmd_R2_Lc04, R11_command => cmd_R11_Lc04, ocupation_ne26 => ocupation(3), ocupation_ne3 => ocupation(0), indication => levelCrossings_i(5), command  => levelCrossings_o(5), correspondence_Lc04 => state_Lc04);
	singleSwitch_Sw12 : singleSwitch_0 port map(clock => clock, R10_command => cmd_R10_Sw12, R11_command => cmd_R11_Sw12, R12_command => cmd_R12_Sw12, R13_command => cmd_R13_Sw12, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence_Sw12 => state_Sw12);
	singleSwitch_Sw11 : singleSwitch_1 port map(clock => clock, R6_command => cmd_R6_Sw11, R9_command => cmd_R9_Sw11, R10_command => cmd_R10_Sw11, R13_command => cmd_R13_Sw11, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence_Sw11 => state_Sw11);
	node_ne3 : node_0 port map(clock => clock, ocupation => ocupation(0), R7_command => cmd_R7_ne3, R10_command => cmd_R10_ne3, R11_command => cmd_R11_ne3, R12_command => cmd_R12_ne3, R13_command => cmd_R13_ne3, state => state_ne3);
	node_ne23 : node_1 port map(clock => clock, ocupation => ocupation(1), R3_command => cmd_R3_ne23, R4_command => cmd_R4_ne23, R6_command => cmd_R6_ne23, R8_command => cmd_R8_ne23, R9_command => cmd_R9_ne23, R10_command => cmd_R10_ne23, R13_command => cmd_R13_ne23, state => state_ne23);
	node_ne25 : node_2 port map(clock => clock, ocupation => ocupation(2), R5_command => cmd_R5_ne25, R6_command => cmd_R6_ne25, R9_command => cmd_R9_ne25, state => state_ne25);
	node_ne26 : node_3 port map(clock => clock, ocupation => ocupation(3), R1_command => cmd_R1_ne26, R2_command => cmd_R2_ne26, R11_command => cmd_R11_ne26, R12_command => cmd_R12_ne26, state => state_ne26);
	node_ne27 : node_4 port map(clock => clock, ocupation => ocupation(4), R10_command => cmd_R10_ne27, R13_command => cmd_R13_ne27, state => state_ne27);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne26_command => cmd_R1_ne26, ne26_state => state_ne26, Lc03_command => cmd_R1_Lc03, Lc03_state => state_Lc03, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne26_command => cmd_R2_ne26, ne26_state => state_ne26, Lc03_command => cmd_R2_Lc03, Lc03_state => state_Lc03, Lc04_command => cmd_R2_Lc04, Lc04_state => state_Lc04, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne23_command => cmd_R3_ne23, ne23_state => state_ne23, Lc07_command => cmd_R3_Lc07, Lc07_state => state_Lc07, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne23_command => cmd_R4_ne23, ne23_state => state_ne23, Lc09_command => cmd_R4_Lc09, Lc09_state => state_Lc09, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne25_command => cmd_R5_ne25, ne25_state => state_ne25, Lc05_command => cmd_R5_Lc05, Lc05_state => state_Lc05, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne23_command => cmd_R6_ne23, ne23_state => state_ne23, ne25_command => cmd_R6_ne25, ne25_state => state_ne25, Lc05_command => cmd_R6_Lc05, Lc05_state => state_Lc05, Sw11_command => cmd_R6_Sw11, Sw11_state => state_Sw11, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne3_command => cmd_R7_ne3, ne3_state => state_ne3, Lc06_command => cmd_R7_Lc06, Lc06_state => state_Lc06, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne23_command => cmd_R8_ne23, ne23_state => state_ne23, Lc07_command => cmd_R8_Lc07, Lc07_state => state_Lc07, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne23_command => cmd_R9_ne23, ne23_state => state_ne23, ne25_command => cmd_R9_ne25, ne25_state => state_ne25, Lc09_command => cmd_R9_Lc09, Lc09_state => state_Lc09, Sw11_command => cmd_R9_Sw11, Sw11_state => state_Sw11, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne3_command => cmd_R10_ne3, ne3_state => state_ne3, ne23_command => cmd_R10_ne23, ne23_state => state_ne23, ne27_command => cmd_R10_ne27, ne27_state => state_ne27, Lc09_command => cmd_R10_Lc09, Lc09_state => state_Lc09, Sw11_command => cmd_R10_Sw11, Sw11_state => state_Sw11, Sw12_command => cmd_R10_Sw12, Sw12_state => state_Sw12, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), ne3_command => cmd_R11_ne3, ne3_state => state_ne3, ne26_command => cmd_R11_ne26, ne26_state => state_ne26, Lc04_command => cmd_R11_Lc04, Lc04_state => state_Lc04, Sw12_command => cmd_R11_Sw12, Sw12_state => state_Sw12, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), ne3_command => cmd_R12_ne3, ne3_state => state_ne3, ne26_command => cmd_R12_ne26, ne26_state => state_ne26, Lc06_command => cmd_R12_Lc06, Lc06_state => state_Lc06, Sw12_command => cmd_R12_Sw12, Sw12_state => state_Sw12, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), ne3_command => cmd_R13_ne3, ne3_state => state_ne3, ne23_command => cmd_R13_ne23, ne23_state => state_ne23, ne27_command => cmd_R13_ne27, ne27_state => state_ne27, Lc06_command => cmd_R13_Lc06, Lc06_state => state_Lc06, Sw11_command => cmd_R13_Sw11, Sw11_state => state_Sw11, Sw12_command => cmd_R13_Sw12, Sw12_state => state_Sw12, routeState => routes_o(12));
end Behavioral;