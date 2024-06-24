--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N_TRACKCIRCUITS : natural := 11;
			N_ROUTES : natural := 22;
			N_SIGNALS : natural := 24;
			N_SINGLESWITCHES : natural := 5;
			N : natural := 62
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			tracks_i: in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_o: out hex_array(N_TRACKCIRCUITS-1 downto 0);
			signals_i : in hex_array(N_SIGNALS-1 downto 0);
			signals_o : out hex_array(N_SIGNALS-1 downto 0);
			routes_i : in hex_array(N_ROUTES-1 downto 0);
			routes_o : out hex_array(N_ROUTES-1 downto 0);
			singleSwitches_i : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out hex_array(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity network;
architecture Behavioral of network is
	component singleSwitch_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R2_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R13_command : in routeCommands := RELEASE;
			R17_command : in routeCommands := RELEASE;
			R14_command : in routeCommands := RELEASE;
			R7_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R2_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R13_command : in routeCommands := RELEASE;
			R17_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R7_command : in routeCommands := RELEASE;
			R14_command : in routeCommands := RELEASE;
			R15_command : in routeCommands := RELEASE;
			R16_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R3_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
			R18_command : in routeCommands := RELEASE;
			R19_command : in routeCommands := RELEASE;
			R15_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_3;
	component singleSwitch_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R5_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			R21_command : in routeCommands := RELEASE;
			R22_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R4_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_4;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R10_command : in routeCommands;
			R17_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_J18 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_S22 : out hex_char;
			--Ocupation level 1
			track_ne3 : in hex_char;
			track_ne2 : in hex_char;
			track_ne7 : in hex_char;
			track_ne6 : in hex_char;
			correspondence_S27 : in hex_char;
			correspondence_J19 : in hex_char;
			correspondence_T03 : in hex_char;
			Sw01_state : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne4 : in hex_char;
			track_ne5 : in hex_char;
			track_ne41 : in hex_char;
			correspondence_S33 : in hex_char;
			correspondence_T01 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw02_state : in hex_char;
			Sw08_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			R7_command : in routeCommands;
			R14_command : in routeCommands;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_C21 : out hex_char;
			--Ocupation level 1
			track_ne1 : in hex_char;
			correspondence_J18 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			R11_command : in routeCommands;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_S27 : out hex_char;
			--Ocupation level 1
			track_ne5 : in hex_char;
			track_ne4 : in hex_char;
			correspondence_S33 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw02_state : in hex_char;
			--Ocupation level 2
			track_ne10 : in hex_char;
			track_ne11 : in hex_char;
			correspondence_T05 : in hex_char;
			correspondence_J13 : in hex_char;
			Sw05_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R16_command : in routeCommands;
			--Ocupation level 0
			track_ne4 : in hex_char;
			correspondence_T01 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne4 : in hex_char;
			correspondence_T02 : out hex_char;
			correspondence_B26 : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne4 : in hex_char;
			correspondence_B26 : out hex_char;
			--Ocupation level 1
			track_ne3 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw02_state : in hex_char;
			--Ocupation level 2
			track_ne1 : in hex_char;
			correspondence_J18 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne5 : in hex_char;
			correspondence_J16 : out hex_char;
			--Ocupation level 1
			track_ne3 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw02_state : in hex_char;
			--Ocupation level 2
			track_ne1 : in hex_char;
			correspondence_J18 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R15_command : in routeCommands;
			--Ocupation level 0
			track_ne5 : in hex_char;
			correspondence_S33 : out hex_char;
			--Ocupation level 1
			track_ne10 : in hex_char;
			track_ne11 : in hex_char;
			correspondence_T05 : in hex_char;
			correspondence_J13 : in hex_char;
			Sw05_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R13_command : in routeCommands;
			--Ocupation level 0
			track_ne6 : in hex_char;
			correspondence_T03 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne6 : in hex_char;
			correspondence_T04 : out hex_char;
			--Ocupation level 1
			track_ne2 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_J18 : in hex_char;
			Sw01_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			--Ocupation level 0
			track_ne7 : in hex_char;
			correspondence_J19 : out hex_char;
			--Ocupation level 1
			track_ne41 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw08_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R21_command : in routeCommands;
			--Ocupation level 0
			track_ne7 : in hex_char;
			correspondence_J20 : out hex_char;
			correspondence_C29 : in hex_char;
			--Ocupation level 2
			track_ne2 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_J18 : in hex_char;
			Sw01_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R17_command : in routeCommands;
			R9_command : in routeCommands;
			--Ocupation level 0
			track_ne7 : in hex_char;
			correspondence_C29 : out hex_char;
			--Ocupation level 1
			track_ne2 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_J18 : in hex_char;
			Sw01_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			--Ocupation level 0
			track_ne10 : in hex_char;
			correspondence_T05 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne10 : in hex_char;
			correspondence_T06 : out hex_char;
			--Ocupation level 1
			track_ne5 : in hex_char;
			correspondence_J16 : in hex_char;
			Sw05_state : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_15;
	component railwaySignal_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R19_command : in routeCommands;
			--Ocupation level 0
			track_ne11 : in hex_char;
			correspondence_J13 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_16;
	component railwaySignal_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne11 : in hex_char;
			correspondence_J14 : out hex_char;
			--Ocupation level 1
			track_ne5 : in hex_char;
			correspondence_J16 : in hex_char;
			Sw05_state : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_17;
	component railwaySignal_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			--Ocupation level 0
			track_ne41 : in hex_char;
			correspondence_T07 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_18;
	component railwaySignal_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne41 : in hex_char;
			correspondence_T08 : out hex_char;
			correspondence_S37 : in hex_char;
			--Ocupation level 2
			track_ne7 : in hex_char;
			track_ne42 : in hex_char;
			correspondence_J20 : in hex_char;
			correspondence_B36 : in hex_char;
			Sw08_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_19;
	component railwaySignal_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne41 : in hex_char;
			correspondence_S37 : out hex_char;
			--Ocupation level 1
			track_ne7 : in hex_char;
			track_ne42 : in hex_char;
			correspondence_J20 : in hex_char;
			correspondence_B36 : in hex_char;
			Sw08_state : in hex_char;
			correspondence_C29 : in hex_char;
			correspondence_T09 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_20;
	component railwaySignal_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			--Ocupation level 0
			track_ne42 : in hex_char;
			correspondence_T09 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_21;
	component railwaySignal_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne42 : in hex_char;
			correspondence_T10 : out hex_char;
			--Ocupation level 1
			track_ne41 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw08_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_22;
	component railwaySignal_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			R22_command : in routeCommands;
			--Ocupation level 0
			track_ne42 : in hex_char;
			correspondence_B36 : out hex_char;
			correspondence_T09 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_23;
	component node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_0;
	component node_1 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_1;
	component node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_2;
	component node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R14_command : in routeCommands;
			R16_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_3;
	component node_4 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_4;
	component node_5 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R13_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_5;
	component node_6 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R12_command : in routeCommands;
			R17_command : in routeCommands;
			R21_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_6;
	component node_7 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R18_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_7;
	component node_8 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R19_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_8;
	component node_9 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R8_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_9;
	component node_10 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R20_command : in routeCommands;
			R22_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_10;
--XXX  R1 ['Sw02'] 
--YYY  R1 [] 
	component route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne4 : in hex_char;
			ne4_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			B26_state : in hex_char;
			B26_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_0;
--XXX  R2 ['Sw01', 'Sw03'] 
--YYY  R2 [] 
	component route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne6 : in hex_char;
			ne6_command : out routeCommands := RELEASE;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			J18_state : in hex_char;
			J18_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_1;
--XXX  R3 ['Sw02', 'Sw05'] 
--YYY  R3 [] 
	component route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne10 : in hex_char;
			ne10_command : out routeCommands := RELEASE;
			track_ne5 : in hex_char;
			ne5_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			J16_state : in hex_char;
			J16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_2;
--XXX  R4 ['Sw08'] 
--YYY  R4 [] 
	component route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			T08_state : in hex_char;
			T08_command : out routeCommands := RELEASE;
			S37_state : in hex_char;
			S37_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_3;
--XXX  R5 ['Sw08'] 
--YYY  R5 [] 
	component route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			T10_state : in hex_char;
			T10_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_4;
--XXX  R6 ['Sw02', 'Sw05'] 
--YYY  R6 [] 
	component route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne11 : in hex_char;
			ne11_command : out routeCommands := RELEASE;
			track_ne5 : in hex_char;
			ne5_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			J14_state : in hex_char;
			J14_command : out routeCommands := RELEASE;
			J16_state : in hex_char;
			J16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_5;
--XXX  R7 ['Sw01', 'Sw02'] 
--YYY  R7 [] 
	component route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne5 : in hex_char;
			ne5_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			J16_state : in hex_char;
			J16_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_6;
--XXX  R8 ['Sw08'] 
--YYY  R8 [] 
	component route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			J19_state : in hex_char;
			J19_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_7;
--XXX  R9 ['Sw01', 'Sw03'] 
--YYY  R9 [] 
	component route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			J20_state : in hex_char;
			J20_command : out routeCommands := RELEASE;
			C29_state : in hex_char;
			C29_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_8;
--XXX  R10 ['Sw01'] 
--YYY  R10 [] 
	component route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			J18_state : in hex_char;
			J18_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_9;
--XXX  R11 ['Sw01', 'Sw02'] 
--YYY  R11 [] 
	component route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			S27_state : in hex_char;
			S27_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_10;
--XXX  R12 ['Sw01', 'Sw03', 'Sw08'] 
--YYY  R12 [] 
	component route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			J19_state : in hex_char;
			J19_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_11;
--XXX  R13 ['Sw01', 'Sw03'] 
--YYY  R13 [] 
	component route_12 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne6 : in hex_char;
			ne6_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_12;
--XXX  R14 ['Sw01', 'Sw02'] 
--YYY  R14 [] 
	component route_13 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne4 : in hex_char;
			ne4_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			B26_state : in hex_char;
			B26_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_13;
--XXX  R15 ['Sw02', 'Sw05'] 
--YYY  R15 [] 
	component route_14 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne5 : in hex_char;
			ne5_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S27_state : in hex_char;
			S27_command : out routeCommands := RELEASE;
			S33_state : in hex_char;
			S33_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_14;
--XXX  R16 ['Sw02'] 
--YYY  R16 [] 
	component route_15 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne4 : in hex_char;
			ne4_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			S27_state : in hex_char;
			S27_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_15;
--XXX  R17 ['Sw01', 'Sw03'] 
--YYY  R17 [] 
	component route_16 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			C29_state : in hex_char;
			C29_command : out routeCommands := RELEASE;
			J18_state : in hex_char;
			J18_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_16;
--XXX  R18 ['Sw05'] 
--YYY  R18 [] 
	component route_17 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne5 : in hex_char;
			ne5_command : out routeCommands := RELEASE;
			track_ne10 : in hex_char;
			ne10_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S33_state : in hex_char;
			S33_command : out routeCommands := RELEASE;
			T05_state : in hex_char;
			T05_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_17;
--XXX  R19 ['Sw05'] 
--YYY  R19 [] 
	component route_18 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne5 : in hex_char;
			ne5_command : out routeCommands := RELEASE;
			track_ne11 : in hex_char;
			ne11_command : out routeCommands := RELEASE;
			Sw05_state : in hex_char;
			Sw05_command : out routeCommands := RELEASE;
			S33_state : in hex_char;
			S33_command : out routeCommands := RELEASE;
			J13_state : in hex_char;
			J13_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_18;
--XXX  R20 [] 
--YYY  R20 [] 
	component route_19 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			B36_state : in hex_char;
			B36_command : out routeCommands := RELEASE;
			T09_state : in hex_char;
			T09_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_19;
--XXX  R21 ['Sw08'] 
--YYY  R21 [] 
	component route_20 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			track_ne7 : in hex_char;
			ne7_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			S37_state : in hex_char;
			S37_command : out routeCommands := RELEASE;
			J20_state : in hex_char;
			J20_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_20;
--XXX  R22 ['Sw08'] 
--YYY  R22 [] 
	component route_21 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			Sw08_state : in hex_char;
			Sw08_command : out routeCommands := RELEASE;
			S37_state : in hex_char;
			S37_command : out routeCommands := RELEASE;
			B36_state : in hex_char;
			B36_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_21;
	signal state_Sw01 , state_Sw03 , state_Sw02 , state_Sw05 , state_Sw08 : hex_char;
	signal state_J18 , state_S22 , state_C21 , state_S27 , state_T01 , state_T02 , state_B26 , state_J16 , state_S33 , state_T03 , state_T04 , state_J19 , state_J20 , state_C29 , state_T05 , state_T06 , state_J13 , state_J14 , state_T07 , state_T08 , state_S37 , state_T09 , state_T10 , state_B36 : hex_char;
	signal cmd_R1_ne4 , cmd_R2_ne6 , cmd_R2_ne2 , cmd_R2_ne1 , cmd_R3_ne10 , cmd_R3_ne5 , cmd_R4_ne41 , cmd_R5_ne42 , cmd_R5_ne41 , cmd_R6_ne11 , cmd_R6_ne5 , cmd_R7_ne5 , cmd_R7_ne3 , cmd_R8_ne7 , cmd_R8_ne41 , cmd_R9_ne7 , cmd_R10_ne3 , cmd_R10_ne1 , cmd_R11_ne1 , cmd_R11_ne3 , cmd_R12_ne1 , cmd_R12_ne2 , cmd_R12_ne7 , cmd_R13_ne1 , cmd_R13_ne2 , cmd_R13_ne6 , cmd_R14_ne4 , cmd_R14_ne3 , cmd_R15_ne3 , cmd_R15_ne5 , cmd_R16_ne3 , cmd_R16_ne4 , cmd_R17_ne7 , cmd_R17_ne2 , cmd_R17_ne1 , cmd_R18_ne5 , cmd_R18_ne10 , cmd_R19_ne5 , cmd_R19_ne11 , cmd_R20_ne42 , cmd_R21_ne41 , cmd_R21_ne7 , cmd_R22_ne41 , cmd_R22_ne42 : routeCommands := RELEASE;
	signal state_ne1 , state_ne2 , state_ne3 , state_ne4 , state_ne5 , state_ne6 , state_ne7 , state_ne10 , state_ne11 , state_ne41 , state_ne42 : hex_char;
	signal cmd_R2_Sw01 , cmd_R10_Sw01 , cmd_R11_Sw01 , cmd_R12_Sw01 , cmd_R13_Sw01 , cmd_R17_Sw01 , cmd_R14_Sw01 , cmd_R7_Sw01 , cmd_R9_Sw01 , cmd_R2_Sw03 , cmd_R12_Sw03 , cmd_R13_Sw03 , cmd_R17_Sw03 , cmd_R9_Sw03 , cmd_R7_Sw02 , cmd_R14_Sw02 , cmd_R15_Sw02 , cmd_R16_Sw02 , cmd_R11_Sw02 , cmd_R1_Sw02 , cmd_R3_Sw02 , cmd_R6_Sw02 , cmd_R3_Sw05 , cmd_R6_Sw05 , cmd_R18_Sw05 , cmd_R19_Sw05 , cmd_R15_Sw05 , cmd_R5_Sw08 , cmd_R8_Sw08 , cmd_R21_Sw08 , cmd_R22_Sw08 , cmd_R12_Sw08 , cmd_R4_Sw08 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_T06 , cmd_R4_T08 , cmd_R5_T10 , cmd_R6_J14 , cmd_R7_J16 , cmd_R8_J19 , cmd_R9_J20 , cmd_R10_C21 , cmd_R11_S22 , cmd_R12_S22 , cmd_R13_S22 , cmd_R14_B26 , cmd_R15_S27 , cmd_R16_S27 , cmd_R17_C29 , cmd_R18_S33 , cmd_R19_S33 , cmd_R20_B36 , cmd_R21_S37 , cmd_R22_S37 : routeCommands := RELEASE;
	signal cmd_R1_B26 , cmd_R2_J18 , cmd_R3_J16 , cmd_R4_S37 , cmd_R5_T07 , cmd_R6_J16 , cmd_R7_C21 , cmd_R8_T07 , cmd_R9_C29 , cmd_R10_J18 , cmd_R11_S27 , cmd_R12_J19 , cmd_R13_T03 , cmd_R14_C21 , cmd_R15_S33 , cmd_R16_T01 , cmd_R17_J18 , cmd_R18_T05 , cmd_R19_J13 , cmd_R20_T09 , cmd_R21_J20 , cmd_R22_B36 : routeCommands := RELEASE;
begin
	singleSwitch_Sw01 : singleSwitch_0 port map(R2_command => cmd_R2_Sw01, R10_command => cmd_R10_Sw01, R11_command => cmd_R11_Sw01, R12_command => cmd_R12_Sw01, R13_command => cmd_R13_Sw01, R17_command => cmd_R17_Sw01, R14_command => cmd_R14_Sw01, R7_command => cmd_R7_Sw01, R9_command => cmd_R9_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence => state_Sw01, clock => clock, reset => reset);
	singleSwitch_Sw03 : singleSwitch_1 port map(R2_command => cmd_R2_Sw03, R12_command => cmd_R12_Sw03, R13_command => cmd_R13_Sw03, R17_command => cmd_R17_Sw03, R9_command => cmd_R9_Sw03, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence => state_Sw03, clock => clock, reset => reset);
	singleSwitch_Sw02 : singleSwitch_2 port map(R7_command => cmd_R7_Sw02, R14_command => cmd_R14_Sw02, R15_command => cmd_R15_Sw02, R16_command => cmd_R16_Sw02, R11_command => cmd_R11_Sw02, R1_command => cmd_R1_Sw02, R3_command => cmd_R3_Sw02, R6_command => cmd_R6_Sw02, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence => state_Sw02, clock => clock, reset => reset);
	singleSwitch_Sw05 : singleSwitch_3 port map(R3_command => cmd_R3_Sw05, R6_command => cmd_R6_Sw05, R18_command => cmd_R18_Sw05, R19_command => cmd_R19_Sw05, R15_command => cmd_R15_Sw05, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence => state_Sw05, clock => clock, reset => reset);
	singleSwitch_Sw08 : singleSwitch_4 port map(R5_command => cmd_R5_Sw08, R8_command => cmd_R8_Sw08, R21_command => cmd_R21_Sw08, R22_command => cmd_R22_Sw08, R12_command => cmd_R12_Sw08, R4_command => cmd_R4_Sw08, indication => singleSwitches_i(4), command => singleSwitches_o(4), correspondence => state_Sw08, clock => clock, reset => reset);
	railwaySignal_J18 : railwaySignal_0 port map(R2_command => cmd_R2_J18, R10_command => cmd_R10_J18, R17_command => cmd_R17_J18, track_ne1 => tracks_i(0), indication => signals_i(0), command => signals_o(0), correspondence_J18 => state_J18, clock => clock, reset => reset);
	railwaySignal_S22 : railwaySignal_1 port map(R11_command => cmd_R11_S22, R12_command => cmd_R12_S22, R13_command => cmd_R13_S22, track_ne1 => tracks_i(0), track_ne3 => tracks_i(2), track_ne2 => tracks_i(1), track_ne7 => tracks_i(6), track_ne6 => tracks_i(5), track_ne4 => tracks_i(3), track_ne5 => tracks_i(4), track_ne41 => tracks_i(9), correspondence_S27 => state_S27, correspondence_J19 => state_J19, correspondence_T03 => state_T03, correspondence_S33 => state_S33, correspondence_T01 => state_T01, correspondence_T07 => state_T07, Sw01_state => state_Sw01, Sw02_state => state_Sw02, Sw03_state => state_Sw03, Sw08_state => state_Sw08, indication => signals_i(1), command => signals_o(1), correspondence_S22 => state_S22, clock => clock, reset => reset);
	railwaySignal_C21 : railwaySignal_2 port map(R10_command => cmd_R10_C21, R7_command => cmd_R7_C21, R14_command => cmd_R14_C21, track_ne3 => tracks_i(2), track_ne1 => tracks_i(0), correspondence_J18 => state_J18, Sw01_state => state_Sw01, indication => signals_i(2), command => signals_o(2), correspondence_C21 => state_C21, clock => clock, reset => reset);
	railwaySignal_S27 : railwaySignal_3 port map(R15_command => cmd_R15_S27, R16_command => cmd_R16_S27, R11_command => cmd_R11_S27, track_ne3 => tracks_i(2), track_ne5 => tracks_i(4), track_ne4 => tracks_i(3), track_ne10 => tracks_i(7), track_ne11 => tracks_i(8), correspondence_S33 => state_S33, correspondence_T01 => state_T01, correspondence_T05 => state_T05, correspondence_J13 => state_J13, Sw02_state => state_Sw02, Sw05_state => state_Sw05, indication => signals_i(3), command => signals_o(3), correspondence_S27 => state_S27, clock => clock, reset => reset);
	railwaySignal_T01 : railwaySignal_4 port map(R16_command => cmd_R16_T01, track_ne4 => tracks_i(3), indication => signals_i(4), command => signals_o(4), correspondence_T01 => state_T01, clock => clock, reset => reset);
	railwaySignal_T02 : railwaySignal_5 port map(R1_command => cmd_R1_T02, track_ne4 => tracks_i(3), track_ne3 => tracks_i(2), correspondence_B26 => state_B26, correspondence_C21 => state_C21, Sw02_state => state_Sw02, indication => signals_i(5), command => signals_o(5), correspondence_T02 => state_T02, clock => clock, reset => reset);
	railwaySignal_B26 : railwaySignal_6 port map(R14_command => cmd_R14_B26, R1_command => cmd_R1_B26, track_ne4 => tracks_i(3), track_ne3 => tracks_i(2), track_ne1 => tracks_i(0), correspondence_C21 => state_C21, correspondence_J18 => state_J18, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication => signals_i(6), command => signals_o(6), correspondence_B26 => state_B26, clock => clock, reset => reset);
	railwaySignal_J16 : railwaySignal_7 port map(R7_command => cmd_R7_J16, R3_command => cmd_R3_J16, R6_command => cmd_R6_J16, track_ne5 => tracks_i(4), track_ne3 => tracks_i(2), track_ne1 => tracks_i(0), correspondence_C21 => state_C21, correspondence_J18 => state_J18, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication => signals_i(7), command => signals_o(7), correspondence_J16 => state_J16, clock => clock, reset => reset);
	railwaySignal_S33 : railwaySignal_8 port map(R18_command => cmd_R18_S33, R19_command => cmd_R19_S33, R15_command => cmd_R15_S33, track_ne5 => tracks_i(4), track_ne10 => tracks_i(7), track_ne11 => tracks_i(8), correspondence_T05 => state_T05, correspondence_J13 => state_J13, Sw05_state => state_Sw05, indication => signals_i(8), command => signals_o(8), correspondence_S33 => state_S33, clock => clock, reset => reset);
	railwaySignal_T03 : railwaySignal_9 port map(R13_command => cmd_R13_T03, track_ne6 => tracks_i(5), indication => signals_i(9), command => signals_o(9), correspondence_T03 => state_T03, clock => clock, reset => reset);
	railwaySignal_T04 : railwaySignal_10 port map(R2_command => cmd_R2_T04, track_ne6 => tracks_i(5), track_ne2 => tracks_i(1), track_ne1 => tracks_i(0), correspondence_J18 => state_J18, Sw01_state => state_Sw01, Sw03_state => state_Sw03, indication => signals_i(10), command => signals_o(10), correspondence_T04 => state_T04, clock => clock, reset => reset);
	railwaySignal_J19 : railwaySignal_11 port map(R8_command => cmd_R8_J19, R12_command => cmd_R12_J19, track_ne7 => tracks_i(6), track_ne41 => tracks_i(9), correspondence_T07 => state_T07, Sw08_state => state_Sw08, indication => signals_i(11), command => signals_o(11), correspondence_J19 => state_J19, clock => clock, reset => reset);
	railwaySignal_J20 : railwaySignal_12 port map(R9_command => cmd_R9_J20, R21_command => cmd_R21_J20, track_ne7 => tracks_i(6), track_ne2 => tracks_i(1), track_ne1 => tracks_i(0), correspondence_C29 => state_C29, correspondence_J18 => state_J18, Sw01_state => state_Sw01, Sw03_state => state_Sw03, indication => signals_i(12), command => signals_o(12), correspondence_J20 => state_J20, clock => clock, reset => reset);
	railwaySignal_C29 : railwaySignal_13 port map(R17_command => cmd_R17_C29, R9_command => cmd_R9_C29, track_ne7 => tracks_i(6), track_ne2 => tracks_i(1), track_ne1 => tracks_i(0), correspondence_J18 => state_J18, Sw01_state => state_Sw01, Sw03_state => state_Sw03, indication => signals_i(13), command => signals_o(13), correspondence_C29 => state_C29, clock => clock, reset => reset);
	railwaySignal_T05 : railwaySignal_14 port map(R18_command => cmd_R18_T05, track_ne10 => tracks_i(7), indication => signals_i(14), command => signals_o(14), correspondence_T05 => state_T05, clock => clock, reset => reset);
	railwaySignal_T06 : railwaySignal_15 port map(R3_command => cmd_R3_T06, track_ne10 => tracks_i(7), track_ne5 => tracks_i(4), track_ne3 => tracks_i(2), correspondence_J16 => state_J16, correspondence_C21 => state_C21, Sw05_state => state_Sw05, Sw02_state => state_Sw02, indication => signals_i(15), command => signals_o(15), correspondence_T06 => state_T06, clock => clock, reset => reset);
	railwaySignal_J13 : railwaySignal_16 port map(R19_command => cmd_R19_J13, track_ne11 => tracks_i(8), indication => signals_i(16), command => signals_o(16), correspondence_J13 => state_J13, clock => clock, reset => reset);
	railwaySignal_J14 : railwaySignal_17 port map(R6_command => cmd_R6_J14, track_ne11 => tracks_i(8), track_ne5 => tracks_i(4), track_ne3 => tracks_i(2), correspondence_J16 => state_J16, correspondence_C21 => state_C21, Sw05_state => state_Sw05, Sw02_state => state_Sw02, indication => signals_i(17), command => signals_o(17), correspondence_J14 => state_J14, clock => clock, reset => reset);
	railwaySignal_T07 : railwaySignal_18 port map(R5_command => cmd_R5_T07, R8_command => cmd_R8_T07, track_ne41 => tracks_i(9), indication => signals_i(18), command => signals_o(18), correspondence_T07 => state_T07, clock => clock, reset => reset);
	railwaySignal_T08 : railwaySignal_19 port map(R4_command => cmd_R4_T08, track_ne41 => tracks_i(9), track_ne7 => tracks_i(6), track_ne42 => tracks_i(10), correspondence_S37 => state_S37, correspondence_J20 => state_J20, correspondence_B36 => state_B36, Sw08_state => state_Sw08, indication => signals_i(19), command => signals_o(19), correspondence_T08 => state_T08, clock => clock, reset => reset);
	railwaySignal_S37 : railwaySignal_20 port map(R21_command => cmd_R21_S37, R22_command => cmd_R22_S37, R4_command => cmd_R4_S37, track_ne41 => tracks_i(9), track_ne7 => tracks_i(6), track_ne42 => tracks_i(10), correspondence_J20 => state_J20, correspondence_B36 => state_B36, correspondence_C29 => state_C29, correspondence_T09 => state_T09, Sw08_state => state_Sw08, indication => signals_i(20), command => signals_o(20), correspondence_S37 => state_S37, clock => clock, reset => reset);
	railwaySignal_T09 : railwaySignal_21 port map(R20_command => cmd_R20_T09, track_ne42 => tracks_i(10), indication => signals_i(21), command => signals_o(21), correspondence_T09 => state_T09, clock => clock, reset => reset);
	railwaySignal_T10 : railwaySignal_22 port map(R5_command => cmd_R5_T10, track_ne42 => tracks_i(10), track_ne41 => tracks_i(9), correspondence_T07 => state_T07, Sw08_state => state_Sw08, indication => signals_i(22), command => signals_o(22), correspondence_T10 => state_T10, clock => clock, reset => reset);
	railwaySignal_B36 : railwaySignal_23 port map(R20_command => cmd_R20_B36, R22_command => cmd_R22_B36, track_ne42 => tracks_i(10), correspondence_T09 => state_T09, indication => signals_i(23), command => signals_o(23), correspondence_B36 => state_B36, clock => clock, reset => reset);
	node_ne1 : node_0 port map(track_i => tracks_i(0), track_o => state_ne1, R2_command => cmd_R2_ne1, R10_command => cmd_R10_ne1, R11_command => cmd_R11_ne1, R12_command => cmd_R12_ne1, R13_command => cmd_R13_ne1, R17_command => cmd_R17_ne1, reset => reset);
	node_ne2 : node_1 port map(track_i => tracks_i(1), track_o => state_ne2, R2_command => cmd_R2_ne2, R12_command => cmd_R12_ne2, R13_command => cmd_R13_ne2, R17_command => cmd_R17_ne2, reset => reset);
	node_ne3 : node_2 port map(track_i => tracks_i(2), track_o => state_ne3, R7_command => cmd_R7_ne3, R10_command => cmd_R10_ne3, R11_command => cmd_R11_ne3, R14_command => cmd_R14_ne3, R15_command => cmd_R15_ne3, R16_command => cmd_R16_ne3, reset => reset);
	node_ne4 : node_3 port map(track_i => tracks_i(3), track_o => state_ne4, R1_command => cmd_R1_ne4, R14_command => cmd_R14_ne4, R16_command => cmd_R16_ne4, reset => reset);
	node_ne5 : node_4 port map(track_i => tracks_i(4), track_o => state_ne5, R3_command => cmd_R3_ne5, R6_command => cmd_R6_ne5, R7_command => cmd_R7_ne5, R15_command => cmd_R15_ne5, R18_command => cmd_R18_ne5, R19_command => cmd_R19_ne5, reset => reset);
	node_ne6 : node_5 port map(track_i => tracks_i(5), track_o => state_ne6, R2_command => cmd_R2_ne6, R13_command => cmd_R13_ne6, reset => reset);
	node_ne7 : node_6 port map(track_i => tracks_i(6), track_o => state_ne7, R8_command => cmd_R8_ne7, R9_command => cmd_R9_ne7, R12_command => cmd_R12_ne7, R17_command => cmd_R17_ne7, R21_command => cmd_R21_ne7, reset => reset);
	node_ne10 : node_7 port map(track_i => tracks_i(7), track_o => state_ne10, R3_command => cmd_R3_ne10, R18_command => cmd_R18_ne10, reset => reset);
	node_ne11 : node_8 port map(track_i => tracks_i(8), track_o => state_ne11, R6_command => cmd_R6_ne11, R19_command => cmd_R19_ne11, reset => reset);
	node_ne41 : node_9 port map(track_i => tracks_i(9), track_o => state_ne41, R4_command => cmd_R4_ne41, R5_command => cmd_R5_ne41, R8_command => cmd_R8_ne41, R21_command => cmd_R21_ne41, R22_command => cmd_R22_ne41, reset => reset);
	node_ne42 : node_10 port map(track_i => tracks_i(10), track_o => state_ne42, R5_command => cmd_R5_ne42, R20_command => cmd_R20_ne42, R22_command => cmd_R22_ne42, reset => reset);
	route_R1 : route_0 port map(routeRequest => routes_i(0), ne4_command => cmd_R1_ne4, track_ne4 => state_ne4, Sw02_command => cmd_R1_Sw02, Sw02_state => state_Sw02, T02_state => state_T02, T02_command => cmd_R1_T02, B26_state => state_B26, B26_command =>cmd_R1_B26, routeExecute => routes_o(0), clock => clock, reset => reset);
	route_R2 : route_1 port map(routeRequest => routes_i(1), ne1_command => cmd_R2_ne1, track_ne1 => state_ne1, ne2_command => cmd_R2_ne2, track_ne2 => state_ne2, ne6_command => cmd_R2_ne6, track_ne6 => state_ne6, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R2_Sw03, Sw03_state => state_Sw03, T04_state => state_T04, T04_command => cmd_R2_T04, J18_state => state_J18, J18_command =>cmd_R2_J18, routeExecute => routes_o(1), clock => clock, reset => reset);
	route_R3 : route_2 port map(routeRequest => routes_i(2), ne5_command => cmd_R3_ne5, track_ne5 => state_ne5, ne10_command => cmd_R3_ne10, track_ne10 => state_ne10, Sw02_command => cmd_R3_Sw02, Sw02_state => state_Sw02, Sw05_command => cmd_R3_Sw05, Sw05_state => state_Sw05, T06_state => state_T06, T06_command => cmd_R3_T06, J16_state => state_J16, J16_command =>cmd_R3_J16, routeExecute => routes_o(2), clock => clock, reset => reset);
	route_R4 : route_3 port map(routeRequest => routes_i(3), ne41_command => cmd_R4_ne41, track_ne41 => state_ne41, Sw08_command => cmd_R4_Sw08, Sw08_state => state_Sw08, T08_state => state_T08, T08_command => cmd_R4_T08, S37_state => state_S37, S37_command =>cmd_R4_S37, routeExecute => routes_o(3), clock => clock, reset => reset);
	route_R5 : route_4 port map(routeRequest => routes_i(4), ne41_command => cmd_R5_ne41, track_ne41 => state_ne41, ne42_command => cmd_R5_ne42, track_ne42 => state_ne42, Sw08_command => cmd_R5_Sw08, Sw08_state => state_Sw08, T10_state => state_T10, T10_command => cmd_R5_T10, T07_state => state_T07, T07_command =>cmd_R5_T07, routeExecute => routes_o(4), clock => clock, reset => reset);
	route_R6 : route_5 port map(routeRequest => routes_i(5), ne5_command => cmd_R6_ne5, track_ne5 => state_ne5, ne11_command => cmd_R6_ne11, track_ne11 => state_ne11, Sw02_command => cmd_R6_Sw02, Sw02_state => state_Sw02, Sw05_command => cmd_R6_Sw05, Sw05_state => state_Sw05, J14_state => state_J14, J14_command => cmd_R6_J14, J16_state => state_J16, J16_command =>cmd_R6_J16, routeExecute => routes_o(5), clock => clock, reset => reset);
	route_R7 : route_6 port map(routeRequest => routes_i(6), ne3_command => cmd_R7_ne3, track_ne3 => state_ne3, ne5_command => cmd_R7_ne5, track_ne5 => state_ne5, Sw01_command => cmd_R7_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R7_Sw02, Sw02_state => state_Sw02, J16_state => state_J16, J16_command => cmd_R7_J16, C21_state => state_C21, C21_command =>cmd_R7_C21, routeExecute => routes_o(6), clock => clock, reset => reset);
	route_R8 : route_7 port map(routeRequest => routes_i(7), ne7_command => cmd_R8_ne7, track_ne7 => state_ne7, ne41_command => cmd_R8_ne41, track_ne41 => state_ne41, Sw08_command => cmd_R8_Sw08, Sw08_state => state_Sw08, J19_state => state_J19, J19_command => cmd_R8_J19, T07_state => state_T07, T07_command =>cmd_R8_T07, routeExecute => routes_o(7), clock => clock, reset => reset);
	route_R9 : route_8 port map(routeRequest => routes_i(8), ne7_command => cmd_R9_ne7, track_ne7 => state_ne7, Sw01_command => cmd_R9_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R9_Sw03, Sw03_state => state_Sw03, J20_state => state_J20, J20_command => cmd_R9_J20, C29_state => state_C29, C29_command =>cmd_R9_C29, routeExecute => routes_o(8), clock => clock, reset => reset);
	route_R10 : route_9 port map(routeRequest => routes_i(9), ne1_command => cmd_R10_ne1, track_ne1 => state_ne1, ne3_command => cmd_R10_ne3, track_ne3 => state_ne3, Sw01_command => cmd_R10_Sw01, Sw01_state => state_Sw01, C21_state => state_C21, C21_command => cmd_R10_C21, J18_state => state_J18, J18_command =>cmd_R10_J18, routeExecute => routes_o(9), clock => clock, reset => reset);
	route_R11 : route_10 port map(routeRequest => routes_i(10), ne1_command => cmd_R11_ne1, track_ne1 => state_ne1, ne3_command => cmd_R11_ne3, track_ne3 => state_ne3, Sw01_command => cmd_R11_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R11_Sw02, Sw02_state => state_Sw02, S22_state => state_S22, S22_command => cmd_R11_S22, S27_state => state_S27, S27_command =>cmd_R11_S27, routeExecute => routes_o(10), clock => clock, reset => reset);
	route_R12 : route_11 port map(routeRequest => routes_i(11), ne1_command => cmd_R12_ne1, track_ne1 => state_ne1, ne2_command => cmd_R12_ne2, track_ne2 => state_ne2, ne7_command => cmd_R12_ne7, track_ne7 => state_ne7, Sw01_command => cmd_R12_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R12_Sw03, Sw03_state => state_Sw03, Sw08_command => cmd_R12_Sw08, Sw08_state => state_Sw08, S22_state => state_S22, S22_command => cmd_R12_S22, J19_state => state_J19, J19_command =>cmd_R12_J19, routeExecute => routes_o(11), clock => clock, reset => reset);
	route_R13 : route_12 port map(routeRequest => routes_i(12), ne1_command => cmd_R13_ne1, track_ne1 => state_ne1, ne2_command => cmd_R13_ne2, track_ne2 => state_ne2, ne6_command => cmd_R13_ne6, track_ne6 => state_ne6, Sw01_command => cmd_R13_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R13_Sw03, Sw03_state => state_Sw03, S22_state => state_S22, S22_command => cmd_R13_S22, T03_state => state_T03, T03_command =>cmd_R13_T03, routeExecute => routes_o(12), clock => clock, reset => reset);
	route_R14 : route_13 port map(routeRequest => routes_i(13), ne3_command => cmd_R14_ne3, track_ne3 => state_ne3, ne4_command => cmd_R14_ne4, track_ne4 => state_ne4, Sw01_command => cmd_R14_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R14_Sw02, Sw02_state => state_Sw02, B26_state => state_B26, B26_command => cmd_R14_B26, C21_state => state_C21, C21_command =>cmd_R14_C21, routeExecute => routes_o(13), clock => clock, reset => reset);
	route_R15 : route_14 port map(routeRequest => routes_i(14), ne3_command => cmd_R15_ne3, track_ne3 => state_ne3, ne5_command => cmd_R15_ne5, track_ne5 => state_ne5, Sw02_command => cmd_R15_Sw02, Sw02_state => state_Sw02, Sw05_command => cmd_R15_Sw05, Sw05_state => state_Sw05, S27_state => state_S27, S27_command => cmd_R15_S27, S33_state => state_S33, S33_command =>cmd_R15_S33, routeExecute => routes_o(14), clock => clock, reset => reset);
	route_R16 : route_15 port map(routeRequest => routes_i(15), ne3_command => cmd_R16_ne3, track_ne3 => state_ne3, ne4_command => cmd_R16_ne4, track_ne4 => state_ne4, Sw02_command => cmd_R16_Sw02, Sw02_state => state_Sw02, S27_state => state_S27, S27_command => cmd_R16_S27, T01_state => state_T01, T01_command =>cmd_R16_T01, routeExecute => routes_o(15), clock => clock, reset => reset);
	route_R17 : route_16 port map(routeRequest => routes_i(16), ne1_command => cmd_R17_ne1, track_ne1 => state_ne1, ne2_command => cmd_R17_ne2, track_ne2 => state_ne2, ne7_command => cmd_R17_ne7, track_ne7 => state_ne7, Sw01_command => cmd_R17_Sw01, Sw01_state => state_Sw01, Sw03_command => cmd_R17_Sw03, Sw03_state => state_Sw03, C29_state => state_C29, C29_command => cmd_R17_C29, J18_state => state_J18, J18_command =>cmd_R17_J18, routeExecute => routes_o(16), clock => clock, reset => reset);
	route_R18 : route_17 port map(routeRequest => routes_i(17), ne5_command => cmd_R18_ne5, track_ne5 => state_ne5, ne10_command => cmd_R18_ne10, track_ne10 => state_ne10, Sw05_command => cmd_R18_Sw05, Sw05_state => state_Sw05, S33_state => state_S33, S33_command => cmd_R18_S33, T05_state => state_T05, T05_command =>cmd_R18_T05, routeExecute => routes_o(17), clock => clock, reset => reset);
	route_R19 : route_18 port map(routeRequest => routes_i(18), ne5_command => cmd_R19_ne5, track_ne5 => state_ne5, ne11_command => cmd_R19_ne11, track_ne11 => state_ne11, Sw05_command => cmd_R19_Sw05, Sw05_state => state_Sw05, S33_state => state_S33, S33_command => cmd_R19_S33, J13_state => state_J13, J13_command =>cmd_R19_J13, routeExecute => routes_o(18), clock => clock, reset => reset);
	route_R20 : route_19 port map(routeRequest => routes_i(19), ne42_command => cmd_R20_ne42, track_ne42 => state_ne42, B36_state => state_B36, B36_command => cmd_R20_B36, T09_state => state_T09, T09_command =>cmd_R20_T09, routeExecute => routes_o(19), clock => clock, reset => reset);
	route_R21 : route_20 port map(routeRequest => routes_i(20), ne7_command => cmd_R21_ne7, track_ne7 => state_ne7, ne41_command => cmd_R21_ne41, track_ne41 => state_ne41, Sw08_command => cmd_R21_Sw08, Sw08_state => state_Sw08, S37_state => state_S37, S37_command => cmd_R21_S37, J20_state => state_J20, J20_command =>cmd_R21_J20, routeExecute => routes_o(20), clock => clock, reset => reset);
	route_R22 : route_21 port map(routeRequest => routes_i(21), ne41_command => cmd_R22_ne41, track_ne41 => state_ne41, ne42_command => cmd_R22_ne42, track_ne42 => state_ne42, Sw08_command => cmd_R22_Sw08, Sw08_state => state_Sw08, S37_state => state_S37, S37_command => cmd_R22_S37, B36_state => state_B36, B36_command =>cmd_R22_B36, routeExecute => routes_o(21), clock => clock, reset => reset);
	processed <= processing;
	tracks_o(0) <= state_ne1;
	tracks_o(1) <= state_ne2;
	tracks_o(2) <= state_ne3;
	tracks_o(3) <= state_ne4;
	tracks_o(4) <= state_ne5;
	tracks_o(5) <= state_ne6;
	tracks_o(6) <= state_ne7;
	tracks_o(7) <= state_ne10;
	tracks_o(8) <= state_ne11;
	tracks_o(9) <= state_ne41;
	tracks_o(10) <= state_ne42;
end Behavioral;