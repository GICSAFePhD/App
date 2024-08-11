--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N_TRACKCIRCUITS : natural := 5;
			N_ROUTES : natural := 13;
			N_SIGNALS : natural := 16;
			N_LEVELCROSSINGS : natural := 6;
			N_SINGLESWITCHES : natural := 2;
			N : natural := 42
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			tracks_i : in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_o : out hex_array(N_TRACKCIRCUITS-1 downto 0);
			signals_i : in hex_array(N_SIGNALS-1 downto 0);
			signals_o : out hex_array(N_SIGNALS-1 downto 0);
			routes_i : in hex_array(N_ROUTES-1 downto 0);
			routes_o : out hex_array(N_ROUTES-1 downto 0);
			levelCrossings_i : in hex_array(N_LEVELCROSSINGS-1 downto 0);
			levelCrossings_o : out hex_array(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches_i : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out hex_array(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity network;
architecture Behavioral of network is
	component levelCrossing_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne3 : in hex_char;
			track_ne26 : in hex_char;
			track_ne27 : in hex_char;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_0;
	component levelCrossing_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne23 : in hex_char;
			track_ne25 : in hex_char;
			track_ne27 : in hex_char;
			R3_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_1;
	component levelCrossing_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne23 : in hex_char;
			track_ne25 : in hex_char;
			track_ne27 : in hex_char;
			R4_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			R3_command : in routeCommands;
			R6_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_2;
	component levelCrossing_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne25 : in hex_char;
			track_ne23 : in hex_char;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_3;
	component levelCrossing_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne26 : in hex_char;
			track_ne3 : in hex_char;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R12_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_4;
	component levelCrossing_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne26 : in hex_char;
			track_ne3 : in hex_char;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R1_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_5;
	component singleSwitch_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R10_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R13_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R6_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R13_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_1;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_L01 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_X16 : out hex_char;
			correspondence_L01 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			Lc06_state : in hex_char;
			Lc03_state : in hex_char;
			Lc04_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_S25 : out hex_char;
			--Ocupation level 1
			track_ne26 : in hex_char;
			track_ne27 : in hex_char;
			track_ne23 : in hex_char;
			correspondence_X07 : in hex_char;
			correspondence_X12 : in hex_char;
			Sw12_state : in hex_char;
			Sw11_state : in hex_char;
			correspondence_L04 : in hex_char;
			correspondence_P19 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_L02 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			Lc07_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_X09 : out hex_char;
			correspondence_S22 : in hex_char;
			--Ocupation level 2
			track_ne25 : in hex_char;
			track_ne27 : in hex_char;
			track_ne3 : in hex_char;
			correspondence_X13 : in hex_char;
			correspondence_X16 : in hex_char;
			Sw11_state : in hex_char;
			Sw12_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R6_command : in routeCommands;
			R13_command : in routeCommands;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_X12 : out hex_char;
			correspondence_P19 : in hex_char;
			--Ocupation level 2
			correspondence_L02 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			R4_command : in routeCommands;
			Lc07_state : in hex_char;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_P19 : out hex_char;
			correspondence_L02 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R3_command : in routeCommands;
			Lc09_state : in hex_char;
			Lc05_state : in hex_char;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_S22 : out hex_char;
			--Ocupation level 1
			track_ne25 : in hex_char;
			track_ne27 : in hex_char;
			track_ne3 : in hex_char;
			correspondence_X13 : in hex_char;
			correspondence_X16 : in hex_char;
			Sw11_state : in hex_char;
			Sw12_state : in hex_char;
			correspondence_L03 : in hex_char;
			correspondence_L01 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne25 : in hex_char;
			correspondence_L03 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R9_command : in routeCommands;
			Lc05_state : in hex_char;
			--Ocupation level 0
			track_ne25 : in hex_char;
			correspondence_X13 : out hex_char;
			correspondence_L03 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			Lc05_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne25 : in hex_char;
			correspondence_X14 : out hex_char;
			--Ocupation level 1
			track_ne23 : in hex_char;
			correspondence_X12 : in hex_char;
			Sw11_state : in hex_char;
			correspondence_P19 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne26 : in hex_char;
			correspondence_L04 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			--Ocupation level 0
			track_ne26 : in hex_char;
			correspondence_X05 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			Lc03_state : in hex_char;
			Lc04_state : in hex_char;
			--Ocupation level 0
			track_ne26 : in hex_char;
			correspondence_X06 : out hex_char;
			correspondence_C24 : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			correspondence_X16 : in hex_char;
			Sw12_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			R12_command : in routeCommands;
			Lc03_state : in hex_char;
			Lc04_state : in hex_char;
			--Ocupation level 0
			track_ne26 : in hex_char;
			correspondence_X07 : out hex_char;
			correspondence_L04 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R1_command : in routeCommands;
			Lc04_state : in hex_char;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne26 : in hex_char;
			correspondence_C24 : out hex_char;
			--Ocupation level 1
			track_ne3 : in hex_char;
			correspondence_X16 : in hex_char;
			Sw12_state : in hex_char;
			correspondence_L01 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_15;
	component node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R7_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_0;
	component node_1 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R6_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_1;
	component node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_2;
	component node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_3;
	component node_4 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_4;
--sw  R1 ['Sw12'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 ['Lc03', 'Lc04'] 
	component route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			Lc03_state : in hex_char;
			Lc03_command : out routeCommands := RELEASE;
			Lc04_state : in hex_char;
			Lc04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			X06_state : in hex_char;
			X06_command : out routeCommands := RELEASE;
			C24_state : in hex_char;
			C24_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_0;
--sw  R2 [] 
--dw  R2 [] 
--sc  R2 [] 
--lc  R2 ['Lc03', 'Lc04'] 
	component route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			Lc03_state : in hex_char;
			Lc03_command : out routeCommands := RELEASE;
			Lc04_state : in hex_char;
			Lc04_command : out routeCommands := RELEASE;
			X07_state : in hex_char;
			X07_command : out routeCommands := RELEASE;
			L04_state : in hex_char;
			L04_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_1;
--sw  R3 ['Sw12', 'Sw11'] 
--dw  R3 [] 
--sc  R3 [] 
--lc  R3 ['Lc07', 'Lc09'] 
	component route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Lc07_state : in hex_char;
			Lc07_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			X09_state : in hex_char;
			X09_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_2;
--sw  R4 [] 
--dw  R4 [] 
--sc  R4 [] 
--lc  R4 ['Lc09'] 
	component route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			X12_state : in hex_char;
			X12_command : out routeCommands := RELEASE;
			P19_state : in hex_char;
			P19_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_3;
--sw  R5 [] 
--dw  R5 [] 
--sc  R5 [] 
--lc  R5 ['Lc05'] 
	component route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne25 : in hex_char;
			ne25_command : out routeCommands := RELEASE;
			Lc05_state : in hex_char;
			Lc05_command : out routeCommands := RELEASE;
			X13_state : in hex_char;
			X13_command : out routeCommands := RELEASE;
			L03_state : in hex_char;
			L03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_4;
--sw  R6 ['Sw11'] 
--dw  R6 [] 
--sc  R6 [] 
--lc  R6 ['Lc09', 'Lc05'] 
	component route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne25 : in hex_char;
			ne25_command : out routeCommands := RELEASE;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Lc05_state : in hex_char;
			Lc05_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			X14_state : in hex_char;
			X14_command : out routeCommands := RELEASE;
			X12_state : in hex_char;
			X12_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_5;
--sw  R7 [] 
--dw  R7 [] 
--sc  R7 [] 
--lc  R7 ['Lc06'] 
	component route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			X16_state : in hex_char;
			X16_command : out routeCommands := RELEASE;
			L01_state : in hex_char;
			L01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_6;
--sw  R8 [] 
--dw  R8 [] 
--sc  R8 [] 
--lc  R8 ['Lc07'] 
	component route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Lc07_state : in hex_char;
			Lc07_command : out routeCommands := RELEASE;
			P19_state : in hex_char;
			P19_command : out routeCommands := RELEASE;
			L02_state : in hex_char;
			L02_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_7;
--sw  R9 ['Sw11'] 
--dw  R9 [] 
--sc  R9 [] 
--lc  R9 ['Lc09', 'Lc05'] 
	component route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			track_ne25 : in hex_char;
			ne25_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Lc05_state : in hex_char;
			Lc05_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			X13_state : in hex_char;
			X13_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_8;
--sw  R10 ['Sw12', 'Sw11'] 
--dw  R10 [] 
--sc  R10 [] 
--lc  R10 ['Lc06', 'Lc09'] 
	component route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			track_ne27 : in hex_char;
			ne27_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			X16_state : in hex_char;
			X16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_9;
--sw  R11 ['Sw12'] 
--dw  R11 [] 
--sc  R11 [] 
--lc  R11 ['Lc06', 'Lc04'] 
	component route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Lc04_state : in hex_char;
			Lc04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			C24_state : in hex_char;
			C24_command : out routeCommands := RELEASE;
			X16_state : in hex_char;
			X16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_10;
--sw  R12 ['Sw12'] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 ['Lc06', 'Lc03', 'Lc04'] 
	component route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne26 : in hex_char;
			ne26_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Lc03_state : in hex_char;
			Lc03_command : out routeCommands := RELEASE;
			Lc04_state : in hex_char;
			Lc04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			S25_state : in hex_char;
			S25_command : out routeCommands := RELEASE;
			X07_state : in hex_char;
			X07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_11;
--sw  R13 ['Sw12', 'Sw11'] 
--dw  R13 [] 
--sc  R13 [] 
--lc  R13 ['Lc06', 'Lc09'] 
	component route_12 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne27 : in hex_char;
			ne27_command : out routeCommands := RELEASE;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw11_state : in hex_char;
			Sw11_command : out routeCommands := RELEASE;
			S25_state : in hex_char;
			S25_command : out routeCommands := RELEASE;
			X12_state : in hex_char;
			X12_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_12;
	signal state_Lc06 , state_Lc07 , state_Lc09 , state_Lc05 , state_Lc03 , state_Lc04 : hex_char;
	signal state_Sw12 , state_Sw11 : hex_char;
	signal state_L01 , state_X16 , state_S25 , state_L02 , state_X09 , state_X12 , state_P19 , state_S22 , state_L03 , state_X13 , state_X14 , state_L04 , state_X05 , state_X06 , state_X07 , state_C24 : hex_char;
	signal cmd_R1_ne26 , cmd_R2_ne26 , cmd_R3_ne23 , cmd_R4_ne23 , cmd_R5_ne25 , cmd_R6_ne25 , cmd_R6_ne23 , cmd_R7_ne3 , cmd_R8_ne23 , cmd_R9_ne23 , cmd_R9_ne25 , cmd_R10_ne23 , cmd_R10_ne27 , cmd_R10_ne3 , cmd_R11_ne26 , cmd_R11_ne3 , cmd_R12_ne3 , cmd_R12_ne26 , cmd_R13_ne3 , cmd_R13_ne27 , cmd_R13_ne23 : routeCommands := RELEASE;
	signal state_ne3 , state_ne23 , state_ne25 , state_ne26 , state_ne27 : hex_char;
	signal cmd_R7_Lc06 , cmd_R12_Lc06 , cmd_R13_Lc06 , cmd_R10_Lc06 , cmd_R11_Lc06 , cmd_R3_Lc07 , cmd_R8_Lc07 , cmd_R4_Lc09 , cmd_R9_Lc09 , cmd_R10_Lc09 , cmd_R13_Lc09 , cmd_R3_Lc09 , cmd_R6_Lc09 , cmd_R5_Lc05 , cmd_R6_Lc05 , cmd_R9_Lc05 , cmd_R1_Lc03 , cmd_R2_Lc03 , cmd_R12_Lc03 , cmd_R2_Lc04 , cmd_R11_Lc04 , cmd_R12_Lc04 , cmd_R1_Lc04 : routeCommands := RELEASE;
	signal cmd_R10_Sw12 , cmd_R11_Sw12 , cmd_R12_Sw12 , cmd_R13_Sw12 , cmd_R3_Sw12 , cmd_R1_Sw12 , cmd_R6_Sw11 , cmd_R9_Sw11 , cmd_R10_Sw11 , cmd_R13_Sw11 , cmd_R3_Sw11 : routeCommands := RELEASE;
	signal cmd_R1_X06 , cmd_R2_X07 , cmd_R3_X09 , cmd_R4_X12 , cmd_R5_X13 , cmd_R6_X14 , cmd_R7_X16 , cmd_R8_P19 , cmd_R9_S22 , cmd_R10_S22 , cmd_R11_C24 , cmd_R12_S25 , cmd_R13_S25 : routeCommands := RELEASE;
	signal cmd_R1_C24 , cmd_R2_L04 , cmd_R3_S22 , cmd_R4_P19 , cmd_R5_L03 , cmd_R6_X12 , cmd_R7_L01 , cmd_R8_L02 , cmd_R9_X13 , cmd_R10_X16 , cmd_R11_X16 , cmd_R12_X07 , cmd_R13_X12 : routeCommands := RELEASE;
begin
	levelCrossing_Lc06 : levelCrossing_0 port map(track_ne3 => tracks_i(0), track_ne26 => tracks_i(3), track_ne27 => tracks_i(4), R7_command => cmd_R7_Lc06, R12_command => cmd_R12_Lc06, R13_command => cmd_R13_Lc06, R10_command => cmd_R10_Lc06, R11_command => cmd_R11_Lc06, indication => levelCrossings_i(0), command  => levelCrossings_o(0), correspondence => state_Lc06, clock => clock, reset => reset);
	levelCrossing_Lc07 : levelCrossing_1 port map(track_ne23 => tracks_i(1), track_ne25 => tracks_i(2), track_ne27 => tracks_i(4), R3_command => cmd_R3_Lc07, R8_command => cmd_R8_Lc07, indication => levelCrossings_i(1), command  => levelCrossings_o(1), correspondence => state_Lc07, clock => clock, reset => reset);
	levelCrossing_Lc09 : levelCrossing_2 port map(track_ne23 => tracks_i(1), track_ne25 => tracks_i(2), track_ne27 => tracks_i(4), R4_command => cmd_R4_Lc09, R9_command => cmd_R9_Lc09, R10_command => cmd_R10_Lc09, R13_command => cmd_R13_Lc09, R3_command => cmd_R3_Lc09, R6_command => cmd_R6_Lc09, indication => levelCrossings_i(2), command  => levelCrossings_o(2), correspondence => state_Lc09, clock => clock, reset => reset);
	levelCrossing_Lc05 : levelCrossing_3 port map(track_ne25 => tracks_i(2), track_ne23 => tracks_i(1), R5_command => cmd_R5_Lc05, R6_command => cmd_R6_Lc05, R9_command => cmd_R9_Lc05, indication => levelCrossings_i(3), command  => levelCrossings_o(3), correspondence => state_Lc05, clock => clock, reset => reset);
	levelCrossing_Lc03 : levelCrossing_4 port map(track_ne26 => tracks_i(3), track_ne3 => tracks_i(0), R1_command => cmd_R1_Lc03, R2_command => cmd_R2_Lc03, R12_command => cmd_R12_Lc03, indication => levelCrossings_i(4), command  => levelCrossings_o(4), correspondence => state_Lc03, clock => clock, reset => reset);
	levelCrossing_Lc04 : levelCrossing_5 port map(track_ne26 => tracks_i(3), track_ne3 => tracks_i(0), R2_command => cmd_R2_Lc04, R11_command => cmd_R11_Lc04, R12_command => cmd_R12_Lc04, R1_command => cmd_R1_Lc04, indication => levelCrossings_i(5), command  => levelCrossings_o(5), correspondence => state_Lc04, clock => clock, reset => reset);
	singleSwitch_Sw12 : singleSwitch_0 port map(R10_command => cmd_R10_Sw12, R11_command => cmd_R11_Sw12, R12_command => cmd_R12_Sw12, R13_command => cmd_R13_Sw12, R3_command => cmd_R3_Sw12, R1_command => cmd_R1_Sw12, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence => state_Sw12, clock => clock, reset => reset);
	singleSwitch_Sw11 : singleSwitch_1 port map(R6_command => cmd_R6_Sw11, R9_command => cmd_R9_Sw11, R10_command => cmd_R10_Sw11, R13_command => cmd_R13_Sw11, R3_command => cmd_R3_Sw11, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence => state_Sw11, clock => clock, reset => reset);
	railwaySignal_L01 : railwaySignal_0 port map(R7_command => cmd_R7_L01, track_ne3 => tracks_i(0), indication => signals_i(0), command => signals_o(0), correspondence_L01 => state_L01, clock => clock, reset => reset);
	railwaySignal_X16 : railwaySignal_1 port map(R7_command => cmd_R7_X16, R10_command => cmd_R10_X16, R11_command => cmd_R11_X16, track_ne3 => tracks_i(0), correspondence_L01 => state_L01, Lc06_state => state_Lc06, indication => signals_i(1), command => signals_o(1), correspondence_X16 => state_X16, clock => clock, reset => reset);
	railwaySignal_S25 : railwaySignal_2 port map(R12_command => cmd_R12_S25, R13_command => cmd_R13_S25, track_ne3 => tracks_i(0), track_ne26 => tracks_i(3), track_ne27 => tracks_i(4), track_ne23 => tracks_i(1), correspondence_X07 => state_X07, correspondence_X12 => state_X12, correspondence_L04 => state_L04, correspondence_P19 => state_P19, Sw12_state => state_Sw12, Sw11_state => state_Sw11, Lc06_state => state_Lc06, Lc03_state => state_Lc03, Lc04_state => state_Lc04, Lc09_state => state_Lc09, indication => signals_i(2), command => signals_o(2), correspondence_S25 => state_S25, clock => clock, reset => reset);
	railwaySignal_L02 : railwaySignal_3 port map(R8_command => cmd_R8_L02, track_ne23 => tracks_i(1), indication => signals_i(3), command => signals_o(3), correspondence_L02 => state_L02, clock => clock, reset => reset);
	railwaySignal_X09 : railwaySignal_4 port map(R3_command => cmd_R3_X09, track_ne23 => tracks_i(1), track_ne25 => tracks_i(2), track_ne27 => tracks_i(4), track_ne3 => tracks_i(0), correspondence_S22 => state_S22, correspondence_X13 => state_X13, correspondence_X16 => state_X16, Sw11_state => state_Sw11, Sw12_state => state_Sw12, Lc07_state => state_Lc07, Lc09_state => state_Lc09, indication => signals_i(4), command => signals_o(4), correspondence_X09 => state_X09, clock => clock, reset => reset);
	railwaySignal_X12 : railwaySignal_5 port map(R4_command => cmd_R4_X12, R6_command => cmd_R6_X12, R13_command => cmd_R13_X12, track_ne23 => tracks_i(1), correspondence_P19 => state_P19, correspondence_L02 => state_L02, Lc09_state => state_Lc09, indication => signals_i(5), command => signals_o(5), correspondence_X12 => state_X12, clock => clock, reset => reset);
	railwaySignal_P19 : railwaySignal_6 port map(R8_command => cmd_R8_P19, R4_command => cmd_R4_P19, track_ne23 => tracks_i(1), correspondence_L02 => state_L02, Lc07_state => state_Lc07, indication => signals_i(6), command => signals_o(6), correspondence_P19 => state_P19, clock => clock, reset => reset);
	railwaySignal_S22 : railwaySignal_7 port map(R9_command => cmd_R9_S22, R10_command => cmd_R10_S22, R3_command => cmd_R3_S22, track_ne23 => tracks_i(1), track_ne25 => tracks_i(2), track_ne27 => tracks_i(4), track_ne3 => tracks_i(0), correspondence_X13 => state_X13, correspondence_X16 => state_X16, correspondence_L03 => state_L03, correspondence_L01 => state_L01, Sw11_state => state_Sw11, Sw12_state => state_Sw12, Lc09_state => state_Lc09, Lc05_state => state_Lc05, Lc06_state => state_Lc06, indication => signals_i(7), command => signals_o(7), correspondence_S22 => state_S22, clock => clock, reset => reset);
	railwaySignal_L03 : railwaySignal_8 port map(R5_command => cmd_R5_L03, track_ne25 => tracks_i(2), indication => signals_i(8), command => signals_o(8), correspondence_L03 => state_L03, clock => clock, reset => reset);
	railwaySignal_X13 : railwaySignal_9 port map(R5_command => cmd_R5_X13, R9_command => cmd_R9_X13, track_ne25 => tracks_i(2), correspondence_L03 => state_L03, Lc05_state => state_Lc05, indication => signals_i(9), command => signals_o(9), correspondence_X13 => state_X13, clock => clock, reset => reset);
	railwaySignal_X14 : railwaySignal_10 port map(R6_command => cmd_R6_X14, track_ne25 => tracks_i(2), track_ne23 => tracks_i(1), correspondence_X12 => state_X12, correspondence_P19 => state_P19, Sw11_state => state_Sw11, Lc05_state => state_Lc05, Lc09_state => state_Lc09, indication => signals_i(10), command => signals_o(10), correspondence_X14 => state_X14, clock => clock, reset => reset);
	railwaySignal_L04 : railwaySignal_11 port map(R2_command => cmd_R2_L04, track_ne26 => tracks_i(3), indication => signals_i(11), command => signals_o(11), correspondence_L04 => state_L04, clock => clock, reset => reset);
	railwaySignal_X05 : railwaySignal_12 port map(track_ne26 => tracks_i(3), indication => signals_i(12), command => signals_o(12), correspondence_X05 => state_X05, clock => clock, reset => reset);
	railwaySignal_X06 : railwaySignal_13 port map(R1_command => cmd_R1_X06, track_ne26 => tracks_i(3), track_ne3 => tracks_i(0), correspondence_C24 => state_C24, correspondence_X16 => state_X16, Sw12_state => state_Sw12, Lc03_state => state_Lc03, Lc04_state => state_Lc04, indication => signals_i(13), command => signals_o(13), correspondence_X06 => state_X06, clock => clock, reset => reset);
	railwaySignal_X07 : railwaySignal_14 port map(R2_command => cmd_R2_X07, R12_command => cmd_R12_X07, track_ne26 => tracks_i(3), correspondence_L04 => state_L04, Lc03_state => state_Lc03, Lc04_state => state_Lc04, indication => signals_i(14), command => signals_o(14), correspondence_X07 => state_X07, clock => clock, reset => reset);
	railwaySignal_C24 : railwaySignal_15 port map(R11_command => cmd_R11_C24, R1_command => cmd_R1_C24, track_ne26 => tracks_i(3), track_ne3 => tracks_i(0), correspondence_X16 => state_X16, correspondence_L01 => state_L01, Sw12_state => state_Sw12, Lc04_state => state_Lc04, Lc06_state => state_Lc06, indication => signals_i(15), command => signals_o(15), correspondence_C24 => state_C24, clock => clock, reset => reset);
	node_ne3 : node_0 port map(track_i => tracks_i(0), track_o => state_ne3, R7_command => cmd_R7_ne3, R10_command => cmd_R10_ne3, R11_command => cmd_R11_ne3, R12_command => cmd_R12_ne3, R13_command => cmd_R13_ne3, reset => reset);
	node_ne23 : node_1 port map(track_i => tracks_i(1), track_o => state_ne23, R3_command => cmd_R3_ne23, R4_command => cmd_R4_ne23, R6_command => cmd_R6_ne23, R8_command => cmd_R8_ne23, R9_command => cmd_R9_ne23, R10_command => cmd_R10_ne23, R13_command => cmd_R13_ne23, reset => reset);
	node_ne25 : node_2 port map(track_i => tracks_i(2), track_o => state_ne25, R5_command => cmd_R5_ne25, R6_command => cmd_R6_ne25, R9_command => cmd_R9_ne25, reset => reset);
	node_ne26 : node_3 port map(track_i => tracks_i(3), track_o => state_ne26, R1_command => cmd_R1_ne26, R2_command => cmd_R2_ne26, R11_command => cmd_R11_ne26, R12_command => cmd_R12_ne26, reset => reset);
	node_ne27 : node_4 port map(track_i => tracks_i(4), track_o => state_ne27, R10_command => cmd_R10_ne27, R13_command => cmd_R13_ne27, reset => reset);
	route_R1 : route_0 port map(routeRequest => routes_i(0), ne26_command => cmd_R1_ne26, track_ne26 => state_ne26, Lc03_command => cmd_R1_Lc03, Lc03_state => state_Lc03, Lc04_command => cmd_R1_Lc04, Lc04_state => state_Lc04, Sw12_command => cmd_R1_Sw12, Sw12_state => state_Sw12, X06_state => state_X06, X06_command => cmd_R1_X06, C24_state => state_C24, C24_command =>cmd_R1_C24, routeExecute => routes_o(0), clock => clock, reset => reset);
	route_R2 : route_1 port map(routeRequest => routes_i(1), ne26_command => cmd_R2_ne26, track_ne26 => state_ne26, Lc03_command => cmd_R2_Lc03, Lc03_state => state_Lc03, Lc04_command => cmd_R2_Lc04, Lc04_state => state_Lc04, X07_state => state_X07, X07_command => cmd_R2_X07, L04_state => state_L04, L04_command =>cmd_R2_L04, routeExecute => routes_o(1), clock => clock, reset => reset);
	route_R3 : route_2 port map(routeRequest => routes_i(2), ne23_command => cmd_R3_ne23, track_ne23 => state_ne23, Lc07_command => cmd_R3_Lc07, Lc07_state => state_Lc07, Lc09_command => cmd_R3_Lc09, Lc09_state => state_Lc09, Sw12_command => cmd_R3_Sw12, Sw12_state => state_Sw12, Sw11_command => cmd_R3_Sw11, Sw11_state => state_Sw11, X09_state => state_X09, X09_command => cmd_R3_X09, S22_state => state_S22, S22_command =>cmd_R3_S22, routeExecute => routes_o(2), clock => clock, reset => reset);
	route_R4 : route_3 port map(routeRequest => routes_i(3), ne23_command => cmd_R4_ne23, track_ne23 => state_ne23, Lc09_command => cmd_R4_Lc09, Lc09_state => state_Lc09, X12_state => state_X12, X12_command => cmd_R4_X12, P19_state => state_P19, P19_command =>cmd_R4_P19, routeExecute => routes_o(3), clock => clock, reset => reset);
	route_R5 : route_4 port map(routeRequest => routes_i(4), ne25_command => cmd_R5_ne25, track_ne25 => state_ne25, Lc05_command => cmd_R5_Lc05, Lc05_state => state_Lc05, X13_state => state_X13, X13_command => cmd_R5_X13, L03_state => state_L03, L03_command =>cmd_R5_L03, routeExecute => routes_o(4), clock => clock, reset => reset);
	route_R6 : route_5 port map(routeRequest => routes_i(5), ne23_command => cmd_R6_ne23, track_ne23 => state_ne23, ne25_command => cmd_R6_ne25, track_ne25 => state_ne25, Lc09_command => cmd_R6_Lc09, Lc09_state => state_Lc09, Lc05_command => cmd_R6_Lc05, Lc05_state => state_Lc05, Sw11_command => cmd_R6_Sw11, Sw11_state => state_Sw11, X14_state => state_X14, X14_command => cmd_R6_X14, X12_state => state_X12, X12_command =>cmd_R6_X12, routeExecute => routes_o(5), clock => clock, reset => reset);
	route_R7 : route_6 port map(routeRequest => routes_i(6), ne3_command => cmd_R7_ne3, track_ne3 => state_ne3, Lc06_command => cmd_R7_Lc06, Lc06_state => state_Lc06, X16_state => state_X16, X16_command => cmd_R7_X16, L01_state => state_L01, L01_command =>cmd_R7_L01, routeExecute => routes_o(6), clock => clock, reset => reset);
	route_R8 : route_7 port map(routeRequest => routes_i(7), ne23_command => cmd_R8_ne23, track_ne23 => state_ne23, Lc07_command => cmd_R8_Lc07, Lc07_state => state_Lc07, P19_state => state_P19, P19_command => cmd_R8_P19, L02_state => state_L02, L02_command =>cmd_R8_L02, routeExecute => routes_o(7), clock => clock, reset => reset);
	route_R9 : route_8 port map(routeRequest => routes_i(8), ne23_command => cmd_R9_ne23, track_ne23 => state_ne23, ne25_command => cmd_R9_ne25, track_ne25 => state_ne25, Lc09_command => cmd_R9_Lc09, Lc09_state => state_Lc09, Lc05_command => cmd_R9_Lc05, Lc05_state => state_Lc05, Sw11_command => cmd_R9_Sw11, Sw11_state => state_Sw11, S22_state => state_S22, S22_command => cmd_R9_S22, X13_state => state_X13, X13_command =>cmd_R9_X13, routeExecute => routes_o(8), clock => clock, reset => reset);
	route_R10 : route_9 port map(routeRequest => routes_i(9), ne3_command => cmd_R10_ne3, track_ne3 => state_ne3, ne23_command => cmd_R10_ne23, track_ne23 => state_ne23, ne27_command => cmd_R10_ne27, track_ne27 => state_ne27, Lc06_command => cmd_R10_Lc06, Lc06_state => state_Lc06, Lc09_command => cmd_R10_Lc09, Lc09_state => state_Lc09, Sw12_command => cmd_R10_Sw12, Sw12_state => state_Sw12, Sw11_command => cmd_R10_Sw11, Sw11_state => state_Sw11, S22_state => state_S22, S22_command => cmd_R10_S22, X16_state => state_X16, X16_command =>cmd_R10_X16, routeExecute => routes_o(9), clock => clock, reset => reset);
	route_R11 : route_10 port map(routeRequest => routes_i(10), ne3_command => cmd_R11_ne3, track_ne3 => state_ne3, ne26_command => cmd_R11_ne26, track_ne26 => state_ne26, Lc06_command => cmd_R11_Lc06, Lc06_state => state_Lc06, Lc04_command => cmd_R11_Lc04, Lc04_state => state_Lc04, Sw12_command => cmd_R11_Sw12, Sw12_state => state_Sw12, C24_state => state_C24, C24_command => cmd_R11_C24, X16_state => state_X16, X16_command =>cmd_R11_X16, routeExecute => routes_o(10), clock => clock, reset => reset);
	route_R12 : route_11 port map(routeRequest => routes_i(11), ne3_command => cmd_R12_ne3, track_ne3 => state_ne3, ne26_command => cmd_R12_ne26, track_ne26 => state_ne26, Lc06_command => cmd_R12_Lc06, Lc06_state => state_Lc06, Lc03_command => cmd_R12_Lc03, Lc03_state => state_Lc03, Lc04_command => cmd_R12_Lc04, Lc04_state => state_Lc04, Sw12_command => cmd_R12_Sw12, Sw12_state => state_Sw12, S25_state => state_S25, S25_command => cmd_R12_S25, X07_state => state_X07, X07_command =>cmd_R12_X07, routeExecute => routes_o(11), clock => clock, reset => reset);
	route_R13 : route_12 port map(routeRequest => routes_i(12), ne3_command => cmd_R13_ne3, track_ne3 => state_ne3, ne23_command => cmd_R13_ne23, track_ne23 => state_ne23, ne27_command => cmd_R13_ne27, track_ne27 => state_ne27, Lc06_command => cmd_R13_Lc06, Lc06_state => state_Lc06, Lc09_command => cmd_R13_Lc09, Lc09_state => state_Lc09, Sw12_command => cmd_R13_Sw12, Sw12_state => state_Sw12, Sw11_command => cmd_R13_Sw11, Sw11_state => state_Sw11, S25_state => state_S25, S25_command => cmd_R13_S25, X12_state => state_X12, X12_command =>cmd_R13_X12, routeExecute => routes_o(12), clock => clock, reset => reset);
	processed <= processing;
	tracks_o(0) <= state_ne3;
	tracks_o(1) <= state_ne23;
	tracks_o(2) <= state_ne25;
	tracks_o(3) <= state_ne26;
	tracks_o(4) <= state_ne27;
end Behavioral;