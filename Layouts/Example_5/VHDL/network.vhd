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
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw01 : out singleSwitchStates
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw02 : out singleSwitchStates
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw03 : out singleSwitchStates
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw04 : out singleSwitchStates
		);
	end component singleSwitch_3;
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
			R2_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R1_command : in routeCommands;
			R3_command : in routeCommands;
			R9_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
			R10_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			state : out nodeStates
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			state : out nodeStates
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R7_command : in routeCommands;
			R13_command : in routeCommands;
			R15_command : in routeCommands;
			state : out nodeStates
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R8_command : in routeCommands;
			R14_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates
		);
	end component node_6;
	component node_7 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			state : out nodeStates
		);
	end component node_7;
	component route_0 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne01_state : in nodeStates;
			ne01_command : out routeCommands;
			ne02_state : in nodeStates;
			ne02_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_0;
	component route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne01_state : in nodeStates;
			ne01_command : out routeCommands;
			ne03_state : in nodeStates;
			ne03_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne04_state : in nodeStates;
			ne04_command : out routeCommands;
			ne02_state : in nodeStates;
			ne02_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne04_state : in nodeStates;
			ne04_command : out routeCommands;
			ne03_state : in nodeStates;
			ne03_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne05_state : in nodeStates;
			ne05_command : out routeCommands;
			ne06_state : in nodeStates;
			ne06_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne05_state : in nodeStates;
			ne05_command : out routeCommands;
			ne07_state : in nodeStates;
			ne07_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne08_state : in nodeStates;
			ne08_command : out routeCommands;
			ne06_state : in nodeStates;
			ne06_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne08_state : in nodeStates;
			ne08_command : out routeCommands;
			ne07_state : in nodeStates;
			ne07_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne02_state : in nodeStates;
			ne02_command : out routeCommands;
			ne01_state : in nodeStates;
			ne01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne03_state : in nodeStates;
			ne03_command : out routeCommands;
			ne01_state : in nodeStates;
			ne01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne02_state : in nodeStates;
			ne02_command : out routeCommands;
			ne04_state : in nodeStates;
			ne04_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_10;
	component route_11 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne03_state : in nodeStates;
			ne03_command : out routeCommands;
			ne04_state : in nodeStates;
			ne04_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_11;
	component route_12 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne06_state : in nodeStates;
			ne06_command : out routeCommands;
			ne05_state : in nodeStates;
			ne05_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_12;
	component route_13 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne07_state : in nodeStates;
			ne07_command : out routeCommands;
			ne05_state : in nodeStates;
			ne05_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_13;
	component route_14 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne06_state : in nodeStates;
			ne06_command : out routeCommands;
			ne08_state : in nodeStates;
			ne08_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_14;
	component route_15 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne07_state : in nodeStates;
			ne07_command : out routeCommands;
			ne08_state : in nodeStates;
			ne08_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_15;

 signal  : levelCrossingStates;
 signal state_Sw01 , state_Sw02 , state_Sw03 , state_Sw04 : singleSwitchStates;
 signal state_ne01 , state_ne02 , state_ne03 , state_ne04 , state_ne05 , state_ne06 , state_ne07 , state_ne08 : nodeStates;
 signal cmd_R1_ne01 , cmd_R1_ne02 , cmd_R2_ne01 , cmd_R2_ne03 , cmd_R3_ne04 , cmd_R3_ne02 , cmd_R4_ne04 , cmd_R4_ne03 , cmd_R5_ne05 , cmd_R5_ne06 , cmd_R6_ne05 , cmd_R6_ne07 , cmd_R7_ne08 , cmd_R7_ne06 , cmd_R8_ne08 , cmd_R8_ne07 , cmd_R9_ne02 , cmd_R9_ne01 , cmd_R10_ne03 , cmd_R10_ne01 , cmd_R11_ne02 , cmd_R11_ne04 , cmd_R12_ne03 , cmd_R12_ne04 , cmd_R13_ne06 , cmd_R13_ne05 , cmd_R14_ne07 , cmd_R14_ne05 , cmd_R15_ne06 , cmd_R15_ne08 , cmd_R16_ne07 , cmd_R16_ne08 : routeCommands;
 signal  : routeCommands;
 signal cmd_R1_Sw01 , cmd_R2_Sw01 , cmd_R3_Sw02 , cmd_R4_Sw02 , cmd_R5_Sw03 , cmd_R6_Sw03 , cmd_R7_Sw04 , cmd_R8_Sw04 , cmd_R9_Sw01 , cmd_R10_Sw01 , cmd_R11_Sw02 , cmd_R12_Sw02 , cmd_R13_Sw03 , cmd_R14_Sw03 , cmd_R15_Sw04 , cmd_R16_Sw04 : routeCommands;
begin
	singleSwitch_Sw01 : singleSwitch_0 port map(clock => clock, R1_command => cmd_R1_Sw01, R2_command => cmd_R2_Sw01, R9_command => cmd_R9_Sw01, R10_command => cmd_R10_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence_Sw01 => state_Sw01);
	singleSwitch_Sw02 : singleSwitch_1 port map(clock => clock, R3_command => cmd_R3_Sw02, R4_command => cmd_R4_Sw02, R11_command => cmd_R11_Sw02, R12_command => cmd_R12_Sw02, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence_Sw02 => state_Sw02);
	singleSwitch_Sw03 : singleSwitch_2 port map(clock => clock, R5_command => cmd_R5_Sw03, R6_command => cmd_R6_Sw03, R13_command => cmd_R13_Sw03, R14_command => cmd_R14_Sw03, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence_Sw03 => state_Sw03);
	singleSwitch_Sw04 : singleSwitch_3 port map(clock => clock, R7_command => cmd_R7_Sw04, R8_command => cmd_R8_Sw04, R15_command => cmd_R15_Sw04, R16_command => cmd_R16_Sw04, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence_Sw04 => state_Sw04);
	node_ne01 : node_0 port map(clock => clock, ocupation => ocupation(0), R1_command => cmd_R1_ne01, R2_command => cmd_R2_ne01, R9_command => cmd_R9_ne01, R10_command => cmd_R10_ne01, state => state_ne01);
	node_ne02 : node_1 port map(clock => clock, ocupation => ocupation(1), R1_command => cmd_R1_ne02, R3_command => cmd_R3_ne02, R9_command => cmd_R9_ne02, R11_command => cmd_R11_ne02, state => state_ne02);
	node_ne03 : node_2 port map(clock => clock, ocupation => ocupation(2), R2_command => cmd_R2_ne03, R4_command => cmd_R4_ne03, R10_command => cmd_R10_ne03, R12_command => cmd_R12_ne03, state => state_ne03);
	node_ne04 : node_3 port map(clock => clock, ocupation => ocupation(3), R3_command => cmd_R3_ne04, R4_command => cmd_R4_ne04, R11_command => cmd_R11_ne04, R12_command => cmd_R12_ne04, state => state_ne04);
	node_ne05 : node_4 port map(clock => clock, ocupation => ocupation(4), R5_command => cmd_R5_ne05, R6_command => cmd_R6_ne05, R13_command => cmd_R13_ne05, R14_command => cmd_R14_ne05, state => state_ne05);
	node_ne06 : node_5 port map(clock => clock, ocupation => ocupation(5), R5_command => cmd_R5_ne06, R7_command => cmd_R7_ne06, R13_command => cmd_R13_ne06, R15_command => cmd_R15_ne06, state => state_ne06);
	node_ne07 : node_6 port map(clock => clock, ocupation => ocupation(6), R6_command => cmd_R6_ne07, R8_command => cmd_R8_ne07, R14_command => cmd_R14_ne07, R16_command => cmd_R16_ne07, state => state_ne07);
	node_ne08 : node_7 port map(clock => clock, ocupation => ocupation(7), R7_command => cmd_R7_ne08, R8_command => cmd_R8_ne08, R15_command => cmd_R15_ne08, R16_command => cmd_R16_ne08, state => state_ne08);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne01_command => cmd_R1_ne01, ne01_state => state_ne01, ne02_command => cmd_R1_ne02, ne02_state => state_ne02, Sw01_command => cmd_R1_Sw01, Sw01_state => state_Sw01, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne01_command => cmd_R2_ne01, ne01_state => state_ne01, ne03_command => cmd_R2_ne03, ne03_state => state_ne03, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne02_command => cmd_R3_ne02, ne02_state => state_ne02, ne04_command => cmd_R3_ne04, ne04_state => state_ne04, Sw02_command => cmd_R3_Sw02, Sw02_state => state_Sw02, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne03_command => cmd_R4_ne03, ne03_state => state_ne03, ne04_command => cmd_R4_ne04, ne04_state => state_ne04, Sw02_command => cmd_R4_Sw02, Sw02_state => state_Sw02, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne05_command => cmd_R5_ne05, ne05_state => state_ne05, ne06_command => cmd_R5_ne06, ne06_state => state_ne06, Sw03_command => cmd_R5_Sw03, Sw03_state => state_Sw03, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne05_command => cmd_R6_ne05, ne05_state => state_ne05, ne07_command => cmd_R6_ne07, ne07_state => state_ne07, Sw03_command => cmd_R6_Sw03, Sw03_state => state_Sw03, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne06_command => cmd_R7_ne06, ne06_state => state_ne06, ne08_command => cmd_R7_ne08, ne08_state => state_ne08, Sw04_command => cmd_R7_Sw04, Sw04_state => state_Sw04, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne07_command => cmd_R8_ne07, ne07_state => state_ne07, ne08_command => cmd_R8_ne08, ne08_state => state_ne08, Sw04_command => cmd_R8_Sw04, Sw04_state => state_Sw04, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne01_command => cmd_R9_ne01, ne01_state => state_ne01, ne02_command => cmd_R9_ne02, ne02_state => state_ne02, Sw01_command => cmd_R9_Sw01, Sw01_state => state_Sw01, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne01_command => cmd_R10_ne01, ne01_state => state_ne01, ne03_command => cmd_R10_ne03, ne03_state => state_ne03, Sw01_command => cmd_R10_Sw01, Sw01_state => state_Sw01, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), ne02_command => cmd_R11_ne02, ne02_state => state_ne02, ne04_command => cmd_R11_ne04, ne04_state => state_ne04, Sw02_command => cmd_R11_Sw02, Sw02_state => state_Sw02, routeState => routes_o(10));
	route_R12 : route_11 port map(clock => clock, routeRequest => routes_i(11), ne03_command => cmd_R12_ne03, ne03_state => state_ne03, ne04_command => cmd_R12_ne04, ne04_state => state_ne04, Sw02_command => cmd_R12_Sw02, Sw02_state => state_Sw02, routeState => routes_o(11));
	route_R13 : route_12 port map(clock => clock, routeRequest => routes_i(12), ne05_command => cmd_R13_ne05, ne05_state => state_ne05, ne06_command => cmd_R13_ne06, ne06_state => state_ne06, Sw03_command => cmd_R13_Sw03, Sw03_state => state_Sw03, routeState => routes_o(12));
	route_R14 : route_13 port map(clock => clock, routeRequest => routes_i(13), ne05_command => cmd_R14_ne05, ne05_state => state_ne05, ne07_command => cmd_R14_ne07, ne07_state => state_ne07, Sw03_command => cmd_R14_Sw03, Sw03_state => state_Sw03, routeState => routes_o(13));
	route_R15 : route_14 port map(clock => clock, routeRequest => routes_i(14), ne06_command => cmd_R15_ne06, ne06_state => state_ne06, ne08_command => cmd_R15_ne08, ne08_state => state_ne08, Sw04_command => cmd_R15_Sw04, Sw04_state => state_Sw04, routeState => routes_o(14));
	route_R16 : route_15 port map(clock => clock, routeRequest => routes_i(15), ne07_command => cmd_R16_ne07, ne07_state => state_ne07, ne08_command => cmd_R16_ne08, ne08_state => state_ne08, Sw04_command => cmd_R16_Sw04, Sw04_state => state_Sw04, routeState => routes_o(15));
end Behavioral;