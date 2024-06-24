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
			N_ROUTES : natural := 21;
			N_SIGNALS : natural := 23;
			N_LEVELCROSSINGS : natural := 2;
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
			track_ne13 : in hex_char;
			track_ne2 : in hex_char;
			R1_command : in routeCommands;
			R16_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_0;
	component levelCrossing_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne14 : in hex_char;
			track_ne9 : in hex_char;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			R2_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_1;
	component singleSwitch_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R8_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R13_command : in routeCommands := RELEASE;
			R17_command : in routeCommands := RELEASE;
			R21_command : in routeCommands := RELEASE;
			R2_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			R5_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_0;
	component singleSwitch_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R9_command : in routeCommands := RELEASE;
			R14_command : in routeCommands := RELEASE;
			R15_command : in routeCommands := RELEASE;
			R16_command : in routeCommands := RELEASE;
			R19_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
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
			R18_command : in routeCommands := RELEASE;
			R19_command : in routeCommands := RELEASE;
			R21_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R8_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R13_command : in routeCommands := RELEASE;
			R17_command : in routeCommands := RELEASE;
			R2_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_3;
	component singleSwitch_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R6_command : in routeCommands := RELEASE;
			R19_command : in routeCommands := RELEASE;
			R20_command : in routeCommands := RELEASE;
			R21_command : in routeCommands := RELEASE;
			R15_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_4;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R17_command : in routeCommands;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_L07 : out hex_char;
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
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne1 : in hex_char;
			correspondence_S22 : out hex_char;
			--Ocupation level 1
			track_ne8 : in hex_char;
			track_ne9 : in hex_char;
			track_ne14 : in hex_char;
			track_ne15 : in hex_char;
			correspondence_S32 : in hex_char;
			correspondence_X15 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw04_state : in hex_char;
			Sw07_state : in hex_char;
			--Ocupation level 2
			track_ne22 : in hex_char;
			track_ne24 : in hex_char;
			track_ne12 : in hex_char;
			correspondence_J11 : in hex_char;
			correspondence_C25 : in hex_char;
			correspondence_T03 : in hex_char;
			Sw12_state : in hex_char;
			Sw13_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R14_command : in routeCommands;
			--Ocupation level 0
			track_ne2 : in hex_char;
			correspondence_L08 : out hex_char;
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
			Lc08_state : in hex_char;
			--Ocupation level 0
			track_ne2 : in hex_char;
			correspondence_S27 : out hex_char;
			--Ocupation level 1
			track_ne12 : in hex_char;
			track_ne13 : in hex_char;
			correspondence_S35 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw06_state : in hex_char;
			--Ocupation level 2
			track_ne24 : in hex_char;
			track_ne8 : in hex_char;
			track_ne23 : in hex_char;
			correspondence_J14 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw13_state : in hex_char;
			Sw12_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			R5_command : in routeCommands;
			R21_command : in routeCommands;
			--Ocupation level 0
			track_ne8 : in hex_char;
			correspondence_C21 : out hex_char;
			--Ocupation level 1
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R11_command : in routeCommands;
			--Ocupation level 0
			track_ne8 : in hex_char;
			correspondence_S32 : out hex_char;
			--Ocupation level 1
			track_ne22 : in hex_char;
			track_ne24 : in hex_char;
			track_ne12 : in hex_char;
			correspondence_J11 : in hex_char;
			correspondence_C25 : in hex_char;
			Sw12_state : in hex_char;
			Sw13_state : in hex_char;
			--Ocupation level 2
			track_ne2 : in hex_char;
			correspondence_L09 : in hex_char;
			correspondence_L08 : in hex_char;
			Sw06_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			R6_command : in routeCommands;
			R19_command : in routeCommands;
			--Ocupation level 0
			track_ne12 : in hex_char;
			correspondence_C25 : out hex_char;
			--Ocupation level 1
			track_ne2 : in hex_char;
			correspondence_L08 : in hex_char;
			Sw06_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R15_command : in routeCommands;
			--Ocupation level 0
			track_ne12 : in hex_char;
			correspondence_S35 : out hex_char;
			--Ocupation level 1
			track_ne23 : in hex_char;
			track_ne24 : in hex_char;
			track_ne8 : in hex_char;
			correspondence_J14 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw13_state : in hex_char;
			Sw12_state : in hex_char;
			--Ocupation level 2
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R16_command : in routeCommands;
			--Ocupation level 0
			track_ne13 : in hex_char;
			correspondence_T01 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			Lc08_state : in hex_char;
			--Ocupation level 0
			track_ne13 : in hex_char;
			correspondence_T02 : out hex_char;
			correspondence_P20 : in hex_char;
			--Ocupation level 2
			track_ne2 : in hex_char;
			correspondence_L08 : in hex_char;
			Sw06_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne13 : in hex_char;
			correspondence_P20 : out hex_char;
			--Ocupation level 1
			track_ne2 : in hex_char;
			correspondence_L08 : in hex_char;
			Sw06_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			--Ocupation level 0
			track_ne14 : in hex_char;
			correspondence_T03 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne14 : in hex_char;
			correspondence_T04 : out hex_char;
			correspondence_X16 : in hex_char;
			--Ocupation level 2
			track_ne9 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
			Sw07_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne14 : in hex_char;
			correspondence_X15 : out hex_char;
			correspondence_T03 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			R2_command : in routeCommands;
			Lc06_state : in hex_char;
			--Ocupation level 0
			track_ne14 : in hex_char;
			correspondence_X16 : out hex_char;
			--Ocupation level 1
			track_ne9 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
			Sw07_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R13_command : in routeCommands;
			--Ocupation level 0
			track_ne15 : in hex_char;
			correspondence_T05 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_15;
	component railwaySignal_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne15 : in hex_char;
			correspondence_T06 : out hex_char;
			correspondence_C29 : in hex_char;
			--Ocupation level 2
			track_ne9 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
			Sw07_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_16;
	component railwaySignal_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R17_command : in routeCommands;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne15 : in hex_char;
			correspondence_C29 : out hex_char;
			--Ocupation level 1
			track_ne9 : in hex_char;
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
			Sw07_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_17;
	component railwaySignal_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne22 : in hex_char;
			correspondence_L09 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_18;
	component railwaySignal_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R18_command : in routeCommands;
			--Ocupation level 0
			track_ne22 : in hex_char;
			correspondence_J11 : out hex_char;
			correspondence_L09 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_19;
	component railwaySignal_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne22 : in hex_char;
			correspondence_J12 : out hex_char;
			--Ocupation level 1
			track_ne8 : in hex_char;
			correspondence_C21 : in hex_char;
			Sw12_state : in hex_char;
			--Ocupation level 2
			track_ne1 : in hex_char;
			correspondence_L07 : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_20;
	component railwaySignal_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_J13 : out hex_char;
			--Ocupation level 1
			track_ne12 : in hex_char;
			correspondence_C25 : in hex_char;
			Sw13_state : in hex_char;
			--Ocupation level 2
			track_ne2 : in hex_char;
			correspondence_L08 : in hex_char;
			Sw06_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_21;
	component railwaySignal_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			--Ocupation level 0
			track_ne23 : in hex_char;
			correspondence_J14 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_22;
	component node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R8_command : in routeCommands;
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
			R9_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_1;
	component node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R18_command : in routeCommands;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_2;
	component node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_3;
	component node_4 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R14_command : in routeCommands;
			R15_command : in routeCommands;
			R19_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_4;
	component node_5 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R9_command : in routeCommands;
			R16_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_5;
	component node_6 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R12_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_6;
	component node_7 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R13_command : in routeCommands;
			R17_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_7;
	component node_8 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R18_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_8;
	component node_9 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R20_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_9;
	component node_10 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_10;
--XXX  R1 ['Sw06'] 
--YYY  R1 ['Lc08'] 
	component route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne13 : in hex_char;
			ne13_command : out routeCommands := RELEASE;
			Lc08_state : in hex_char;
			Lc08_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			P20_state : in hex_char;
			P20_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_0;
--XXX  R2 ['Sw04', 'Sw07'] 
--YYY  R2 ['Lc06'] 
	component route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne14 : in hex_char;
			ne14_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			X16_state : in hex_char;
			X16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_1;
--XXX  R3 ['Sw04', 'Sw07'] 
--YYY  R3 [] 
	component route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne15 : in hex_char;
			ne15_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			C29_state : in hex_char;
			C29_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_2;
--XXX  R4 [] 
--YYY  R4 [] 
	component route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne22 : in hex_char;
			ne22_command : out routeCommands := RELEASE;
			J11_state : in hex_char;
			J11_command : out routeCommands := RELEASE;
			L09_state : in hex_char;
			L09_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_3;
--XXX  R5 ['Sw04', 'Sw12'] 
--YYY  R5 [] 
	component route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne22 : in hex_char;
			ne22_command : out routeCommands := RELEASE;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			J12_state : in hex_char;
			J12_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_4;
--XXX  R6 ['Sw06', 'Sw13'] 
--YYY  R6 [] 
	component route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			J13_state : in hex_char;
			J13_command : out routeCommands := RELEASE;
			C25_state : in hex_char;
			C25_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_5;
--XXX  R7 [] 
--YYY  R7 ['Lc06'] 
	component route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne14 : in hex_char;
			ne14_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			X15_state : in hex_char;
			X15_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_6;
--XXX  R8 ['Sw04', 'Sw07'] 
--YYY  R8 ['Lc06'] 
	component route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne14 : in hex_char;
			ne14_command : out routeCommands := RELEASE;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			X16_state : in hex_char;
			X16_command : out routeCommands := RELEASE;
			L07_state : in hex_char;
			L07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_7;
--XXX  R9 ['Sw06'] 
--YYY  R9 [] 
	component route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne13 : in hex_char;
			ne13_command : out routeCommands := RELEASE;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			P20_state : in hex_char;
			P20_command : out routeCommands := RELEASE;
			L08_state : in hex_char;
			L08_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_8;
--XXX  R10 ['Sw04'] 
--YYY  R10 [] 
	component route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			L07_state : in hex_char;
			L07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_9;
--XXX  R11 ['Sw04', 'Sw12'] 
--YYY  R11 [] 
	component route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			S32_state : in hex_char;
			S32_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_10;
--XXX  R12 ['Sw04', 'Sw07'] 
--YYY  R12 ['Lc06'] 
	component route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			track_ne14 : in hex_char;
			ne14_command : out routeCommands := RELEASE;
			Lc06_state : in hex_char;
			Lc06_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			X15_state : in hex_char;
			X15_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_11;
--XXX  R13 ['Sw04', 'Sw07'] 
--YYY  R13 [] 
	component route_12 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			track_ne15 : in hex_char;
			ne15_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			S22_state : in hex_char;
			S22_command : out routeCommands := RELEASE;
			T05_state : in hex_char;
			T05_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_12;
--XXX  R14 ['Sw06'] 
--YYY  R14 [] 
	component route_13 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			C25_state : in hex_char;
			C25_command : out routeCommands := RELEASE;
			L08_state : in hex_char;
			L08_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_13;
--XXX  R15 ['Sw06', 'Sw13'] 
--YYY  R15 [] 
	component route_14 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			S27_state : in hex_char;
			S27_command : out routeCommands := RELEASE;
			S35_state : in hex_char;
			S35_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_14;
--XXX  R16 ['Sw06'] 
--YYY  R16 ['Lc08'] 
	component route_15 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne2 : in hex_char;
			ne2_command : out routeCommands := RELEASE;
			track_ne13 : in hex_char;
			ne13_command : out routeCommands := RELEASE;
			Lc08_state : in hex_char;
			Lc08_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			S27_state : in hex_char;
			S27_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_15;
--XXX  R17 ['Sw04', 'Sw07'] 
--YYY  R17 [] 
	component route_16 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne15 : in hex_char;
			ne15_command : out routeCommands := RELEASE;
			track_ne9 : in hex_char;
			ne9_command : out routeCommands := RELEASE;
			track_ne1 : in hex_char;
			ne1_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw07_state : in hex_char;
			Sw07_command : out routeCommands := RELEASE;
			C29_state : in hex_char;
			C29_command : out routeCommands := RELEASE;
			L07_state : in hex_char;
			L07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_16;
--XXX  R18 ['Sw12'] 
--YYY  R18 [] 
	component route_17 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			track_ne22 : in hex_char;
			ne22_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			S32_state : in hex_char;
			S32_command : out routeCommands := RELEASE;
			J11_state : in hex_char;
			J11_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_17;
--XXX  R19 ['Sw06', 'Sw12', 'Sw13'] 
--YYY  R19 [] 
	component route_18 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			track_ne24 : in hex_char;
			ne24_command : out routeCommands := RELEASE;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			Sw06_state : in hex_char;
			Sw06_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			S32_state : in hex_char;
			S32_command : out routeCommands := RELEASE;
			C25_state : in hex_char;
			C25_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_18;
--XXX  R20 ['Sw13'] 
--YYY  R20 [] 
	component route_19 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			track_ne23 : in hex_char;
			ne23_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			S35_state : in hex_char;
			S35_command : out routeCommands := RELEASE;
			J14_state : in hex_char;
			J14_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_19;
--XXX  R21 ['Sw04', 'Sw12', 'Sw13'] 
--YYY  R21 [] 
	component route_20 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne12 : in hex_char;
			ne12_command : out routeCommands := RELEASE;
			track_ne24 : in hex_char;
			ne24_command : out routeCommands := RELEASE;
			track_ne8 : in hex_char;
			ne8_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			Sw12_state : in hex_char;
			Sw12_command : out routeCommands := RELEASE;
			Sw13_state : in hex_char;
			Sw13_command : out routeCommands := RELEASE;
			S35_state : in hex_char;
			S35_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_20;
	signal state_Lc08 , state_Lc06 : hex_char;
	signal state_Sw04 , state_Sw06 , state_Sw12 , state_Sw07 , state_Sw13 : hex_char;
	signal state_L07 , state_S22 , state_L08 , state_S27 , state_C21 , state_S32 , state_C25 , state_S35 , state_T01 , state_T02 , state_P20 , state_T03 , state_T04 , state_X15 , state_X16 , state_T05 , state_T06 , state_C29 , state_L09 , state_J11 , state_J12 , state_J13 , state_J14 : hex_char;
	signal cmd_R1_ne13 , cmd_R2_ne14 , cmd_R3_ne15 , cmd_R4_ne22 , cmd_R5_ne22 , cmd_R5_ne8 , cmd_R6_ne23 , cmd_R6_ne12 , cmd_R7_ne14 , cmd_R8_ne14 , cmd_R8_ne9 , cmd_R8_ne1 , cmd_R9_ne13 , cmd_R9_ne2 , cmd_R10_ne8 , cmd_R10_ne1 , cmd_R11_ne1 , cmd_R11_ne8 , cmd_R12_ne1 , cmd_R12_ne9 , cmd_R12_ne14 , cmd_R13_ne1 , cmd_R13_ne9 , cmd_R13_ne15 , cmd_R14_ne12 , cmd_R14_ne2 , cmd_R15_ne2 , cmd_R15_ne12 , cmd_R16_ne2 , cmd_R16_ne13 , cmd_R17_ne15 , cmd_R17_ne9 , cmd_R17_ne1 , cmd_R18_ne8 , cmd_R18_ne22 , cmd_R19_ne8 , cmd_R19_ne24 , cmd_R19_ne12 , cmd_R20_ne12 , cmd_R20_ne23 , cmd_R21_ne12 , cmd_R21_ne24 , cmd_R21_ne8 : routeCommands := RELEASE;
	signal state_ne1 , state_ne2 , state_ne8 , state_ne9 , state_ne12 , state_ne13 , state_ne14 , state_ne15 , state_ne22 , state_ne23 , state_ne24 : hex_char;
	signal cmd_R1_Lc08 , cmd_R16_Lc08 , cmd_R7_Lc06 , cmd_R8_Lc06 , cmd_R12_Lc06 , cmd_R2_Lc06 : routeCommands := RELEASE;
	signal cmd_R8_Sw04 , cmd_R10_Sw04 , cmd_R11_Sw04 , cmd_R12_Sw04 , cmd_R13_Sw04 , cmd_R17_Sw04 , cmd_R21_Sw04 , cmd_R2_Sw04 , cmd_R3_Sw04 , cmd_R5_Sw04 , cmd_R9_Sw06 , cmd_R14_Sw06 , cmd_R15_Sw06 , cmd_R16_Sw06 , cmd_R19_Sw06 , cmd_R1_Sw06 , cmd_R6_Sw06 , cmd_R5_Sw12 , cmd_R18_Sw12 , cmd_R19_Sw12 , cmd_R21_Sw12 , cmd_R11_Sw12 , cmd_R8_Sw07 , cmd_R12_Sw07 , cmd_R13_Sw07 , cmd_R17_Sw07 , cmd_R2_Sw07 , cmd_R3_Sw07 , cmd_R6_Sw13 , cmd_R19_Sw13 , cmd_R20_Sw13 , cmd_R21_Sw13 , cmd_R15_Sw13 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_T06 , cmd_R4_J11 , cmd_R5_J12 , cmd_R6_J13 , cmd_R7_X15 , cmd_R8_X16 , cmd_R9_P20 , cmd_R10_C21 , cmd_R11_S22 , cmd_R12_S22 , cmd_R13_S22 , cmd_R14_C25 , cmd_R15_S27 , cmd_R16_S27 , cmd_R17_C29 , cmd_R18_S32 , cmd_R19_S32 , cmd_R20_S35 , cmd_R21_S35 : routeCommands := RELEASE;
	signal cmd_R1_P20 , cmd_R2_X16 , cmd_R3_C29 , cmd_R4_L09 , cmd_R5_C21 , cmd_R6_C25 , cmd_R7_T03 , cmd_R8_L07 , cmd_R9_L08 , cmd_R10_L07 , cmd_R11_S32 , cmd_R12_X15 , cmd_R13_T05 , cmd_R14_L08 , cmd_R15_S35 , cmd_R16_T01 , cmd_R17_L07 , cmd_R18_J11 , cmd_R19_C25 , cmd_R20_J14 , cmd_R21_C21 : routeCommands := RELEASE;
begin
	levelCrossing_Lc08 : levelCrossing_0 port map(track_ne13 => tracks_i(5), track_ne2 => tracks_i(1), R1_command => cmd_R1_Lc08, R16_command => cmd_R16_Lc08, indication => levelCrossings_i(0), command  => levelCrossings_o(0), correspondence => state_Lc08, clock => clock, reset => reset);
	levelCrossing_Lc06 : levelCrossing_1 port map(track_ne14 => tracks_i(6), track_ne9 => tracks_i(3), R7_command => cmd_R7_Lc06, R8_command => cmd_R8_Lc06, R12_command => cmd_R12_Lc06, R2_command => cmd_R2_Lc06, indication => levelCrossings_i(1), command  => levelCrossings_o(1), correspondence => state_Lc06, clock => clock, reset => reset);
	singleSwitch_Sw04 : singleSwitch_0 port map(R8_command => cmd_R8_Sw04, R10_command => cmd_R10_Sw04, R11_command => cmd_R11_Sw04, R12_command => cmd_R12_Sw04, R13_command => cmd_R13_Sw04, R17_command => cmd_R17_Sw04, R21_command => cmd_R21_Sw04, R2_command => cmd_R2_Sw04, R3_command => cmd_R3_Sw04, R5_command => cmd_R5_Sw04, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence => state_Sw04, clock => clock, reset => reset);
	singleSwitch_Sw06 : singleSwitch_1 port map(R9_command => cmd_R9_Sw06, R14_command => cmd_R14_Sw06, R15_command => cmd_R15_Sw06, R16_command => cmd_R16_Sw06, R19_command => cmd_R19_Sw06, R1_command => cmd_R1_Sw06, R6_command => cmd_R6_Sw06, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence => state_Sw06, clock => clock, reset => reset);
	singleSwitch_Sw12 : singleSwitch_2 port map(R5_command => cmd_R5_Sw12, R18_command => cmd_R18_Sw12, R19_command => cmd_R19_Sw12, R21_command => cmd_R21_Sw12, R11_command => cmd_R11_Sw12, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence => state_Sw12, clock => clock, reset => reset);
	singleSwitch_Sw07 : singleSwitch_3 port map(R8_command => cmd_R8_Sw07, R12_command => cmd_R12_Sw07, R13_command => cmd_R13_Sw07, R17_command => cmd_R17_Sw07, R2_command => cmd_R2_Sw07, R3_command => cmd_R3_Sw07, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence => state_Sw07, clock => clock, reset => reset);
	singleSwitch_Sw13 : singleSwitch_4 port map(R6_command => cmd_R6_Sw13, R19_command => cmd_R19_Sw13, R20_command => cmd_R20_Sw13, R21_command => cmd_R21_Sw13, R15_command => cmd_R15_Sw13, indication => singleSwitches_i(4), command => singleSwitches_o(4), correspondence => state_Sw13, clock => clock, reset => reset);
	railwaySignal_L07 : railwaySignal_0 port map(R8_command => cmd_R8_L07, R10_command => cmd_R10_L07, R17_command => cmd_R17_L07, track_ne1 => tracks_i(0), indication => signals_i(0), command => signals_o(0), correspondence_L07 => state_L07, clock => clock, reset => reset);
	railwaySignal_S22 : railwaySignal_1 port map(R11_command => cmd_R11_S22, R12_command => cmd_R12_S22, R13_command => cmd_R13_S22, track_ne1 => tracks_i(0), track_ne8 => tracks_i(2), track_ne9 => tracks_i(3), track_ne14 => tracks_i(6), track_ne15 => tracks_i(7), track_ne22 => tracks_i(8), track_ne24 => tracks_i(10), track_ne12 => tracks_i(4), correspondence_S32 => state_S32, correspondence_X15 => state_X15, correspondence_T05 => state_T05, correspondence_J11 => state_J11, correspondence_C25 => state_C25, correspondence_T03 => state_T03, Sw04_state => state_Sw04, Sw12_state => state_Sw12, Sw13_state => state_Sw13, Sw07_state => state_Sw07, Lc06_state => state_Lc06, indication => signals_i(1), command => signals_o(1), correspondence_S22 => state_S22, clock => clock, reset => reset);
	railwaySignal_L08 : railwaySignal_2 port map(R9_command => cmd_R9_L08, R14_command => cmd_R14_L08, track_ne2 => tracks_i(1), indication => signals_i(2), command => signals_o(2), correspondence_L08 => state_L08, clock => clock, reset => reset);
	railwaySignal_S27 : railwaySignal_3 port map(R15_command => cmd_R15_S27, R16_command => cmd_R16_S27, track_ne2 => tracks_i(1), track_ne12 => tracks_i(4), track_ne13 => tracks_i(5), track_ne24 => tracks_i(10), track_ne8 => tracks_i(2), track_ne23 => tracks_i(9), correspondence_S35 => state_S35, correspondence_T01 => state_T01, correspondence_J14 => state_J14, correspondence_C21 => state_C21, Sw06_state => state_Sw06, Sw13_state => state_Sw13, Sw12_state => state_Sw12, Lc08_state => state_Lc08, indication => signals_i(3), command => signals_o(3), correspondence_S27 => state_S27, clock => clock, reset => reset);
	railwaySignal_C21 : railwaySignal_4 port map(R10_command => cmd_R10_C21, R5_command => cmd_R5_C21, R21_command => cmd_R21_C21, track_ne8 => tracks_i(2), track_ne1 => tracks_i(0), correspondence_L07 => state_L07, Sw04_state => state_Sw04, indication => signals_i(4), command => signals_o(4), correspondence_C21 => state_C21, clock => clock, reset => reset);
	railwaySignal_S32 : railwaySignal_5 port map(R18_command => cmd_R18_S32, R19_command => cmd_R19_S32, R11_command => cmd_R11_S32, track_ne8 => tracks_i(2), track_ne22 => tracks_i(8), track_ne24 => tracks_i(10), track_ne12 => tracks_i(4), track_ne2 => tracks_i(1), correspondence_J11 => state_J11, correspondence_C25 => state_C25, correspondence_L09 => state_L09, correspondence_L08 => state_L08, Sw12_state => state_Sw12, Sw13_state => state_Sw13, Sw06_state => state_Sw06, indication => signals_i(5), command => signals_o(5), correspondence_S32 => state_S32, clock => clock, reset => reset);
	railwaySignal_C25 : railwaySignal_6 port map(R14_command => cmd_R14_C25, R6_command => cmd_R6_C25, R19_command => cmd_R19_C25, track_ne12 => tracks_i(4), track_ne2 => tracks_i(1), correspondence_L08 => state_L08, Sw06_state => state_Sw06, indication => signals_i(6), command => signals_o(6), correspondence_C25 => state_C25, clock => clock, reset => reset);
	railwaySignal_S35 : railwaySignal_7 port map(R20_command => cmd_R20_S35, R21_command => cmd_R21_S35, R15_command => cmd_R15_S35, track_ne12 => tracks_i(4), track_ne23 => tracks_i(9), track_ne24 => tracks_i(10), track_ne8 => tracks_i(2), track_ne1 => tracks_i(0), correspondence_J14 => state_J14, correspondence_C21 => state_C21, correspondence_L07 => state_L07, Sw13_state => state_Sw13, Sw12_state => state_Sw12, Sw04_state => state_Sw04, indication => signals_i(7), command => signals_o(7), correspondence_S35 => state_S35, clock => clock, reset => reset);
	railwaySignal_T01 : railwaySignal_8 port map(R16_command => cmd_R16_T01, track_ne13 => tracks_i(5), indication => signals_i(8), command => signals_o(8), correspondence_T01 => state_T01, clock => clock, reset => reset);
	railwaySignal_T02 : railwaySignal_9 port map(R1_command => cmd_R1_T02, track_ne13 => tracks_i(5), track_ne2 => tracks_i(1), correspondence_P20 => state_P20, correspondence_L08 => state_L08, Sw06_state => state_Sw06, Lc08_state => state_Lc08, indication => signals_i(9), command => signals_o(9), correspondence_T02 => state_T02, clock => clock, reset => reset);
	railwaySignal_P20 : railwaySignal_10 port map(R9_command => cmd_R9_P20, R1_command => cmd_R1_P20, track_ne13 => tracks_i(5), track_ne2 => tracks_i(1), correspondence_L08 => state_L08, Sw06_state => state_Sw06, indication => signals_i(10), command => signals_o(10), correspondence_P20 => state_P20, clock => clock, reset => reset);
	railwaySignal_T03 : railwaySignal_11 port map(R7_command => cmd_R7_T03, track_ne14 => tracks_i(6), indication => signals_i(11), command => signals_o(11), correspondence_T03 => state_T03, clock => clock, reset => reset);
	railwaySignal_T04 : railwaySignal_12 port map(R2_command => cmd_R2_T04, track_ne14 => tracks_i(6), track_ne9 => tracks_i(3), track_ne1 => tracks_i(0), correspondence_X16 => state_X16, correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, Lc06_state => state_Lc06, indication => signals_i(12), command => signals_o(12), correspondence_T04 => state_T04, clock => clock, reset => reset);
	railwaySignal_X15 : railwaySignal_13 port map(R7_command => cmd_R7_X15, R12_command => cmd_R12_X15, track_ne14 => tracks_i(6), correspondence_T03 => state_T03, Lc06_state => state_Lc06, indication => signals_i(13), command => signals_o(13), correspondence_X15 => state_X15, clock => clock, reset => reset);
	railwaySignal_X16 : railwaySignal_14 port map(R8_command => cmd_R8_X16, R2_command => cmd_R2_X16, track_ne14 => tracks_i(6), track_ne9 => tracks_i(3), track_ne1 => tracks_i(0), correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, Lc06_state => state_Lc06, indication => signals_i(14), command => signals_o(14), correspondence_X16 => state_X16, clock => clock, reset => reset);
	railwaySignal_T05 : railwaySignal_15 port map(R13_command => cmd_R13_T05, track_ne15 => tracks_i(7), indication => signals_i(15), command => signals_o(15), correspondence_T05 => state_T05, clock => clock, reset => reset);
	railwaySignal_T06 : railwaySignal_16 port map(R3_command => cmd_R3_T06, track_ne15 => tracks_i(7), track_ne9 => tracks_i(3), track_ne1 => tracks_i(0), correspondence_C29 => state_C29, correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, indication => signals_i(16), command => signals_o(16), correspondence_T06 => state_T06, clock => clock, reset => reset);
	railwaySignal_C29 : railwaySignal_17 port map(R17_command => cmd_R17_C29, R3_command => cmd_R3_C29, track_ne15 => tracks_i(7), track_ne9 => tracks_i(3), track_ne1 => tracks_i(0), correspondence_L07 => state_L07, Sw04_state => state_Sw04, Sw07_state => state_Sw07, indication => signals_i(17), command => signals_o(17), correspondence_C29 => state_C29, clock => clock, reset => reset);
	railwaySignal_L09 : railwaySignal_18 port map(R4_command => cmd_R4_L09, track_ne22 => tracks_i(8), indication => signals_i(18), command => signals_o(18), correspondence_L09 => state_L09, clock => clock, reset => reset);
	railwaySignal_J11 : railwaySignal_19 port map(R4_command => cmd_R4_J11, R18_command => cmd_R18_J11, track_ne22 => tracks_i(8), correspondence_L09 => state_L09, indication => signals_i(19), command => signals_o(19), correspondence_J11 => state_J11, clock => clock, reset => reset);
	railwaySignal_J12 : railwaySignal_20 port map(R5_command => cmd_R5_J12, track_ne22 => tracks_i(8), track_ne8 => tracks_i(2), track_ne1 => tracks_i(0), correspondence_C21 => state_C21, correspondence_L07 => state_L07, Sw12_state => state_Sw12, Sw04_state => state_Sw04, indication => signals_i(20), command => signals_o(20), correspondence_J12 => state_J12, clock => clock, reset => reset);
	railwaySignal_J13 : railwaySignal_21 port map(R6_command => cmd_R6_J13, track_ne23 => tracks_i(9), track_ne12 => tracks_i(4), track_ne2 => tracks_i(1), correspondence_C25 => state_C25, correspondence_L08 => state_L08, Sw13_state => state_Sw13, Sw06_state => state_Sw06, indication => signals_i(21), command => signals_o(21), correspondence_J13 => state_J13, clock => clock, reset => reset);
	railwaySignal_J14 : railwaySignal_22 port map(R20_command => cmd_R20_J14, track_ne23 => tracks_i(9), indication => signals_i(22), command => signals_o(22), correspondence_J14 => state_J14, clock => clock, reset => reset);
	node_ne1 : node_0 port map(track_i => tracks_i(0), track_o => state_ne1, R8_command => cmd_R8_ne1, R10_command => cmd_R10_ne1, R11_command => cmd_R11_ne1, R12_command => cmd_R12_ne1, R13_command => cmd_R13_ne1, R17_command => cmd_R17_ne1, reset => reset);
	node_ne2 : node_1 port map(track_i => tracks_i(1), track_o => state_ne2, R9_command => cmd_R9_ne2, R14_command => cmd_R14_ne2, R15_command => cmd_R15_ne2, R16_command => cmd_R16_ne2, reset => reset);
	node_ne8 : node_2 port map(track_i => tracks_i(2), track_o => state_ne8, R5_command => cmd_R5_ne8, R10_command => cmd_R10_ne8, R11_command => cmd_R11_ne8, R18_command => cmd_R18_ne8, R19_command => cmd_R19_ne8, R21_command => cmd_R21_ne8, reset => reset);
	node_ne9 : node_3 port map(track_i => tracks_i(3), track_o => state_ne9, R8_command => cmd_R8_ne9, R12_command => cmd_R12_ne9, R13_command => cmd_R13_ne9, R17_command => cmd_R17_ne9, reset => reset);
	node_ne12 : node_4 port map(track_i => tracks_i(4), track_o => state_ne12, R6_command => cmd_R6_ne12, R14_command => cmd_R14_ne12, R15_command => cmd_R15_ne12, R19_command => cmd_R19_ne12, R20_command => cmd_R20_ne12, R21_command => cmd_R21_ne12, reset => reset);
	node_ne13 : node_5 port map(track_i => tracks_i(5), track_o => state_ne13, R1_command => cmd_R1_ne13, R9_command => cmd_R9_ne13, R16_command => cmd_R16_ne13, reset => reset);
	node_ne14 : node_6 port map(track_i => tracks_i(6), track_o => state_ne14, R2_command => cmd_R2_ne14, R7_command => cmd_R7_ne14, R8_command => cmd_R8_ne14, R12_command => cmd_R12_ne14, reset => reset);
	node_ne15 : node_7 port map(track_i => tracks_i(7), track_o => state_ne15, R3_command => cmd_R3_ne15, R13_command => cmd_R13_ne15, R17_command => cmd_R17_ne15, reset => reset);
	node_ne22 : node_8 port map(track_i => tracks_i(8), track_o => state_ne22, R4_command => cmd_R4_ne22, R5_command => cmd_R5_ne22, R18_command => cmd_R18_ne22, reset => reset);
	node_ne23 : node_9 port map(track_i => tracks_i(9), track_o => state_ne23, R6_command => cmd_R6_ne23, R20_command => cmd_R20_ne23, reset => reset);
	node_ne24 : node_10 port map(track_i => tracks_i(10), track_o => state_ne24, R19_command => cmd_R19_ne24, R21_command => cmd_R21_ne24, reset => reset);
	route_R1 : route_0 port map(routeRequest => routes_i(0), ne13_command => cmd_R1_ne13, track_ne13 => state_ne13, Lc08_command => cmd_R1_Lc08, Lc08_state => state_Lc08, Sw06_command => cmd_R1_Sw06, Sw06_state => state_Sw06, T02_state => state_T02, T02_command => cmd_R1_T02, P20_state => state_P20, P20_command =>cmd_R1_P20, routeExecute => routes_o(0), clock => clock, reset => reset);
	route_R2 : route_1 port map(routeRequest => routes_i(1), ne14_command => cmd_R2_ne14, track_ne14 => state_ne14, Lc06_command => cmd_R2_Lc06, Lc06_state => state_Lc06, Sw04_command => cmd_R2_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R2_Sw07, Sw07_state => state_Sw07, T04_state => state_T04, T04_command => cmd_R2_T04, X16_state => state_X16, X16_command =>cmd_R2_X16, routeExecute => routes_o(1), clock => clock, reset => reset);
	route_R3 : route_2 port map(routeRequest => routes_i(2), ne15_command => cmd_R3_ne15, track_ne15 => state_ne15, Sw04_command => cmd_R3_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R3_Sw07, Sw07_state => state_Sw07, T06_state => state_T06, T06_command => cmd_R3_T06, C29_state => state_C29, C29_command =>cmd_R3_C29, routeExecute => routes_o(2), clock => clock, reset => reset);
	route_R4 : route_3 port map(routeRequest => routes_i(3), ne22_command => cmd_R4_ne22, track_ne22 => state_ne22, J11_state => state_J11, J11_command => cmd_R4_J11, L09_state => state_L09, L09_command =>cmd_R4_L09, routeExecute => routes_o(3), clock => clock, reset => reset);
	route_R5 : route_4 port map(routeRequest => routes_i(4), ne8_command => cmd_R5_ne8, track_ne8 => state_ne8, ne22_command => cmd_R5_ne22, track_ne22 => state_ne22, Sw04_command => cmd_R5_Sw04, Sw04_state => state_Sw04, Sw12_command => cmd_R5_Sw12, Sw12_state => state_Sw12, J12_state => state_J12, J12_command => cmd_R5_J12, C21_state => state_C21, C21_command =>cmd_R5_C21, routeExecute => routes_o(4), clock => clock, reset => reset);
	route_R6 : route_5 port map(routeRequest => routes_i(5), ne12_command => cmd_R6_ne12, track_ne12 => state_ne12, ne23_command => cmd_R6_ne23, track_ne23 => state_ne23, Sw06_command => cmd_R6_Sw06, Sw06_state => state_Sw06, Sw13_command => cmd_R6_Sw13, Sw13_state => state_Sw13, J13_state => state_J13, J13_command => cmd_R6_J13, C25_state => state_C25, C25_command =>cmd_R6_C25, routeExecute => routes_o(5), clock => clock, reset => reset);
	route_R7 : route_6 port map(routeRequest => routes_i(6), ne14_command => cmd_R7_ne14, track_ne14 => state_ne14, Lc06_command => cmd_R7_Lc06, Lc06_state => state_Lc06, X15_state => state_X15, X15_command => cmd_R7_X15, T03_state => state_T03, T03_command =>cmd_R7_T03, routeExecute => routes_o(6), clock => clock, reset => reset);
	route_R8 : route_7 port map(routeRequest => routes_i(7), ne1_command => cmd_R8_ne1, track_ne1 => state_ne1, ne9_command => cmd_R8_ne9, track_ne9 => state_ne9, ne14_command => cmd_R8_ne14, track_ne14 => state_ne14, Lc06_command => cmd_R8_Lc06, Lc06_state => state_Lc06, Sw04_command => cmd_R8_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R8_Sw07, Sw07_state => state_Sw07, X16_state => state_X16, X16_command => cmd_R8_X16, L07_state => state_L07, L07_command =>cmd_R8_L07, routeExecute => routes_o(7), clock => clock, reset => reset);
	route_R9 : route_8 port map(routeRequest => routes_i(8), ne2_command => cmd_R9_ne2, track_ne2 => state_ne2, ne13_command => cmd_R9_ne13, track_ne13 => state_ne13, Sw06_command => cmd_R9_Sw06, Sw06_state => state_Sw06, P20_state => state_P20, P20_command => cmd_R9_P20, L08_state => state_L08, L08_command =>cmd_R9_L08, routeExecute => routes_o(8), clock => clock, reset => reset);
	route_R10 : route_9 port map(routeRequest => routes_i(9), ne1_command => cmd_R10_ne1, track_ne1 => state_ne1, ne8_command => cmd_R10_ne8, track_ne8 => state_ne8, Sw04_command => cmd_R10_Sw04, Sw04_state => state_Sw04, C21_state => state_C21, C21_command => cmd_R10_C21, L07_state => state_L07, L07_command =>cmd_R10_L07, routeExecute => routes_o(9), clock => clock, reset => reset);
	route_R11 : route_10 port map(routeRequest => routes_i(10), ne1_command => cmd_R11_ne1, track_ne1 => state_ne1, ne8_command => cmd_R11_ne8, track_ne8 => state_ne8, Sw04_command => cmd_R11_Sw04, Sw04_state => state_Sw04, Sw12_command => cmd_R11_Sw12, Sw12_state => state_Sw12, S22_state => state_S22, S22_command => cmd_R11_S22, S32_state => state_S32, S32_command =>cmd_R11_S32, routeExecute => routes_o(10), clock => clock, reset => reset);
	route_R12 : route_11 port map(routeRequest => routes_i(11), ne1_command => cmd_R12_ne1, track_ne1 => state_ne1, ne9_command => cmd_R12_ne9, track_ne9 => state_ne9, ne14_command => cmd_R12_ne14, track_ne14 => state_ne14, Lc06_command => cmd_R12_Lc06, Lc06_state => state_Lc06, Sw04_command => cmd_R12_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R12_Sw07, Sw07_state => state_Sw07, S22_state => state_S22, S22_command => cmd_R12_S22, X15_state => state_X15, X15_command =>cmd_R12_X15, routeExecute => routes_o(11), clock => clock, reset => reset);
	route_R13 : route_12 port map(routeRequest => routes_i(12), ne1_command => cmd_R13_ne1, track_ne1 => state_ne1, ne9_command => cmd_R13_ne9, track_ne9 => state_ne9, ne15_command => cmd_R13_ne15, track_ne15 => state_ne15, Sw04_command => cmd_R13_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R13_Sw07, Sw07_state => state_Sw07, S22_state => state_S22, S22_command => cmd_R13_S22, T05_state => state_T05, T05_command =>cmd_R13_T05, routeExecute => routes_o(12), clock => clock, reset => reset);
	route_R14 : route_13 port map(routeRequest => routes_i(13), ne2_command => cmd_R14_ne2, track_ne2 => state_ne2, ne12_command => cmd_R14_ne12, track_ne12 => state_ne12, Sw06_command => cmd_R14_Sw06, Sw06_state => state_Sw06, C25_state => state_C25, C25_command => cmd_R14_C25, L08_state => state_L08, L08_command =>cmd_R14_L08, routeExecute => routes_o(13), clock => clock, reset => reset);
	route_R15 : route_14 port map(routeRequest => routes_i(14), ne2_command => cmd_R15_ne2, track_ne2 => state_ne2, ne12_command => cmd_R15_ne12, track_ne12 => state_ne12, Sw06_command => cmd_R15_Sw06, Sw06_state => state_Sw06, Sw13_command => cmd_R15_Sw13, Sw13_state => state_Sw13, S27_state => state_S27, S27_command => cmd_R15_S27, S35_state => state_S35, S35_command =>cmd_R15_S35, routeExecute => routes_o(14), clock => clock, reset => reset);
	route_R16 : route_15 port map(routeRequest => routes_i(15), ne2_command => cmd_R16_ne2, track_ne2 => state_ne2, ne13_command => cmd_R16_ne13, track_ne13 => state_ne13, Lc08_command => cmd_R16_Lc08, Lc08_state => state_Lc08, Sw06_command => cmd_R16_Sw06, Sw06_state => state_Sw06, S27_state => state_S27, S27_command => cmd_R16_S27, T01_state => state_T01, T01_command =>cmd_R16_T01, routeExecute => routes_o(15), clock => clock, reset => reset);
	route_R17 : route_16 port map(routeRequest => routes_i(16), ne1_command => cmd_R17_ne1, track_ne1 => state_ne1, ne9_command => cmd_R17_ne9, track_ne9 => state_ne9, ne15_command => cmd_R17_ne15, track_ne15 => state_ne15, Sw04_command => cmd_R17_Sw04, Sw04_state => state_Sw04, Sw07_command => cmd_R17_Sw07, Sw07_state => state_Sw07, C29_state => state_C29, C29_command => cmd_R17_C29, L07_state => state_L07, L07_command =>cmd_R17_L07, routeExecute => routes_o(16), clock => clock, reset => reset);
	route_R18 : route_17 port map(routeRequest => routes_i(17), ne8_command => cmd_R18_ne8, track_ne8 => state_ne8, ne22_command => cmd_R18_ne22, track_ne22 => state_ne22, Sw12_command => cmd_R18_Sw12, Sw12_state => state_Sw12, S32_state => state_S32, S32_command => cmd_R18_S32, J11_state => state_J11, J11_command =>cmd_R18_J11, routeExecute => routes_o(17), clock => clock, reset => reset);
	route_R19 : route_18 port map(routeRequest => routes_i(18), ne8_command => cmd_R19_ne8, track_ne8 => state_ne8, ne12_command => cmd_R19_ne12, track_ne12 => state_ne12, ne24_command => cmd_R19_ne24, track_ne24 => state_ne24, Sw06_command => cmd_R19_Sw06, Sw06_state => state_Sw06, Sw12_command => cmd_R19_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R19_Sw13, Sw13_state => state_Sw13, S32_state => state_S32, S32_command => cmd_R19_S32, C25_state => state_C25, C25_command =>cmd_R19_C25, routeExecute => routes_o(18), clock => clock, reset => reset);
	route_R20 : route_19 port map(routeRequest => routes_i(19), ne12_command => cmd_R20_ne12, track_ne12 => state_ne12, ne23_command => cmd_R20_ne23, track_ne23 => state_ne23, Sw13_command => cmd_R20_Sw13, Sw13_state => state_Sw13, S35_state => state_S35, S35_command => cmd_R20_S35, J14_state => state_J14, J14_command =>cmd_R20_J14, routeExecute => routes_o(19), clock => clock, reset => reset);
	route_R21 : route_20 port map(routeRequest => routes_i(20), ne8_command => cmd_R21_ne8, track_ne8 => state_ne8, ne12_command => cmd_R21_ne12, track_ne12 => state_ne12, ne24_command => cmd_R21_ne24, track_ne24 => state_ne24, Sw04_command => cmd_R21_Sw04, Sw04_state => state_Sw04, Sw12_command => cmd_R21_Sw12, Sw12_state => state_Sw12, Sw13_command => cmd_R21_Sw13, Sw13_state => state_Sw13, S35_state => state_S35, S35_command => cmd_R21_S35, C21_state => state_C21, C21_command =>cmd_R21_C21, routeExecute => routes_o(20), clock => clock, reset => reset);
	processed <= processing;
	tracks_o(0) <= state_ne1;
	tracks_o(1) <= state_ne2;
	tracks_o(2) <= state_ne8;
	tracks_o(3) <= state_ne9;
	tracks_o(4) <= state_ne12;
	tracks_o(5) <= state_ne13;
	tracks_o(6) <= state_ne14;
	tracks_o(7) <= state_ne15;
	tracks_o(8) <= state_ne22;
	tracks_o(9) <= state_ne23;
	tracks_o(10) <= state_ne24;
end Behavioral;