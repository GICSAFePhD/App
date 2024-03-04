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
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw18 : out singleSwitchStates
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw14 : out singleSwitchStates
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in std_logic;
			command : out std_logic;
			correspondence_Sw19 : out singleSwitchStates
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
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates
		);
	end component node_0;
	component node_1 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R7_command : in routeCommands;
			state : out nodeStates
		);
	end component node_1;
	component node_2 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R3_command : in routeCommands;
			R8_command : in routeCommands;
			state : out nodeStates
		);
	end component node_2;
	component node_3 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			state : out nodeStates
		);
	end component node_3;
	component node_4 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			state : out nodeStates
		);
	end component node_4;
	component node_5 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates
		);
	end component node_5;
	component node_6 is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			R5_command : in routeCommands;
			R11_command : in routeCommands;
			state : out nodeStates
		);
	end component node_6;
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
			ne31_state : in nodeStates;
			ne31_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_1;
	component route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_2;
	component route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_3;
	component route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne43_state : in nodeStates;
			ne43_command : out routeCommands;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_4;
	component route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_5;
	component route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_command : out routeCommands;
			ne31_state : in nodeStates;
			ne31_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_6;
	component route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_command : out routeCommands;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_7;
	component route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_8;
	component route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_9;
	component route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			ne43_state : in nodeStates;
			ne43_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_command : out routeCommands;
			routeState : out std_logic
		);
	end component route_10;

 signal  : levelCrossingStates;
 signal state_Sw18 , state_Sw14 , state_Sw19 : singleSwitchStates;
 signal state_ne1 , state_ne31 , state_ne32 , state_ne40 , state_ne41 , state_ne42 , state_ne43 : nodeStates;
 signal cmd_R1_ne1 , cmd_R2_ne31 , cmd_R2_ne40 , cmd_R2_ne1 , cmd_R3_ne32 , cmd_R3_ne40 , cmd_R3_ne1 , cmd_R4_ne42 , cmd_R5_ne43 , cmd_R5_ne42 , cmd_R6_ne1 , cmd_R6_ne41 , cmd_R7_ne1 , cmd_R7_ne40 , cmd_R7_ne31 , cmd_R8_ne1 , cmd_R8_ne40 , cmd_R8_ne32 , cmd_R9_ne41 , cmd_R9_ne42 , cmd_R10_ne42 , cmd_R10_ne41 , cmd_R10_ne1 , cmd_R11_ne42 , cmd_R11_ne43 : routeCommands;
 signal  : routeCommands;
 signal cmd_R2_Sw14 , cmd_R2_Sw18 , cmd_R3_Sw14 , cmd_R3_Sw18 , cmd_R5_Sw19 , cmd_R6_Sw18 , cmd_R7_Sw14 , cmd_R7_Sw18 , cmd_R8_Sw14 , cmd_R8_Sw18 , cmd_R9_Sw19 , cmd_R10_Sw18 , cmd_R10_Sw19 , cmd_R11_Sw19 : routeCommands;
begin
	singleSwitch_Sw18 : singleSwitch_0 port map(clock => clock, R2_command => cmd_R2_Sw18, R3_command => cmd_R3_Sw18, R6_command => cmd_R6_Sw18, R7_command => cmd_R7_Sw18, R8_command => cmd_R8_Sw18, R10_command => cmd_R10_Sw18, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence_Sw18 => state_Sw18);
	singleSwitch_Sw14 : singleSwitch_1 port map(clock => clock, R2_command => cmd_R2_Sw14, R3_command => cmd_R3_Sw14, R7_command => cmd_R7_Sw14, R8_command => cmd_R8_Sw14, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence_Sw14 => state_Sw14);
	singleSwitch_Sw19 : singleSwitch_2 port map(clock => clock, R5_command => cmd_R5_Sw19, R9_command => cmd_R9_Sw19, R10_command => cmd_R10_Sw19, R11_command => cmd_R11_Sw19, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence_Sw19 => state_Sw19);
	node_ne1 : node_0 port map(clock => clock, ocupation => ocupation(0), R1_command => cmd_R1_ne1, R2_command => cmd_R2_ne1, R3_command => cmd_R3_ne1, R6_command => cmd_R6_ne1, R7_command => cmd_R7_ne1, R8_command => cmd_R8_ne1, R10_command => cmd_R10_ne1, state => state_ne1);
	node_ne31 : node_1 port map(clock => clock, ocupation => ocupation(1), R2_command => cmd_R2_ne31, R7_command => cmd_R7_ne31, state => state_ne31);
	node_ne32 : node_2 port map(clock => clock, ocupation => ocupation(2), R3_command => cmd_R3_ne32, R8_command => cmd_R8_ne32, state => state_ne32);
	node_ne40 : node_3 port map(clock => clock, ocupation => ocupation(3), R2_command => cmd_R2_ne40, R3_command => cmd_R3_ne40, R7_command => cmd_R7_ne40, R8_command => cmd_R8_ne40, state => state_ne40);
	node_ne41 : node_4 port map(clock => clock, ocupation => ocupation(4), R6_command => cmd_R6_ne41, R9_command => cmd_R9_ne41, R10_command => cmd_R10_ne41, state => state_ne41);
	node_ne42 : node_5 port map(clock => clock, ocupation => ocupation(5), R4_command => cmd_R4_ne42, R5_command => cmd_R5_ne42, R9_command => cmd_R9_ne42, R10_command => cmd_R10_ne42, R11_command => cmd_R11_ne42, state => state_ne42);
	node_ne43 : node_6 port map(clock => clock, ocupation => ocupation(6), R5_command => cmd_R5_ne43, R11_command => cmd_R11_ne43, state => state_ne43);
	route_R1 : route_0 port map(clock => clock, routeRequest => routes_i(0), ne1_command => cmd_R1_ne1, ne1_state => state_ne1, routeState => routes_o(0));
	route_R2 : route_1 port map(clock => clock, routeRequest => routes_i(1), ne1_command => cmd_R2_ne1, ne1_state => state_ne1, ne31_command => cmd_R2_ne31, ne31_state => state_ne31, ne40_command => cmd_R2_ne40, ne40_state => state_ne40, Sw14_command => cmd_R2_Sw14, Sw14_state => state_Sw14, Sw18_command => cmd_R2_Sw18, Sw18_state => state_Sw18, routeState => routes_o(1));
	route_R3 : route_2 port map(clock => clock, routeRequest => routes_i(2), ne1_command => cmd_R3_ne1, ne1_state => state_ne1, ne32_command => cmd_R3_ne32, ne32_state => state_ne32, ne40_command => cmd_R3_ne40, ne40_state => state_ne40, Sw14_command => cmd_R3_Sw14, Sw14_state => state_Sw14, Sw18_command => cmd_R3_Sw18, Sw18_state => state_Sw18, routeState => routes_o(2));
	route_R4 : route_3 port map(clock => clock, routeRequest => routes_i(3), ne42_command => cmd_R4_ne42, ne42_state => state_ne42, routeState => routes_o(3));
	route_R5 : route_4 port map(clock => clock, routeRequest => routes_i(4), ne42_command => cmd_R5_ne42, ne42_state => state_ne42, ne43_command => cmd_R5_ne43, ne43_state => state_ne43, Sw19_command => cmd_R5_Sw19, Sw19_state => state_Sw19, routeState => routes_o(4));
	route_R6 : route_5 port map(clock => clock, routeRequest => routes_i(5), ne1_command => cmd_R6_ne1, ne1_state => state_ne1, ne41_command => cmd_R6_ne41, ne41_state => state_ne41, Sw18_command => cmd_R6_Sw18, Sw18_state => state_Sw18, routeState => routes_o(5));
	route_R7 : route_6 port map(clock => clock, routeRequest => routes_i(6), ne1_command => cmd_R7_ne1, ne1_state => state_ne1, ne31_command => cmd_R7_ne31, ne31_state => state_ne31, ne40_command => cmd_R7_ne40, ne40_state => state_ne40, Sw14_command => cmd_R7_Sw14, Sw14_state => state_Sw14, Sw18_command => cmd_R7_Sw18, Sw18_state => state_Sw18, routeState => routes_o(6));
	route_R8 : route_7 port map(clock => clock, routeRequest => routes_i(7), ne1_command => cmd_R8_ne1, ne1_state => state_ne1, ne32_command => cmd_R8_ne32, ne32_state => state_ne32, ne40_command => cmd_R8_ne40, ne40_state => state_ne40, Sw14_command => cmd_R8_Sw14, Sw14_state => state_Sw14, Sw18_command => cmd_R8_Sw18, Sw18_state => state_Sw18, routeState => routes_o(7));
	route_R9 : route_8 port map(clock => clock, routeRequest => routes_i(8), ne41_command => cmd_R9_ne41, ne41_state => state_ne41, ne42_command => cmd_R9_ne42, ne42_state => state_ne42, Sw19_command => cmd_R9_Sw19, Sw19_state => state_Sw19, routeState => routes_o(8));
	route_R10 : route_9 port map(clock => clock, routeRequest => routes_i(9), ne1_command => cmd_R10_ne1, ne1_state => state_ne1, ne41_command => cmd_R10_ne41, ne41_state => state_ne41, ne42_command => cmd_R10_ne42, ne42_state => state_ne42, Sw18_command => cmd_R10_Sw18, Sw18_state => state_Sw18, Sw19_command => cmd_R10_Sw19, Sw19_state => state_Sw19, routeState => routes_o(9));
	route_R11 : route_10 port map(clock => clock, routeRequest => routes_i(10), ne42_command => cmd_R11_ne42, ne42_state => state_ne42, ne43_command => cmd_R11_ne43, ne43_state => state_ne43, Sw19_command => cmd_R11_Sw19, Sw19_state => state_Sw19, routeState => routes_o(10));
end Behavioral;