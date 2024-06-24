--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N_TRACKCIRCUITS : natural := 7;
			N_ROUTES : natural := 11;
			N_SIGNALS : natural := 13;
			N_SINGLESWITCHES : natural := 3;
			N : natural := 34
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
			R3_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
			R7_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			R4_command : in routeCommands := RELEASE;
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
			R3_command : in routeCommands := RELEASE;
			R7_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R5_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
			R4_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_2;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R10_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_T01 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_T02 : out hex_char;
			correspondence_S14 : in hex_char;
			--Ocupation level 2
			track_ne31 : in hex_char;
			track_ne32 : in hex_char;
			track_ne40 : in hex_char;
			track_ne41 : in hex_char;
			correspondence_B18 : in hex_char;
			correspondence_T03 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw18_state : in hex_char;
			Sw14_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_S14 : out hex_char;
			--Ocupation level 1
			track_ne41 : in hex_char;
			track_ne40 : in hex_char;
			track_ne31 : in hex_char;
			track_ne32 : in hex_char;
			correspondence_B18 : in hex_char;
			correspondence_T03 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw18_state : in hex_char;
			Sw14_state : in hex_char;
			--Ocupation level 2
			track_ne42 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			--Ocupation level 0
			track_ne31 : in hex_char;
			correspondence_T03 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne31 : in hex_char;
			correspondence_T04 : out hex_char;
			--Ocupation level 1
			track_ne40 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw14_state : in hex_char;
			Sw18_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			--Ocupation level 0
			track_ne32 : in hex_char;
			correspondence_T05 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne32 : in hex_char;
			correspondence_T06 : out hex_char;
			--Ocupation level 1
			track_ne40 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw14_state : in hex_char;
			Sw18_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne41 : in hex_char;
			correspondence_B18 : out hex_char;
			--Ocupation level 1
			track_ne42 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			--Ocupation level 0
			track_ne42 : in hex_char;
			correspondence_T07 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne42 : in hex_char;
			correspondence_T08 : out hex_char;
			correspondence_H20 : in hex_char;
			--Ocupation level 2
			track_ne43 : in hex_char;
			track_ne41 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_T01 : in hex_char;
			correspondence_T09 : in hex_char;
			Sw18_state : in hex_char;
			Sw19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne42 : in hex_char;
			correspondence_H20 : out hex_char;
			--Ocupation level 1
			track_ne41 : in hex_char;
			track_ne1 : in hex_char;
			track_ne43 : in hex_char;
			correspondence_T01 : in hex_char;
			correspondence_T09 : in hex_char;
			Sw18_state : in hex_char;
			Sw19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			--Ocupation level 0
			track_ne43 : in hex_char;
			correspondence_T09 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne43 : in hex_char;
			correspondence_T10 : out hex_char;
			--Ocupation level 1
			track_ne42 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw19_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_12;
	component node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_0;
	component node_1 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R7_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_1;
	component node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R8_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_2;
	component node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_3;
	component node_4 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_4;
	component node_5 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_5;
	component node_6 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R11_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_6;
--XXX  R1 ['Sw18', 'Sw14'] 
--YYY  R1 [] 
	component route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw14_state : in hex_char;
			Sw14_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			S14_state : in hex_char;
			S14_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_0;
--XXX  R2 ['Sw18', 'Sw14'] 
--YYY  R2 [] 
	component route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne31 : in hex_char;
			ne31_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw14_state : in hex_char;
			Sw14_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_1;
--XXX  R3 ['Sw18', 'Sw14'] 
--YYY  R3 [] 
	component route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne32 : in hex_char;
			ne32_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw14_state : in hex_char;
			Sw14_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_2;
--XXX  R4 ['Sw18', 'Sw19'] 
--YYY  R4 [] 
	component route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			T08_state : in hex_char;
			T08_command : out routeCommands := RELEASE;
			H20_state : in hex_char;
			H20_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_3;
--XXX  R5 ['Sw19'] 
--YYY  R5 [] 
	component route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne43 : in hex_char;
			ne43_command : out routeCommands := RELEASE;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			T10_state : in hex_char;
			T10_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_4;
--XXX  R6 ['Sw18', 'Sw19'] 
--YYY  R6 [] 
	component route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			S14_state : in hex_char;
			S14_command : out routeCommands := RELEASE;
			B18_state : in hex_char;
			B18_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_5;
--XXX  R7 ['Sw18', 'Sw14'] 
--YYY  R7 [] 
	component route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne31 : in hex_char;
			ne31_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw14_state : in hex_char;
			Sw14_command : out routeCommands := RELEASE;
			S14_state : in hex_char;
			S14_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_6;
--XXX  R8 ['Sw18', 'Sw14'] 
--YYY  R8 [] 
	component route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne32 : in hex_char;
			ne32_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw14_state : in hex_char;
			Sw14_command : out routeCommands := RELEASE;
			S14_state : in hex_char;
			S14_command : out routeCommands := RELEASE;
			T05_state : in hex_char;
			T05_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_7;
--XXX  R9 ['Sw19'] 
--YYY  R9 [] 
	component route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			B18_state : in hex_char;
			B18_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_8;
--XXX  R10 ['Sw18', 'Sw19'] 
--YYY  R10 [] 
	component route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			track_ne41 : in hex_char;
			ne41_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw18_state : in hex_char;
			Sw18_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			H20_state : in hex_char;
			H20_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_9;
--XXX  R11 ['Sw19'] 
--YYY  R11 [] 
	component route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne42 : in hex_char;
			ne42_command : out routeCommands := RELEASE;
			track_ne43 : in hex_char;
			ne43_command : out routeCommands := RELEASE;
			Sw19_state : in hex_char;
			Sw19_command : out routeCommands := RELEASE;
			H20_state : in hex_char;
			H20_command : out routeCommands := RELEASE;
			T09_state : in hex_char;
			T09_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_10;
	signal state_Sw18 , state_Sw14 , state_Sw19 : hex_char;
	signal state_T01 , state_T02 , state_S14 , state_T03 , state_T04 , state_T05 , state_T06 , state_B18 , state_T07 , state_T08 , state_H20 , state_T09 , state_T10 : hex_char;
	signal cmd_R1_ne1 , cmd_R2_ne31 , cmd_R2_ne40 , cmd_R2_ne1 , cmd_R3_ne32 , cmd_R3_ne40 , cmd_R3_ne1 , cmd_R4_ne42 , cmd_R5_ne43 , cmd_R5_ne42 , cmd_R6_ne1 , cmd_R6_ne41 , cmd_R7_ne1 , cmd_R7_ne40 , cmd_R7_ne31 , cmd_R8_ne1 , cmd_R8_ne40 , cmd_R8_ne32 , cmd_R9_ne41 , cmd_R9_ne42 , cmd_R10_ne42 , cmd_R10_ne41 , cmd_R10_ne1 , cmd_R11_ne42 , cmd_R11_ne43 : routeCommands := RELEASE;
	signal state_ne1 , state_ne31 , state_ne32 , state_ne40 , state_ne41 , state_ne42 , state_ne43 : hex_char;
	signal cmd_R2_Sw18 , cmd_R3_Sw18 , cmd_R6_Sw18 , cmd_R7_Sw18 , cmd_R8_Sw18 , cmd_R10_Sw18 , cmd_R1_Sw18 , cmd_R4_Sw18 , cmd_R2_Sw14 , cmd_R3_Sw14 , cmd_R7_Sw14 , cmd_R8_Sw14 , cmd_R1_Sw14 , cmd_R5_Sw19 , cmd_R9_Sw19 , cmd_R10_Sw19 , cmd_R11_Sw19 , cmd_R6_Sw19 , cmd_R4_Sw19 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_T06 , cmd_R4_T08 , cmd_R5_T10 , cmd_R6_S14 , cmd_R7_S14 , cmd_R8_S14 , cmd_R9_B18 , cmd_R10_H20 , cmd_R11_H20 : routeCommands := RELEASE;
	signal cmd_R1_S14 , cmd_R2_T01 , cmd_R3_T01 , cmd_R4_H20 , cmd_R5_T07 , cmd_R6_B18 , cmd_R7_T03 , cmd_R8_T05 , cmd_R9_T07 , cmd_R10_T01 , cmd_R11_T09 : routeCommands := RELEASE;
begin
	singleSwitch_Sw18 : singleSwitch_0 port map(R2_command => cmd_R2_Sw18, R3_command => cmd_R3_Sw18, R6_command => cmd_R6_Sw18, R7_command => cmd_R7_Sw18, R8_command => cmd_R8_Sw18, R10_command => cmd_R10_Sw18, R1_command => cmd_R1_Sw18, R4_command => cmd_R4_Sw18, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence => state_Sw18, clock => clock, reset => reset);
	singleSwitch_Sw14 : singleSwitch_1 port map(R2_command => cmd_R2_Sw14, R3_command => cmd_R3_Sw14, R7_command => cmd_R7_Sw14, R8_command => cmd_R8_Sw14, R1_command => cmd_R1_Sw14, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence => state_Sw14, clock => clock, reset => reset);
	singleSwitch_Sw19 : singleSwitch_2 port map(R5_command => cmd_R5_Sw19, R9_command => cmd_R9_Sw19, R10_command => cmd_R10_Sw19, R11_command => cmd_R11_Sw19, R6_command => cmd_R6_Sw19, R4_command => cmd_R4_Sw19, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence => state_Sw19, clock => clock, reset => reset);
	railwaySignal_T01 : railwaySignal_0 port map(R2_command => cmd_R2_T01, R3_command => cmd_R3_T01, R10_command => cmd_R10_T01, track_ne1 => tracks_i(0), indication => signals_i(0), command => signals_o(0), correspondence_T01 => state_T01, clock => clock, reset => reset);
	railwaySignal_T02 : railwaySignal_1 port map(R1_command => cmd_R1_T02, track_ne1 => tracks_i(0), track_ne31 => tracks_i(1), track_ne32 => tracks_i(2), track_ne40 => tracks_i(3), track_ne41 => tracks_i(4), correspondence_S14 => state_S14, correspondence_B18 => state_B18, correspondence_T03 => state_T03, correspondence_T05 => state_T05, Sw18_state => state_Sw18, Sw14_state => state_Sw14, indication => signals_i(1), command => signals_o(1), correspondence_T02 => state_T02, clock => clock, reset => reset);
	railwaySignal_S14 : railwaySignal_2 port map(R6_command => cmd_R6_S14, R7_command => cmd_R7_S14, R8_command => cmd_R8_S14, R1_command => cmd_R1_S14, track_ne1 => tracks_i(0), track_ne41 => tracks_i(4), track_ne40 => tracks_i(3), track_ne31 => tracks_i(1), track_ne32 => tracks_i(2), track_ne42 => tracks_i(5), correspondence_B18 => state_B18, correspondence_T03 => state_T03, correspondence_T05 => state_T05, correspondence_T07 => state_T07, Sw18_state => state_Sw18, Sw19_state => state_Sw19, Sw14_state => state_Sw14, indication => signals_i(2), command => signals_o(2), correspondence_S14 => state_S14, clock => clock, reset => reset);
	railwaySignal_T03 : railwaySignal_3 port map(R7_command => cmd_R7_T03, track_ne31 => tracks_i(1), indication => signals_i(3), command => signals_o(3), correspondence_T03 => state_T03, clock => clock, reset => reset);
	railwaySignal_T04 : railwaySignal_4 port map(R2_command => cmd_R2_T04, track_ne31 => tracks_i(1), track_ne40 => tracks_i(3), track_ne1 => tracks_i(0), correspondence_T01 => state_T01, Sw14_state => state_Sw14, Sw18_state => state_Sw18, indication => signals_i(4), command => signals_o(4), correspondence_T04 => state_T04, clock => clock, reset => reset);
	railwaySignal_T05 : railwaySignal_5 port map(R8_command => cmd_R8_T05, track_ne32 => tracks_i(2), indication => signals_i(5), command => signals_o(5), correspondence_T05 => state_T05, clock => clock, reset => reset);
	railwaySignal_T06 : railwaySignal_6 port map(R3_command => cmd_R3_T06, track_ne32 => tracks_i(2), track_ne40 => tracks_i(3), track_ne1 => tracks_i(0), correspondence_T01 => state_T01, Sw14_state => state_Sw14, Sw18_state => state_Sw18, indication => signals_i(6), command => signals_o(6), correspondence_T06 => state_T06, clock => clock, reset => reset);
	railwaySignal_B18 : railwaySignal_7 port map(R9_command => cmd_R9_B18, R6_command => cmd_R6_B18, track_ne41 => tracks_i(4), track_ne42 => tracks_i(5), correspondence_T07 => state_T07, Sw19_state => state_Sw19, indication => signals_i(7), command => signals_o(7), correspondence_B18 => state_B18, clock => clock, reset => reset);
	railwaySignal_T07 : railwaySignal_8 port map(R5_command => cmd_R5_T07, R9_command => cmd_R9_T07, track_ne42 => tracks_i(5), indication => signals_i(8), command => signals_o(8), correspondence_T07 => state_T07, clock => clock, reset => reset);
	railwaySignal_T08 : railwaySignal_9 port map(R4_command => cmd_R4_T08, track_ne42 => tracks_i(5), track_ne43 => tracks_i(6), track_ne41 => tracks_i(4), track_ne1 => tracks_i(0), correspondence_H20 => state_H20, correspondence_T01 => state_T01, correspondence_T09 => state_T09, Sw18_state => state_Sw18, Sw19_state => state_Sw19, indication => signals_i(9), command => signals_o(9), correspondence_T08 => state_T08, clock => clock, reset => reset);
	railwaySignal_H20 : railwaySignal_10 port map(R10_command => cmd_R10_H20, R11_command => cmd_R11_H20, R4_command => cmd_R4_H20, track_ne42 => tracks_i(5), track_ne41 => tracks_i(4), track_ne1 => tracks_i(0), track_ne43 => tracks_i(6), correspondence_T01 => state_T01, correspondence_T09 => state_T09, Sw18_state => state_Sw18, Sw19_state => state_Sw19, indication => signals_i(10), command => signals_o(10), correspondence_H20 => state_H20, clock => clock, reset => reset);
	railwaySignal_T09 : railwaySignal_11 port map(R11_command => cmd_R11_T09, track_ne43 => tracks_i(6), indication => signals_i(11), command => signals_o(11), correspondence_T09 => state_T09, clock => clock, reset => reset);
	railwaySignal_T10 : railwaySignal_12 port map(R5_command => cmd_R5_T10, track_ne43 => tracks_i(6), track_ne42 => tracks_i(5), correspondence_T07 => state_T07, Sw19_state => state_Sw19, indication => signals_i(12), command => signals_o(12), correspondence_T10 => state_T10, clock => clock, reset => reset);
	node_ne1 : node_0 port map(track_i => tracks_i(0), track_o => state_ne1, R1_command => cmd_R1_ne1, R2_command => cmd_R2_ne1, R3_command => cmd_R3_ne1, R6_command => cmd_R6_ne1, R7_command => cmd_R7_ne1, R8_command => cmd_R8_ne1, R10_command => cmd_R10_ne1, reset => reset);
	node_ne31 : node_1 port map(track_i => tracks_i(1), track_o => state_ne31, R2_command => cmd_R2_ne31, R7_command => cmd_R7_ne31, reset => reset);
	node_ne32 : node_2 port map(track_i => tracks_i(2), track_o => state_ne32, R3_command => cmd_R3_ne32, R8_command => cmd_R8_ne32, reset => reset);
	node_ne40 : node_3 port map(track_i => tracks_i(3), track_o => state_ne40, R2_command => cmd_R2_ne40, R3_command => cmd_R3_ne40, R7_command => cmd_R7_ne40, R8_command => cmd_R8_ne40, reset => reset);
	node_ne41 : node_4 port map(track_i => tracks_i(4), track_o => state_ne41, R6_command => cmd_R6_ne41, R9_command => cmd_R9_ne41, R10_command => cmd_R10_ne41, reset => reset);
	node_ne42 : node_5 port map(track_i => tracks_i(5), track_o => state_ne42, R4_command => cmd_R4_ne42, R5_command => cmd_R5_ne42, R9_command => cmd_R9_ne42, R10_command => cmd_R10_ne42, R11_command => cmd_R11_ne42, reset => reset);
	node_ne43 : node_6 port map(track_i => tracks_i(6), track_o => state_ne43, R5_command => cmd_R5_ne43, R11_command => cmd_R11_ne43, reset => reset);
	route_R1 : route_0 port map(routeRequest => routes_i(0), ne1_command => cmd_R1_ne1, track_ne1 => state_ne1, Sw18_command => cmd_R1_Sw18, Sw18_state => state_Sw18, Sw14_command => cmd_R1_Sw14, Sw14_state => state_Sw14, T02_state => state_T02, T02_command => cmd_R1_T02, S14_state => state_S14, S14_command =>cmd_R1_S14, routeExecute => routes_o(0), clock => clock, reset => reset);
	route_R2 : route_1 port map(routeRequest => routes_i(1), ne1_command => cmd_R2_ne1, track_ne1 => state_ne1, ne31_command => cmd_R2_ne31, track_ne31 => state_ne31, ne40_command => cmd_R2_ne40, track_ne40 => state_ne40, Sw18_command => cmd_R2_Sw18, Sw18_state => state_Sw18, Sw14_command => cmd_R2_Sw14, Sw14_state => state_Sw14, T04_state => state_T04, T04_command => cmd_R2_T04, T01_state => state_T01, T01_command =>cmd_R2_T01, routeExecute => routes_o(1), clock => clock, reset => reset);
	route_R3 : route_2 port map(routeRequest => routes_i(2), ne1_command => cmd_R3_ne1, track_ne1 => state_ne1, ne32_command => cmd_R3_ne32, track_ne32 => state_ne32, ne40_command => cmd_R3_ne40, track_ne40 => state_ne40, Sw18_command => cmd_R3_Sw18, Sw18_state => state_Sw18, Sw14_command => cmd_R3_Sw14, Sw14_state => state_Sw14, T06_state => state_T06, T06_command => cmd_R3_T06, T01_state => state_T01, T01_command =>cmd_R3_T01, routeExecute => routes_o(2), clock => clock, reset => reset);
	route_R4 : route_3 port map(routeRequest => routes_i(3), ne42_command => cmd_R4_ne42, track_ne42 => state_ne42, Sw18_command => cmd_R4_Sw18, Sw18_state => state_Sw18, Sw19_command => cmd_R4_Sw19, Sw19_state => state_Sw19, T08_state => state_T08, T08_command => cmd_R4_T08, H20_state => state_H20, H20_command =>cmd_R4_H20, routeExecute => routes_o(3), clock => clock, reset => reset);
	route_R5 : route_4 port map(routeRequest => routes_i(4), ne42_command => cmd_R5_ne42, track_ne42 => state_ne42, ne43_command => cmd_R5_ne43, track_ne43 => state_ne43, Sw19_command => cmd_R5_Sw19, Sw19_state => state_Sw19, T10_state => state_T10, T10_command => cmd_R5_T10, T07_state => state_T07, T07_command =>cmd_R5_T07, routeExecute => routes_o(4), clock => clock, reset => reset);
	route_R6 : route_5 port map(routeRequest => routes_i(5), ne1_command => cmd_R6_ne1, track_ne1 => state_ne1, ne41_command => cmd_R6_ne41, track_ne41 => state_ne41, Sw18_command => cmd_R6_Sw18, Sw18_state => state_Sw18, Sw19_command => cmd_R6_Sw19, Sw19_state => state_Sw19, S14_state => state_S14, S14_command => cmd_R6_S14, B18_state => state_B18, B18_command =>cmd_R6_B18, routeExecute => routes_o(5), clock => clock, reset => reset);
	route_R7 : route_6 port map(routeRequest => routes_i(6), ne1_command => cmd_R7_ne1, track_ne1 => state_ne1, ne31_command => cmd_R7_ne31, track_ne31 => state_ne31, ne40_command => cmd_R7_ne40, track_ne40 => state_ne40, Sw18_command => cmd_R7_Sw18, Sw18_state => state_Sw18, Sw14_command => cmd_R7_Sw14, Sw14_state => state_Sw14, S14_state => state_S14, S14_command => cmd_R7_S14, T03_state => state_T03, T03_command =>cmd_R7_T03, routeExecute => routes_o(6), clock => clock, reset => reset);
	route_R8 : route_7 port map(routeRequest => routes_i(7), ne1_command => cmd_R8_ne1, track_ne1 => state_ne1, ne32_command => cmd_R8_ne32, track_ne32 => state_ne32, ne40_command => cmd_R8_ne40, track_ne40 => state_ne40, Sw18_command => cmd_R8_Sw18, Sw18_state => state_Sw18, Sw14_command => cmd_R8_Sw14, Sw14_state => state_Sw14, S14_state => state_S14, S14_command => cmd_R8_S14, T05_state => state_T05, T05_command =>cmd_R8_T05, routeExecute => routes_o(7), clock => clock, reset => reset);
	route_R9 : route_8 port map(routeRequest => routes_i(8), ne41_command => cmd_R9_ne41, track_ne41 => state_ne41, ne42_command => cmd_R9_ne42, track_ne42 => state_ne42, Sw19_command => cmd_R9_Sw19, Sw19_state => state_Sw19, B18_state => state_B18, B18_command => cmd_R9_B18, T07_state => state_T07, T07_command =>cmd_R9_T07, routeExecute => routes_o(8), clock => clock, reset => reset);
	route_R10 : route_9 port map(routeRequest => routes_i(9), ne1_command => cmd_R10_ne1, track_ne1 => state_ne1, ne41_command => cmd_R10_ne41, track_ne41 => state_ne41, ne42_command => cmd_R10_ne42, track_ne42 => state_ne42, Sw18_command => cmd_R10_Sw18, Sw18_state => state_Sw18, Sw19_command => cmd_R10_Sw19, Sw19_state => state_Sw19, H20_state => state_H20, H20_command => cmd_R10_H20, T01_state => state_T01, T01_command =>cmd_R10_T01, routeExecute => routes_o(9), clock => clock, reset => reset);
	route_R11 : route_10 port map(routeRequest => routes_i(10), ne42_command => cmd_R11_ne42, track_ne42 => state_ne42, ne43_command => cmd_R11_ne43, track_ne43 => state_ne43, Sw19_command => cmd_R11_Sw19, Sw19_state => state_Sw19, H20_state => state_H20, H20_command => cmd_R11_H20, T09_state => state_T09, T09_command =>cmd_R11_T09, routeExecute => routes_o(10), clock => clock, reset => reset);
	processed <= processing;
	tracks_o(0) <= state_ne1;
	tracks_o(1) <= state_ne31;
	tracks_o(2) <= state_ne32;
	tracks_o(3) <= state_ne40;
	tracks_o(4) <= state_ne41;
	tracks_o(5) <= state_ne42;
	tracks_o(6) <= state_ne43;
end Behavioral;