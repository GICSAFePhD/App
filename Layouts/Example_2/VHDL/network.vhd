--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 44;
			N_SIGNALS : natural := 12;
			N_ROUTES : natural := 10;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 2;
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
			correspondence_Lc01 : out levelCrossingStates
		);
	end component levelCrossing_0;
	component singleSwitch_0 is
		port(
			clock : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw01 : out singleSwitchStates
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw02 : out singleSwitchStates
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw03 : out singleSwitchStates
		);
	end component singleSwitch_2;
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
			R4_command : in routeCommands;
			state : out nodeStates
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R5_command : in routeCommands;
			state : out nodeStates
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			state : out nodeStates
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			state : out nodeStates
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			state : out nodeStates
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates
		);
	end component node_6;
	component route_0 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne19_state : in nodeStates;
			ne19_command : out routeCommands;
			ne20_state : in nodeStates;
			ne20_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne15_state : in nodeStates;
			ne15_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			ne15_state : in nodeStates;
			ne15_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne18_state : in nodeStates;
			ne18_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			ne18_state : in nodeStates;
			ne18_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			ne20_state : in nodeStates;
			ne20_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne20_state : in nodeStates;
			ne20_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne20_state : in nodeStates;
			ne20_command : out routeCommands;
			ne19_state : in nodeStates;
			ne19_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_9;

 signal state_Lc01 : levelCrossingStates;
 signal state_Sw01 , state_Sw02 , state_Sw03 : singleSwitchStates;
 signal state_ne14 , state_ne15 , state_ne16 , state_ne17 , state_ne18 , state_ne19 , state_ne20 : nodeStates;
 signal cmd_R1_ne19 , cmd_R1_ne20 , cmd_R2_ne14 , cmd_R2_ne16 , cmd_R3_ne15 , cmd_R3_ne16 , cmd_R4_ne16 , cmd_R4_ne14 , cmd_R5_ne16 , cmd_R5_ne15 , cmd_R6_ne18 , cmd_R6_ne16 , cmd_R7_ne16 , cmd_R7_ne18 , cmd_R8_ne16 , cmd_R8_ne17 , cmd_R8_ne20 , cmd_R9_ne20 , cmd_R9_ne17 , cmd_R9_ne16 , cmd_R10_ne20 , cmd_R10_ne19 : routeCommands;
 signal cmd_R4_Lc01 , cmd_R5_Lc01 , cmd_R7_Lc01 , cmd_R8_Lc01 : routeCommands;
 signal cmd_R1_Sw03 , cmd_R2_Sw01 , cmd_R3_Sw01 , cmd_R4_Sw01 , cmd_R5_Sw01 , cmd_R6_Sw02 , cmd_R7_Sw02 , cmd_R8_Sw02 , cmd_R8_Sw03 , cmd_R9_Sw02 , cmd_R9_Sw03 , cmd_R10_Sw03 : routeCommands;
begin
	levelCrossing_Lc01 : levelCrossing_0 port map(clock => clock, R4_command => cmd_R4_Lc01, R5_command => cmd_R5_Lc01, R7_command => cmd_R7_Lc01, R8_command => cmd_R8_Lc01, ocupation_ne16 => ocupation(2), ocupation_ne14 => ocupation(0), ocupation_ne15 => ocupation(1), ocupation_ne18 => ocupation(4), ocupation_ne17 => ocupation(3), indication => levelCrossings_i, command  => levelCrossings_o, correspondence_Lc01 => state_Lc01);
	singleSwitch_Sw01 : singleSwitch_0 port map(clock => clock, R2_command => cmd_R2_Sw01, R3_command => cmd_R3_Sw01, R4_command => cmd_R4_Sw01, R5_command => cmd_R5_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence_Sw01 => state_Sw01);
	singleSwitch_Sw02 : singleSwitch_1 port map(clock => clock, R6_command => cmd_R6_Sw02, R7_command => cmd_R7_Sw02, R8_command => cmd_R8_Sw02, R9_command => cmd_R9_Sw02, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence_Sw02 => state_Sw02);
	singleSwitch_Sw03 : singleSwitch_2 port map(clock => clock, R1_command => cmd_R1_Sw03, R8_command => cmd_R8_Sw03, R9_command => cmd_R9_Sw03, R10_command => cmd_R10_Sw03, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence_Sw03 => state_Sw03);
	node_ne14 : node_0 port map(clock => clock, ocupation => ocupation(0), R2_command => cmd_R2_ne14, R4_command => cmd_R4_ne14, state => state_ne14);
	node_ne15 : node_1 port map(clock => clock, ocupation => ocupation(1), R3_command => cmd_R3_ne15, R5_command => cmd_R5_ne15, state => state_ne15);
	node_ne16 : node_2 port map(clock => clock, ocupation => ocupation(2), R2_command => cmd_R2_ne16, R3_command => cmd_R3_ne16, R4_command => cmd_R4_ne16, R5_command => cmd_R5_ne16, R6_command => cmd_R6_ne16, R7_command => cmd_R7_ne16, R8_command => cmd_R8_ne16, R9_command => cmd_R9_ne16, state => state_ne16);
	node_ne17 : node_3 port map(clock => clock, ocupation => ocupation(3), R8_command => cmd_R8_ne17, R9_command => cmd_R9_ne17, state => state_ne17);
	node_ne18 : node_4 port map(clock => clock, ocupation => ocupation(4), R6_command => cmd_R6_ne18, R7_command => cmd_R7_ne18, state => state_ne18);
	node_ne19 : node_5 port map(clock => clock, ocupation => ocupation(5), R1_command => cmd_R1_ne19, R10_command => cmd_R10_ne19, state => state_ne19);
	node_ne20 : node_6 port map(clock => clock, ocupation => ocupation(6), R1_command => cmd_R1_ne20, R8_command => cmd_R8_ne20, R9_command => cmd_R9_ne20, R10_command => cmd_R10_ne20, state => state_ne20);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne19_command => cmd_R1_ne19, ne19_state => state_ne19, ne20_command => cmd_R1_ne20, ne20_state => state_ne20, Sw03_command => cmd_R1_Sw03, Sw03_state => state_Sw03, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne14_command => cmd_R2_ne14, ne14_state => state_ne14, ne16_command => cmd_R2_ne16, ne16_state => state_ne16, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne15_command => cmd_R3_ne15, ne15_state => state_ne15, ne16_command => cmd_R3_ne16, ne16_state => state_ne16, Sw01_command => cmd_R3_Sw01, Sw01_state => state_Sw01, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne14_command => cmd_R4_ne14, ne14_state => state_ne14, ne16_command => cmd_R4_ne16, ne16_state => state_ne16, Lc01_command => cmd_R4_Lc01, Lc01_state => state_Lc01, Sw01_command => cmd_R4_Sw01, Sw01_state => state_Sw01, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne15_command => cmd_R5_ne15, ne15_state => state_ne15, ne16_command => cmd_R5_ne16, ne16_state => state_ne16, Lc01_command => cmd_R5_Lc01, Lc01_state => state_Lc01, Sw01_command => cmd_R5_Sw01, Sw01_state => state_Sw01, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne16_command => cmd_R6_ne16, ne16_state => state_ne16, ne18_command => cmd_R6_ne18, ne18_state => state_ne18, Sw02_command => cmd_R6_Sw02, Sw02_state => state_Sw02, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne16_command => cmd_R7_ne16, ne16_state => state_ne16, ne18_command => cmd_R7_ne18, ne18_state => state_ne18, Lc01_command => cmd_R7_Lc01, Lc01_state => state_Lc01, Sw02_command => cmd_R7_Sw02, Sw02_state => state_Sw02, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne16_command => cmd_R8_ne16, ne16_state => state_ne16, ne17_command => cmd_R8_ne17, ne17_state => state_ne17, ne20_command => cmd_R8_ne20, ne20_state => state_ne20, Lc01_command => cmd_R8_Lc01, Lc01_state => state_Lc01, Sw02_command => cmd_R8_Sw02, Sw02_state => state_Sw02, Sw03_command => cmd_R8_Sw03, Sw03_state => state_Sw03, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne16_command => cmd_R9_ne16, ne16_state => state_ne16, ne17_command => cmd_R9_ne17, ne17_state => state_ne17, ne20_command => cmd_R9_ne20, ne20_state => state_ne20, Sw02_command => cmd_R9_Sw02, Sw02_state => state_Sw02, Sw03_command => cmd_R9_Sw03, Sw03_state => state_Sw03, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne19_command => cmd_R10_ne19, ne19_state => state_ne19, ne20_command => cmd_R10_ne20, ne20_state => state_ne20, Sw03_command => cmd_R10_Sw03, Sw03_state => state_Sw03, routeState => routes_o(9));
end Behavioral;