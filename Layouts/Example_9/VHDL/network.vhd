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
			N_ROUTES : natural := 27;
			N_SIGNALS : natural := 25;
			N_LEVELCROSSINGS : natural := 3;
			N_SINGLESWITCHES : natural := 4;
			N : natural := 66
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
			track_ne46 : in hex_char;
			track_ne3 : in hex_char;
			track_ne40 : in hex_char;
			R12_command : in routeCommands;
			R18_command : in routeCommands;
			R24_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_0;
	component levelCrossing_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne49 : in hex_char;
			track_ne48 : in hex_char;
			track_ne53 : in hex_char;
			R3_command : in routeCommands;
			R9_command : in routeCommands;
			R19_command : in routeCommands;
			R25_command : in routeCommands;
			R21_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_1;
	component levelCrossing_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			track_ne50 : in hex_char;
			track_ne48 : in hex_char;
			track_ne53 : in hex_char;
			R5_command : in routeCommands;
			R11_command : in routeCommands;
			R26_command : in routeCommands;
			R22_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_2;
	component singleSwitch_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R8_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R19_command : in routeCommands := RELEASE;
			R23_command : in routeCommands := RELEASE;
			R24_command : in routeCommands := RELEASE;
			R25_command : in routeCommands := RELEASE;
			R26_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			R18_command : in routeCommands := RELEASE;
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
			R4_command : in routeCommands := RELEASE;
			R7_command : in routeCommands := RELEASE;
			R20_command : in routeCommands := RELEASE;
			R21_command : in routeCommands := RELEASE;
			R22_command : in routeCommands := RELEASE;
			R27_command : in routeCommands := RELEASE;
			R16_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R4_command : in routeCommands := RELEASE;
			R21_command : in routeCommands := RELEASE;
			R22_command : in routeCommands := RELEASE;
			R27_command : in routeCommands := RELEASE;
			R16_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
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
			R10_command : in routeCommands := RELEASE;
			R19_command : in routeCommands := RELEASE;
			R25_command : in routeCommands := RELEASE;
			R26_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			R5_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_3;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			--Ocupation level 0
			track_ne3 : in hex_char;
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
			track_ne3 : in hex_char;
			correspondence_T02 : out hex_char;
			correspondence_S42 : in hex_char;
			--Ocupation level 2
			track_ne49 : in hex_char;
			track_ne46 : in hex_char;
			track_ne50 : in hex_char;
			track_ne53 : in hex_char;
			correspondence_J16 : in hex_char;
			correspondence_J12 : in hex_char;
			correspondence_J14 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R13_command : in routeCommands;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R19_command : in routeCommands;
			R23_command : in routeCommands;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_J17 : out hex_char;
			correspondence_J21 : in hex_char;
			--Ocupation level 2
			correspondence_T01 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			R13_command : in routeCommands;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_J21 : out hex_char;
			correspondence_T01 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			R1_command : in routeCommands;
			Lc10_state : in hex_char;
			Lc11_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne3 : in hex_char;
			correspondence_S42 : out hex_char;
			--Ocupation level 1
			track_ne46 : in hex_char;
			track_ne53 : in hex_char;
			track_ne49 : in hex_char;
			track_ne50 : in hex_char;
			correspondence_J16 : in hex_char;
			correspondence_J12 : in hex_char;
			correspondence_J14 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			correspondence_J10 : in hex_char;
			correspondence_J06 : in hex_char;
			correspondence_B46 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R17_command : in routeCommands;
			--Ocupation level 0
			track_ne40 : in hex_char;
			correspondence_T03 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne40 : in hex_char;
			correspondence_T04 : out hex_char;
			correspondence_J25 : in hex_char;
			--Ocupation level 2
			correspondence_S36 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			R4_command : in routeCommands;
			R7_command : in routeCommands;
			R27_command : in routeCommands;
			--Ocupation level 0
			track_ne40 : in hex_char;
			correspondence_J24 : out hex_char;
			correspondence_J26 : in hex_char;
			--Ocupation level 2
			correspondence_T03 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R16_command : in routeCommands;
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne40 : in hex_char;
			correspondence_J25 : out hex_char;
			correspondence_S36 : in hex_char;
			--Ocupation level 2
			track_ne48 : in hex_char;
			track_ne46 : in hex_char;
			track_ne50 : in hex_char;
			track_ne49 : in hex_char;
			correspondence_J09 : in hex_char;
			correspondence_J05 : in hex_char;
			correspondence_J07 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R17_command : in routeCommands;
			R15_command : in routeCommands;
			--Ocupation level 0
			track_ne40 : in hex_char;
			correspondence_J26 : out hex_char;
			correspondence_T03 : in hex_char;
			--Ocupation level 2
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R16_command : in routeCommands;
			Lc11_state : in hex_char;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne40 : in hex_char;
			correspondence_S36 : out hex_char;
			--Ocupation level 1
			track_ne46 : in hex_char;
			track_ne48 : in hex_char;
			track_ne49 : in hex_char;
			track_ne50 : in hex_char;
			correspondence_J09 : in hex_char;
			correspondence_J05 : in hex_char;
			correspondence_J07 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			correspondence_X31 : in hex_char;
			correspondence_J11 : in hex_char;
			correspondence_J13 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			R20_command : in routeCommands;
			--Ocupation level 0
			track_ne46 : in hex_char;
			correspondence_J09 : out hex_char;
			correspondence_X31 : in hex_char;
			--Ocupation level 2
			correspondence_C41 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			--Ocupation level 0
			track_ne46 : in hex_char;
			correspondence_J10 : out hex_char;
			--Ocupation level 1
			track_ne40 : in hex_char;
			correspondence_J24 : in hex_char;
			Sw27_state : in hex_char;
			correspondence_J26 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R12_command : in routeCommands;
			R24_command : in routeCommands;
			Lc10_state : in hex_char;
			--Ocupation level 0
			track_ne46 : in hex_char;
			correspondence_J16 : out hex_char;
			correspondence_J10 : in hex_char;
			--Ocupation level 2
			track_ne40 : in hex_char;
			correspondence_J24 : in hex_char;
			Sw27_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R18_command : in routeCommands;
			R6_command : in routeCommands;
			Lc10_state : in hex_char;
			--Ocupation level 0
			track_ne46 : in hex_char;
			correspondence_X31 : out hex_char;
			correspondence_C41 : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R23_command : in routeCommands;
			R18_command : in routeCommands;
			--Ocupation level 0
			track_ne46 : in hex_char;
			correspondence_C41 : out hex_char;
			--Ocupation level 1
			track_ne3 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			correspondence_J21 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_15;
	component railwaySignal_16 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			R21_command : in routeCommands;
			Lc11_state : in hex_char;
			--Ocupation level 0
			track_ne49 : in hex_char;
			correspondence_J05 : out hex_char;
			correspondence_J11 : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			track_ne53 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_16;
	component railwaySignal_17 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R9_command : in routeCommands;
			--Ocupation level 0
			track_ne49 : in hex_char;
			correspondence_J06 : out hex_char;
			--Ocupation level 1
			track_ne48 : in hex_char;
			track_ne40 : in hex_char;
			correspondence_J24 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			correspondence_J26 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_17;
	component railwaySignal_18 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R8_command : in routeCommands;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne49 : in hex_char;
			correspondence_J11 : out hex_char;
			--Ocupation level 1
			track_ne53 : in hex_char;
			track_ne3 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			correspondence_J21 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_18;
	component railwaySignal_19 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R25_command : in routeCommands;
			Lc11_state : in hex_char;
			--Ocupation level 0
			track_ne49 : in hex_char;
			correspondence_J12 : out hex_char;
			correspondence_J06 : in hex_char;
			--Ocupation level 2
			track_ne48 : in hex_char;
			track_ne40 : in hex_char;
			correspondence_J24 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_19;
	component railwaySignal_20 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R19_command : in routeCommands;
			Lc11_state : in hex_char;
			--Ocupation level 0
			track_ne49 : in hex_char;
			correspondence_X33 : out hex_char;
			--Ocupation level 1
			track_ne53 : in hex_char;
			track_ne3 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			correspondence_J21 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_20;
	component railwaySignal_21 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R22_command : in routeCommands;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne50 : in hex_char;
			correspondence_J07 : out hex_char;
			correspondence_J13 : in hex_char;
			--Ocupation level 2
			track_ne3 : in hex_char;
			track_ne53 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_21;
	component railwaySignal_22 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne50 : in hex_char;
			correspondence_J13 : out hex_char;
			--Ocupation level 1
			track_ne53 : in hex_char;
			track_ne3 : in hex_char;
			correspondence_J17 : in hex_char;
			Sw31_state : in hex_char;
			Sw33_state : in hex_char;
			correspondence_J21 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_22;
	component railwaySignal_23 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R26_command : in routeCommands;
			Lc09_state : in hex_char;
			--Ocupation level 0
			track_ne50 : in hex_char;
			correspondence_J14 : out hex_char;
			correspondence_B46 : in hex_char;
			--Ocupation level 2
			track_ne48 : in hex_char;
			track_ne40 : in hex_char;
			correspondence_J24 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_23;
	component railwaySignal_24 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R27_command : in routeCommands;
			R11_command : in routeCommands;
			--Ocupation level 0
			track_ne50 : in hex_char;
			correspondence_B46 : out hex_char;
			--Ocupation level 1
			track_ne48 : in hex_char;
			track_ne40 : in hex_char;
			correspondence_J24 : in hex_char;
			Sw27_state : in hex_char;
			Sw29_state : in hex_char;
			correspondence_J26 : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_24;
	component node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			R19_command : in routeCommands;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_0;
	component node_1 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
			R7_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			R17_command : in routeCommands;
			R20_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_1;
	component node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R12_command : in routeCommands;
			R18_command : in routeCommands;
			R20_command : in routeCommands;
			R23_command : in routeCommands;
			R24_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_2;
	component node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R4_command : in routeCommands;
			R21_command : in routeCommands;
			R22_command : in routeCommands;
			R27_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_3;
	component node_4 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R19_command : in routeCommands;
			R21_command : in routeCommands;
			R25_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_4;
	component node_5 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R10_command : in routeCommands;
			R11_command : in routeCommands;
			R22_command : in routeCommands;
			R26_command : in routeCommands;
			R27_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_5;
	component node_6 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R8_command : in routeCommands;
			R10_command : in routeCommands;
			R19_command : in routeCommands;
			R25_command : in routeCommands;
			R26_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_6;
--sw  R1 ['Sw31', 'Sw33'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 [] 
	component route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			S42_state : in hex_char;
			S42_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_0;
--sw  R2 [] 
--dw  R2 [] 
--sc  R2 [] 
--lc  R2 [] 
	component route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			J25_state : in hex_char;
			J25_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_1;
--sw  R3 ['Sw31', 'Sw33'] 
--dw  R3 [] 
--sc  R3 [] 
--lc  R3 ['Lc11'] 
	component route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			J05_state : in hex_char;
			J05_command : out routeCommands := RELEASE;
			J11_state : in hex_char;
			J11_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_2;
--sw  R4 ['Sw27', 'Sw29'] 
--dw  R4 [] 
--sc  R4 [] 
--lc  R4 [] 
	component route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			track_ne48 : in hex_char;
			ne48_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			J06_state : in hex_char;
			J06_command : out routeCommands := RELEASE;
			J24_state : in hex_char;
			J24_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_3;
--sw  R5 ['Sw31', 'Sw33'] 
--dw  R5 [] 
--sc  R5 [] 
--lc  R5 ['Lc09'] 
	component route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne50 : in hex_char;
			ne50_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			J07_state : in hex_char;
			J07_command : out routeCommands := RELEASE;
			J13_state : in hex_char;
			J13_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_4;
--sw  R6 [] 
--dw  R6 [] 
--sc  R6 [] 
--lc  R6 [] 
	component route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			J09_state : in hex_char;
			J09_command : out routeCommands := RELEASE;
			X31_state : in hex_char;
			X31_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_5;
--sw  R7 ['Sw27'] 
--dw  R7 [] 
--sc  R7 [] 
--lc  R7 [] 
	component route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			J10_state : in hex_char;
			J10_command : out routeCommands := RELEASE;
			J24_state : in hex_char;
			J24_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_6;
--sw  R8 ['Sw31', 'Sw33'] 
--dw  R8 [] 
--sc  R8 [] 
--lc  R8 [] 
	component route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			track_ne53 : in hex_char;
			ne53_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			J11_state : in hex_char;
			J11_command : out routeCommands := RELEASE;
			J17_state : in hex_char;
			J17_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_7;
--sw  R9 ['Sw27', 'Sw29'] 
--dw  R9 [] 
--sc  R9 [] 
--lc  R9 ['Lc11'] 
	component route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			J12_state : in hex_char;
			J12_command : out routeCommands := RELEASE;
			J06_state : in hex_char;
			J06_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_8;
--sw  R10 ['Sw31', 'Sw33'] 
--dw  R10 [] 
--sc  R10 [] 
--lc  R10 [] 
	component route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne50 : in hex_char;
			ne50_command : out routeCommands := RELEASE;
			track_ne53 : in hex_char;
			ne53_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			J13_state : in hex_char;
			J13_command : out routeCommands := RELEASE;
			J17_state : in hex_char;
			J17_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_9;
--sw  R11 ['Sw27', 'Sw29'] 
--dw  R11 [] 
--sc  R11 [] 
--lc  R11 ['Lc09'] 
	component route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne50 : in hex_char;
			ne50_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			J14_state : in hex_char;
			J14_command : out routeCommands := RELEASE;
			B46_state : in hex_char;
			B46_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_10;
--sw  R12 ['Sw27'] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 ['Lc10'] 
	component route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			Lc10_state : in hex_char;
			Lc10_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			J16_state : in hex_char;
			J16_command : out routeCommands := RELEASE;
			J10_state : in hex_char;
			J10_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_11;
--sw  R13 [] 
--dw  R13 [] 
--sc  R13 [] 
--lc  R13 [] 
	component route_12 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			J17_state : in hex_char;
			J17_command : out routeCommands := RELEASE;
			J21_state : in hex_char;
			J21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_12;
--sw  R14 [] 
--dw  R14 [] 
--sc  R14 [] 
--lc  R14 [] 
	component route_13 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			J21_state : in hex_char;
			J21_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_13;
--sw  R15 [] 
--dw  R15 [] 
--sc  R15 [] 
--lc  R15 [] 
	component route_14 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			J24_state : in hex_char;
			J24_command : out routeCommands := RELEASE;
			J26_state : in hex_char;
			J26_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_14;
--sw  R16 ['Sw27', 'Sw29'] 
--dw  R16 [] 
--sc  R16 [] 
--lc  R16 [] 
	component route_15 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			J25_state : in hex_char;
			J25_command : out routeCommands := RELEASE;
			S36_state : in hex_char;
			S36_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_15;
--sw  R17 [] 
--dw  R17 [] 
--sc  R17 [] 
--lc  R17 [] 
	component route_16 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			J26_state : in hex_char;
			J26_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_16;
--sw  R18 ['Sw31'] 
--dw  R18 [] 
--sc  R18 [] 
--lc  R18 ['Lc10'] 
	component route_17 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			Lc10_state : in hex_char;
			Lc10_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			X31_state : in hex_char;
			X31_command : out routeCommands := RELEASE;
			C41_state : in hex_char;
			C41_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_17;
--sw  R19 ['Sw31', 'Sw33'] 
--dw  R19 [] 
--sc  R19 [] 
--lc  R19 ['Lc11'] 
	component route_18 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			track_ne53 : in hex_char;
			ne53_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			X33_state : in hex_char;
			X33_command : out routeCommands := RELEASE;
			J17_state : in hex_char;
			J17_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_18;
--sw  R20 ['Sw27'] 
--dw  R20 [] 
--sc  R20 [] 
--lc  R20 [] 
	component route_19 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			S36_state : in hex_char;
			S36_command : out routeCommands := RELEASE;
			J09_state : in hex_char;
			J09_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_19;
--sw  R21 ['Sw27', 'Sw29'] 
--dw  R21 [] 
--sc  R21 [] 
--lc  R21 ['Lc11'] 
	component route_20 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne48 : in hex_char;
			ne48_command : out routeCommands := RELEASE;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			S36_state : in hex_char;
			S36_command : out routeCommands := RELEASE;
			J05_state : in hex_char;
			J05_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_20;
--sw  R22 ['Sw27', 'Sw29'] 
--dw  R22 [] 
--sc  R22 [] 
--lc  R22 ['Lc09'] 
	component route_21 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			track_ne48 : in hex_char;
			ne48_command : out routeCommands := RELEASE;
			track_ne50 : in hex_char;
			ne50_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			S36_state : in hex_char;
			S36_command : out routeCommands := RELEASE;
			J07_state : in hex_char;
			J07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_21;
--sw  R23 ['Sw31'] 
--dw  R23 [] 
--sc  R23 [] 
--lc  R23 [] 
	component route_22 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			C41_state : in hex_char;
			C41_command : out routeCommands := RELEASE;
			J17_state : in hex_char;
			J17_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_22;
--sw  R24 ['Sw31'] 
--dw  R24 [] 
--sc  R24 [] 
--lc  R24 ['Lc10'] 
	component route_23 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne46 : in hex_char;
			ne46_command : out routeCommands := RELEASE;
			Lc10_state : in hex_char;
			Lc10_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			S42_state : in hex_char;
			S42_command : out routeCommands := RELEASE;
			J16_state : in hex_char;
			J16_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_23;
--sw  R25 ['Sw31', 'Sw33'] 
--dw  R25 [] 
--sc  R25 [] 
--lc  R25 ['Lc11'] 
	component route_24 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne53 : in hex_char;
			ne53_command : out routeCommands := RELEASE;
			track_ne49 : in hex_char;
			ne49_command : out routeCommands := RELEASE;
			Lc11_state : in hex_char;
			Lc11_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			S42_state : in hex_char;
			S42_command : out routeCommands := RELEASE;
			J12_state : in hex_char;
			J12_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_24;
--sw  R26 ['Sw31', 'Sw33'] 
--dw  R26 [] 
--sc  R26 [] 
--lc  R26 ['Lc09'] 
	component route_25 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne3 : in hex_char;
			ne3_command : out routeCommands := RELEASE;
			track_ne53 : in hex_char;
			ne53_command : out routeCommands := RELEASE;
			track_ne50 : in hex_char;
			ne50_command : out routeCommands := RELEASE;
			Lc09_state : in hex_char;
			Lc09_command : out routeCommands := RELEASE;
			Sw31_state : in hex_char;
			Sw31_command : out routeCommands := RELEASE;
			Sw33_state : in hex_char;
			Sw33_command : out routeCommands := RELEASE;
			S42_state : in hex_char;
			S42_command : out routeCommands := RELEASE;
			J14_state : in hex_char;
			J14_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_25;
--sw  R27 ['Sw27', 'Sw29'] 
--dw  R27 [] 
--sc  R27 [] 
--lc  R27 [] 
	component route_26 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne50 : in hex_char;
			ne50_command : out routeCommands := RELEASE;
			track_ne48 : in hex_char;
			ne48_command : out routeCommands := RELEASE;
			track_ne40 : in hex_char;
			ne40_command : out routeCommands := RELEASE;
			Sw27_state : in hex_char;
			Sw27_command : out routeCommands := RELEASE;
			Sw29_state : in hex_char;
			Sw29_command : out routeCommands := RELEASE;
			B46_state : in hex_char;
			B46_command : out routeCommands := RELEASE;
			J24_state : in hex_char;
			J24_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_26;
	signal state_Lc10 , state_Lc11 , state_Lc09 : hex_char;
	signal state_Sw31 , state_Sw27 , state_Sw29 , state_Sw33 : hex_char;
	signal state_T01 , state_T02 , state_J17 , state_J21 , state_S42 , state_T03 , state_T04 , state_J24 , state_J25 , state_J26 , state_S36 , state_J09 , state_J10 , state_J16 , state_X31 , state_C41 , state_J05 , state_J06 , state_J11 , state_J12 , state_X33 , state_J07 , state_J13 , state_J14 , state_B46 : hex_char;
	signal cmd_R1_ne3 , cmd_R2_ne40 , cmd_R3_ne49 , cmd_R4_ne49 , cmd_R4_ne48 , cmd_R4_ne40 , cmd_R5_ne50 , cmd_R6_ne46 , cmd_R7_ne46 , cmd_R7_ne40 , cmd_R8_ne49 , cmd_R8_ne53 , cmd_R8_ne3 , cmd_R9_ne49 , cmd_R10_ne50 , cmd_R10_ne53 , cmd_R10_ne3 , cmd_R11_ne50 , cmd_R12_ne46 , cmd_R13_ne3 , cmd_R14_ne3 , cmd_R15_ne40 , cmd_R16_ne40 , cmd_R17_ne40 , cmd_R18_ne46 , cmd_R19_ne49 , cmd_R19_ne53 , cmd_R19_ne3 , cmd_R20_ne40 , cmd_R20_ne46 , cmd_R21_ne40 , cmd_R21_ne48 , cmd_R21_ne49 , cmd_R22_ne40 , cmd_R22_ne48 , cmd_R22_ne50 , cmd_R23_ne46 , cmd_R23_ne3 , cmd_R24_ne3 , cmd_R24_ne46 , cmd_R25_ne3 , cmd_R25_ne53 , cmd_R25_ne49 , cmd_R26_ne3 , cmd_R26_ne53 , cmd_R26_ne50 , cmd_R27_ne50 , cmd_R27_ne48 , cmd_R27_ne40 : routeCommands := RELEASE;
	signal state_ne3 , state_ne40 , state_ne46 , state_ne48 , state_ne49 , state_ne50 , state_ne53 : hex_char;
	signal cmd_R12_Lc10 , cmd_R18_Lc10 , cmd_R24_Lc10 , cmd_R3_Lc11 , cmd_R9_Lc11 , cmd_R19_Lc11 , cmd_R25_Lc11 , cmd_R21_Lc11 , cmd_R5_Lc09 , cmd_R11_Lc09 , cmd_R26_Lc09 , cmd_R22_Lc09 : routeCommands := RELEASE;
	signal cmd_R8_Sw31 , cmd_R10_Sw31 , cmd_R19_Sw31 , cmd_R23_Sw31 , cmd_R24_Sw31 , cmd_R25_Sw31 , cmd_R26_Sw31 , cmd_R1_Sw31 , cmd_R18_Sw31 , cmd_R3_Sw31 , cmd_R5_Sw31 , cmd_R4_Sw27 , cmd_R7_Sw27 , cmd_R20_Sw27 , cmd_R21_Sw27 , cmd_R22_Sw27 , cmd_R27_Sw27 , cmd_R16_Sw27 , cmd_R12_Sw27 , cmd_R9_Sw27 , cmd_R11_Sw27 , cmd_R4_Sw29 , cmd_R21_Sw29 , cmd_R22_Sw29 , cmd_R27_Sw29 , cmd_R16_Sw29 , cmd_R9_Sw29 , cmd_R11_Sw29 , cmd_R8_Sw33 , cmd_R10_Sw33 , cmd_R19_Sw33 , cmd_R25_Sw33 , cmd_R26_Sw33 , cmd_R1_Sw33 , cmd_R3_Sw33 , cmd_R5_Sw33 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_T04 , cmd_R3_J05 , cmd_R4_J06 , cmd_R5_J07 , cmd_R6_J09 , cmd_R7_J10 , cmd_R8_J11 , cmd_R9_J12 , cmd_R10_J13 , cmd_R11_J14 , cmd_R12_J16 , cmd_R13_J17 , cmd_R14_J21 , cmd_R15_J24 , cmd_R16_J25 , cmd_R17_J26 , cmd_R18_X31 , cmd_R19_X33 , cmd_R20_S36 , cmd_R21_S36 , cmd_R22_S36 , cmd_R23_C41 , cmd_R24_S42 , cmd_R25_S42 , cmd_R26_S42 , cmd_R27_B46 : routeCommands := RELEASE;
	signal cmd_R1_S42 , cmd_R2_J25 , cmd_R3_J11 , cmd_R4_J24 , cmd_R5_J13 , cmd_R6_X31 , cmd_R7_J24 , cmd_R8_J17 , cmd_R9_J06 , cmd_R10_J17 , cmd_R11_B46 , cmd_R12_J10 , cmd_R13_J21 , cmd_R14_T01 , cmd_R15_J26 , cmd_R16_S36 , cmd_R17_T03 , cmd_R18_C41 , cmd_R19_J17 , cmd_R20_J09 , cmd_R21_J05 , cmd_R22_J07 , cmd_R23_J17 , cmd_R24_J16 , cmd_R25_J12 , cmd_R26_J14 , cmd_R27_J24 : routeCommands := RELEASE;
begin
	levelCrossing_Lc10 : levelCrossing_0 port map(track_ne46 => tracks_i(2), track_ne3 => tracks_i(0), track_ne40 => tracks_i(1), R12_command => cmd_R12_Lc10, R18_command => cmd_R18_Lc10, R24_command => cmd_R24_Lc10, indication => levelCrossings_i(0), command  => levelCrossings_o(0), correspondence => state_Lc10, clock => clock, reset => reset);
	levelCrossing_Lc11 : levelCrossing_1 port map(track_ne49 => tracks_i(4), track_ne48 => tracks_i(3), track_ne53 => tracks_i(6), R3_command => cmd_R3_Lc11, R9_command => cmd_R9_Lc11, R19_command => cmd_R19_Lc11, R25_command => cmd_R25_Lc11, R21_command => cmd_R21_Lc11, indication => levelCrossings_i(1), command  => levelCrossings_o(1), correspondence => state_Lc11, clock => clock, reset => reset);
	levelCrossing_Lc09 : levelCrossing_2 port map(track_ne50 => tracks_i(5), track_ne48 => tracks_i(3), track_ne53 => tracks_i(6), R5_command => cmd_R5_Lc09, R11_command => cmd_R11_Lc09, R26_command => cmd_R26_Lc09, R22_command => cmd_R22_Lc09, indication => levelCrossings_i(2), command  => levelCrossings_o(2), correspondence => state_Lc09, clock => clock, reset => reset);
	singleSwitch_Sw31 : singleSwitch_0 port map(R8_command => cmd_R8_Sw31, R10_command => cmd_R10_Sw31, R19_command => cmd_R19_Sw31, R23_command => cmd_R23_Sw31, R24_command => cmd_R24_Sw31, R25_command => cmd_R25_Sw31, R26_command => cmd_R26_Sw31, R1_command => cmd_R1_Sw31, R18_command => cmd_R18_Sw31, R3_command => cmd_R3_Sw31, R5_command => cmd_R5_Sw31, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence => state_Sw31, clock => clock, reset => reset);
	singleSwitch_Sw27 : singleSwitch_1 port map(R4_command => cmd_R4_Sw27, R7_command => cmd_R7_Sw27, R20_command => cmd_R20_Sw27, R21_command => cmd_R21_Sw27, R22_command => cmd_R22_Sw27, R27_command => cmd_R27_Sw27, R16_command => cmd_R16_Sw27, R12_command => cmd_R12_Sw27, R9_command => cmd_R9_Sw27, R11_command => cmd_R11_Sw27, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence => state_Sw27, clock => clock, reset => reset);
	singleSwitch_Sw29 : singleSwitch_2 port map(R4_command => cmd_R4_Sw29, R21_command => cmd_R21_Sw29, R22_command => cmd_R22_Sw29, R27_command => cmd_R27_Sw29, R16_command => cmd_R16_Sw29, R9_command => cmd_R9_Sw29, R11_command => cmd_R11_Sw29, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence => state_Sw29, clock => clock, reset => reset);
	singleSwitch_Sw33 : singleSwitch_3 port map(R8_command => cmd_R8_Sw33, R10_command => cmd_R10_Sw33, R19_command => cmd_R19_Sw33, R25_command => cmd_R25_Sw33, R26_command => cmd_R26_Sw33, R1_command => cmd_R1_Sw33, R3_command => cmd_R3_Sw33, R5_command => cmd_R5_Sw33, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence => state_Sw33, clock => clock, reset => reset);
	railwaySignal_T01 : railwaySignal_0 port map(R14_command => cmd_R14_T01, track_ne3 => tracks_i(0), indication => signals_i(0), command => signals_o(0), correspondence_T01 => state_T01, clock => clock, reset => reset);
	railwaySignal_T02 : railwaySignal_1 port map(R1_command => cmd_R1_T02, track_ne3 => tracks_i(0), track_ne49 => tracks_i(4), track_ne46 => tracks_i(2), track_ne50 => tracks_i(5), track_ne53 => tracks_i(6), correspondence_S42 => state_S42, correspondence_J16 => state_J16, correspondence_J12 => state_J12, correspondence_J14 => state_J14, Sw31_state => state_Sw31, Sw33_state => state_Sw33, indication => signals_i(1), command => signals_o(1), correspondence_T02 => state_T02, clock => clock, reset => reset);
	railwaySignal_J17 : railwaySignal_2 port map(R13_command => cmd_R13_J17, R8_command => cmd_R8_J17, R10_command => cmd_R10_J17, R19_command => cmd_R19_J17, R23_command => cmd_R23_J17, track_ne3 => tracks_i(0), correspondence_J21 => state_J21, correspondence_T01 => state_T01, indication => signals_i(2), command => signals_o(2), correspondence_J17 => state_J17, clock => clock, reset => reset);
	railwaySignal_J21 : railwaySignal_3 port map(R14_command => cmd_R14_J21, R13_command => cmd_R13_J21, track_ne3 => tracks_i(0), correspondence_T01 => state_T01, indication => signals_i(3), command => signals_o(3), correspondence_J21 => state_J21, clock => clock, reset => reset);
	railwaySignal_S42 : railwaySignal_4 port map(R24_command => cmd_R24_S42, R25_command => cmd_R25_S42, R26_command => cmd_R26_S42, R1_command => cmd_R1_S42, track_ne3 => tracks_i(0), track_ne46 => tracks_i(2), track_ne53 => tracks_i(6), track_ne49 => tracks_i(4), track_ne50 => tracks_i(5), correspondence_J16 => state_J16, correspondence_J12 => state_J12, correspondence_J14 => state_J14, correspondence_J10 => state_J10, correspondence_J06 => state_J06, correspondence_B46 => state_B46, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc10_state => state_Lc10, Lc11_state => state_Lc11, Lc09_state => state_Lc09, indication => signals_i(4), command => signals_o(4), correspondence_S42 => state_S42, clock => clock, reset => reset);
	railwaySignal_T03 : railwaySignal_5 port map(R17_command => cmd_R17_T03, track_ne40 => tracks_i(1), indication => signals_i(5), command => signals_o(5), correspondence_T03 => state_T03, clock => clock, reset => reset);
	railwaySignal_T04 : railwaySignal_6 port map(R2_command => cmd_R2_T04, track_ne40 => tracks_i(1), correspondence_J25 => state_J25, correspondence_S36 => state_S36, indication => signals_i(6), command => signals_o(6), correspondence_T04 => state_T04, clock => clock, reset => reset);
	railwaySignal_J24 : railwaySignal_7 port map(R15_command => cmd_R15_J24, R4_command => cmd_R4_J24, R7_command => cmd_R7_J24, R27_command => cmd_R27_J24, track_ne40 => tracks_i(1), correspondence_J26 => state_J26, correspondence_T03 => state_T03, indication => signals_i(7), command => signals_o(7), correspondence_J24 => state_J24, clock => clock, reset => reset);
	railwaySignal_J25 : railwaySignal_8 port map(R16_command => cmd_R16_J25, R2_command => cmd_R2_J25, track_ne40 => tracks_i(1), track_ne48 => tracks_i(3), track_ne46 => tracks_i(2), track_ne50 => tracks_i(5), track_ne49 => tracks_i(4), correspondence_S36 => state_S36, correspondence_J09 => state_J09, correspondence_J05 => state_J05, correspondence_J07 => state_J07, Sw27_state => state_Sw27, Sw29_state => state_Sw29, indication => signals_i(8), command => signals_o(8), correspondence_J25 => state_J25, clock => clock, reset => reset);
	railwaySignal_J26 : railwaySignal_9 port map(R17_command => cmd_R17_J26, R15_command => cmd_R15_J26, track_ne40 => tracks_i(1), correspondence_T03 => state_T03, indication => signals_i(9), command => signals_o(9), correspondence_J26 => state_J26, clock => clock, reset => reset);
	railwaySignal_S36 : railwaySignal_10 port map(R20_command => cmd_R20_S36, R21_command => cmd_R21_S36, R22_command => cmd_R22_S36, R16_command => cmd_R16_S36, track_ne40 => tracks_i(1), track_ne46 => tracks_i(2), track_ne48 => tracks_i(3), track_ne49 => tracks_i(4), track_ne50 => tracks_i(5), correspondence_J09 => state_J09, correspondence_J05 => state_J05, correspondence_J07 => state_J07, correspondence_X31 => state_X31, correspondence_J11 => state_J11, correspondence_J13 => state_J13, Sw27_state => state_Sw27, Sw29_state => state_Sw29, Lc11_state => state_Lc11, Lc09_state => state_Lc09, indication => signals_i(10), command => signals_o(10), correspondence_S36 => state_S36, clock => clock, reset => reset);
	railwaySignal_J09 : railwaySignal_11 port map(R6_command => cmd_R6_J09, R20_command => cmd_R20_J09, track_ne46 => tracks_i(2), correspondence_X31 => state_X31, correspondence_C41 => state_C41, indication => signals_i(11), command => signals_o(11), correspondence_J09 => state_J09, clock => clock, reset => reset);
	railwaySignal_J10 : railwaySignal_12 port map(R7_command => cmd_R7_J10, R12_command => cmd_R12_J10, track_ne46 => tracks_i(2), track_ne40 => tracks_i(1), correspondence_J24 => state_J24, correspondence_J26 => state_J26, Sw27_state => state_Sw27, indication => signals_i(12), command => signals_o(12), correspondence_J10 => state_J10, clock => clock, reset => reset);
	railwaySignal_J16 : railwaySignal_13 port map(R12_command => cmd_R12_J16, R24_command => cmd_R24_J16, track_ne46 => tracks_i(2), track_ne40 => tracks_i(1), correspondence_J10 => state_J10, correspondence_J24 => state_J24, Sw27_state => state_Sw27, Lc10_state => state_Lc10, indication => signals_i(13), command => signals_o(13), correspondence_J16 => state_J16, clock => clock, reset => reset);
	railwaySignal_X31 : railwaySignal_14 port map(R18_command => cmd_R18_X31, R6_command => cmd_R6_X31, track_ne46 => tracks_i(2), track_ne3 => tracks_i(0), correspondence_C41 => state_C41, correspondence_J17 => state_J17, Sw31_state => state_Sw31, Lc10_state => state_Lc10, indication => signals_i(14), command => signals_o(14), correspondence_X31 => state_X31, clock => clock, reset => reset);
	railwaySignal_C41 : railwaySignal_15 port map(R23_command => cmd_R23_C41, R18_command => cmd_R18_C41, track_ne46 => tracks_i(2), track_ne3 => tracks_i(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, indication => signals_i(15), command => signals_o(15), correspondence_C41 => state_C41, clock => clock, reset => reset);
	railwaySignal_J05 : railwaySignal_16 port map(R3_command => cmd_R3_J05, R21_command => cmd_R21_J05, track_ne49 => tracks_i(4), track_ne3 => tracks_i(0), track_ne53 => tracks_i(6), correspondence_J11 => state_J11, correspondence_J17 => state_J17, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc11_state => state_Lc11, indication => signals_i(16), command => signals_o(16), correspondence_J05 => state_J05, clock => clock, reset => reset);
	railwaySignal_J06 : railwaySignal_17 port map(R4_command => cmd_R4_J06, R9_command => cmd_R9_J06, track_ne49 => tracks_i(4), track_ne48 => tracks_i(3), track_ne40 => tracks_i(1), correspondence_J24 => state_J24, correspondence_J26 => state_J26, Sw27_state => state_Sw27, Sw29_state => state_Sw29, indication => signals_i(17), command => signals_o(17), correspondence_J06 => state_J06, clock => clock, reset => reset);
	railwaySignal_J11 : railwaySignal_18 port map(R8_command => cmd_R8_J11, R3_command => cmd_R3_J11, track_ne49 => tracks_i(4), track_ne53 => tracks_i(6), track_ne3 => tracks_i(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, Sw33_state => state_Sw33, indication => signals_i(18), command => signals_o(18), correspondence_J11 => state_J11, clock => clock, reset => reset);
	railwaySignal_J12 : railwaySignal_19 port map(R9_command => cmd_R9_J12, R25_command => cmd_R25_J12, track_ne49 => tracks_i(4), track_ne48 => tracks_i(3), track_ne40 => tracks_i(1), correspondence_J06 => state_J06, correspondence_J24 => state_J24, Sw27_state => state_Sw27, Sw29_state => state_Sw29, Lc11_state => state_Lc11, indication => signals_i(19), command => signals_o(19), correspondence_J12 => state_J12, clock => clock, reset => reset);
	railwaySignal_X33 : railwaySignal_20 port map(R19_command => cmd_R19_X33, track_ne49 => tracks_i(4), track_ne53 => tracks_i(6), track_ne3 => tracks_i(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc11_state => state_Lc11, indication => signals_i(20), command => signals_o(20), correspondence_X33 => state_X33, clock => clock, reset => reset);
	railwaySignal_J07 : railwaySignal_21 port map(R5_command => cmd_R5_J07, R22_command => cmd_R22_J07, track_ne50 => tracks_i(5), track_ne3 => tracks_i(0), track_ne53 => tracks_i(6), correspondence_J13 => state_J13, correspondence_J17 => state_J17, Sw31_state => state_Sw31, Sw33_state => state_Sw33, Lc09_state => state_Lc09, indication => signals_i(21), command => signals_o(21), correspondence_J07 => state_J07, clock => clock, reset => reset);
	railwaySignal_J13 : railwaySignal_22 port map(R10_command => cmd_R10_J13, R5_command => cmd_R5_J13, track_ne50 => tracks_i(5), track_ne53 => tracks_i(6), track_ne3 => tracks_i(0), correspondence_J17 => state_J17, correspondence_J21 => state_J21, Sw31_state => state_Sw31, Sw33_state => state_Sw33, indication => signals_i(22), command => signals_o(22), correspondence_J13 => state_J13, clock => clock, reset => reset);
	railwaySignal_J14 : railwaySignal_23 port map(R11_command => cmd_R11_J14, R26_command => cmd_R26_J14, track_ne50 => tracks_i(5), track_ne48 => tracks_i(3), track_ne40 => tracks_i(1), correspondence_B46 => state_B46, correspondence_J24 => state_J24, Sw27_state => state_Sw27, Sw29_state => state_Sw29, Lc09_state => state_Lc09, indication => signals_i(23), command => signals_o(23), correspondence_J14 => state_J14, clock => clock, reset => reset);
	railwaySignal_B46 : railwaySignal_24 port map(R27_command => cmd_R27_B46, R11_command => cmd_R11_B46, track_ne50 => tracks_i(5), track_ne48 => tracks_i(3), track_ne40 => tracks_i(1), correspondence_J24 => state_J24, correspondence_J26 => state_J26, Sw27_state => state_Sw27, Sw29_state => state_Sw29, indication => signals_i(24), command => signals_o(24), correspondence_B46 => state_B46, clock => clock, reset => reset);
	node_ne3 : node_0 port map(track_i => tracks_i(0), track_o => state_ne3, R1_command => cmd_R1_ne3, R8_command => cmd_R8_ne3, R10_command => cmd_R10_ne3, R13_command => cmd_R13_ne3, R14_command => cmd_R14_ne3, R19_command => cmd_R19_ne3, R23_command => cmd_R23_ne3, R24_command => cmd_R24_ne3, R25_command => cmd_R25_ne3, R26_command => cmd_R26_ne3, reset => reset);
	node_ne40 : node_1 port map(track_i => tracks_i(1), track_o => state_ne40, R2_command => cmd_R2_ne40, R4_command => cmd_R4_ne40, R7_command => cmd_R7_ne40, R15_command => cmd_R15_ne40, R16_command => cmd_R16_ne40, R17_command => cmd_R17_ne40, R20_command => cmd_R20_ne40, R21_command => cmd_R21_ne40, R22_command => cmd_R22_ne40, R27_command => cmd_R27_ne40, reset => reset);
	node_ne46 : node_2 port map(track_i => tracks_i(2), track_o => state_ne46, R6_command => cmd_R6_ne46, R7_command => cmd_R7_ne46, R12_command => cmd_R12_ne46, R18_command => cmd_R18_ne46, R20_command => cmd_R20_ne46, R23_command => cmd_R23_ne46, R24_command => cmd_R24_ne46, reset => reset);
	node_ne48 : node_3 port map(track_i => tracks_i(3), track_o => state_ne48, R4_command => cmd_R4_ne48, R21_command => cmd_R21_ne48, R22_command => cmd_R22_ne48, R27_command => cmd_R27_ne48, reset => reset);
	node_ne49 : node_4 port map(track_i => tracks_i(4), track_o => state_ne49, R3_command => cmd_R3_ne49, R4_command => cmd_R4_ne49, R8_command => cmd_R8_ne49, R9_command => cmd_R9_ne49, R19_command => cmd_R19_ne49, R21_command => cmd_R21_ne49, R25_command => cmd_R25_ne49, reset => reset);
	node_ne50 : node_5 port map(track_i => tracks_i(5), track_o => state_ne50, R5_command => cmd_R5_ne50, R10_command => cmd_R10_ne50, R11_command => cmd_R11_ne50, R22_command => cmd_R22_ne50, R26_command => cmd_R26_ne50, R27_command => cmd_R27_ne50, reset => reset);
	node_ne53 : node_6 port map(track_i => tracks_i(6), track_o => state_ne53, R8_command => cmd_R8_ne53, R10_command => cmd_R10_ne53, R19_command => cmd_R19_ne53, R25_command => cmd_R25_ne53, R26_command => cmd_R26_ne53, reset => reset);
	route_R1 : route_0 port map(routeRequest => routes_i(0), ne3_command => cmd_R1_ne3, track_ne3 => state_ne3, Sw31_command => cmd_R1_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R1_Sw33, Sw33_state => state_Sw33, T02_state => state_T02, T02_command => cmd_R1_T02, S42_state => state_S42, S42_command =>cmd_R1_S42, routeExecute => routes_o(0), clock => clock, reset => reset);
	route_R2 : route_1 port map(routeRequest => routes_i(1), ne40_command => cmd_R2_ne40, track_ne40 => state_ne40, T04_state => state_T04, T04_command => cmd_R2_T04, J25_state => state_J25, J25_command =>cmd_R2_J25, routeExecute => routes_o(1), clock => clock, reset => reset);
	route_R3 : route_2 port map(routeRequest => routes_i(2), ne49_command => cmd_R3_ne49, track_ne49 => state_ne49, Lc11_command => cmd_R3_Lc11, Lc11_state => state_Lc11, Sw31_command => cmd_R3_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R3_Sw33, Sw33_state => state_Sw33, J05_state => state_J05, J05_command => cmd_R3_J05, J11_state => state_J11, J11_command =>cmd_R3_J11, routeExecute => routes_o(2), clock => clock, reset => reset);
	route_R4 : route_3 port map(routeRequest => routes_i(3), ne40_command => cmd_R4_ne40, track_ne40 => state_ne40, ne48_command => cmd_R4_ne48, track_ne48 => state_ne48, ne49_command => cmd_R4_ne49, track_ne49 => state_ne49, Sw27_command => cmd_R4_Sw27, Sw27_state => state_Sw27, Sw29_command => cmd_R4_Sw29, Sw29_state => state_Sw29, J06_state => state_J06, J06_command => cmd_R4_J06, J24_state => state_J24, J24_command =>cmd_R4_J24, routeExecute => routes_o(3), clock => clock, reset => reset);
	route_R5 : route_4 port map(routeRequest => routes_i(4), ne50_command => cmd_R5_ne50, track_ne50 => state_ne50, Lc09_command => cmd_R5_Lc09, Lc09_state => state_Lc09, Sw31_command => cmd_R5_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R5_Sw33, Sw33_state => state_Sw33, J07_state => state_J07, J07_command => cmd_R5_J07, J13_state => state_J13, J13_command =>cmd_R5_J13, routeExecute => routes_o(4), clock => clock, reset => reset);
	route_R6 : route_5 port map(routeRequest => routes_i(5), ne46_command => cmd_R6_ne46, track_ne46 => state_ne46, J09_state => state_J09, J09_command => cmd_R6_J09, X31_state => state_X31, X31_command =>cmd_R6_X31, routeExecute => routes_o(5), clock => clock, reset => reset);
	route_R7 : route_6 port map(routeRequest => routes_i(6), ne40_command => cmd_R7_ne40, track_ne40 => state_ne40, ne46_command => cmd_R7_ne46, track_ne46 => state_ne46, Sw27_command => cmd_R7_Sw27, Sw27_state => state_Sw27, J10_state => state_J10, J10_command => cmd_R7_J10, J24_state => state_J24, J24_command =>cmd_R7_J24, routeExecute => routes_o(6), clock => clock, reset => reset);
	route_R8 : route_7 port map(routeRequest => routes_i(7), ne3_command => cmd_R8_ne3, track_ne3 => state_ne3, ne49_command => cmd_R8_ne49, track_ne49 => state_ne49, ne53_command => cmd_R8_ne53, track_ne53 => state_ne53, Sw31_command => cmd_R8_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R8_Sw33, Sw33_state => state_Sw33, J11_state => state_J11, J11_command => cmd_R8_J11, J17_state => state_J17, J17_command =>cmd_R8_J17, routeExecute => routes_o(7), clock => clock, reset => reset);
	route_R9 : route_8 port map(routeRequest => routes_i(8), ne49_command => cmd_R9_ne49, track_ne49 => state_ne49, Lc11_command => cmd_R9_Lc11, Lc11_state => state_Lc11, Sw27_command => cmd_R9_Sw27, Sw27_state => state_Sw27, Sw29_command => cmd_R9_Sw29, Sw29_state => state_Sw29, J12_state => state_J12, J12_command => cmd_R9_J12, J06_state => state_J06, J06_command =>cmd_R9_J06, routeExecute => routes_o(8), clock => clock, reset => reset);
	route_R10 : route_9 port map(routeRequest => routes_i(9), ne3_command => cmd_R10_ne3, track_ne3 => state_ne3, ne50_command => cmd_R10_ne50, track_ne50 => state_ne50, ne53_command => cmd_R10_ne53, track_ne53 => state_ne53, Sw31_command => cmd_R10_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R10_Sw33, Sw33_state => state_Sw33, J13_state => state_J13, J13_command => cmd_R10_J13, J17_state => state_J17, J17_command =>cmd_R10_J17, routeExecute => routes_o(9), clock => clock, reset => reset);
	route_R11 : route_10 port map(routeRequest => routes_i(10), ne50_command => cmd_R11_ne50, track_ne50 => state_ne50, Lc09_command => cmd_R11_Lc09, Lc09_state => state_Lc09, Sw27_command => cmd_R11_Sw27, Sw27_state => state_Sw27, Sw29_command => cmd_R11_Sw29, Sw29_state => state_Sw29, J14_state => state_J14, J14_command => cmd_R11_J14, B46_state => state_B46, B46_command =>cmd_R11_B46, routeExecute => routes_o(10), clock => clock, reset => reset);
	route_R12 : route_11 port map(routeRequest => routes_i(11), ne46_command => cmd_R12_ne46, track_ne46 => state_ne46, Lc10_command => cmd_R12_Lc10, Lc10_state => state_Lc10, Sw27_command => cmd_R12_Sw27, Sw27_state => state_Sw27, J16_state => state_J16, J16_command => cmd_R12_J16, J10_state => state_J10, J10_command =>cmd_R12_J10, routeExecute => routes_o(11), clock => clock, reset => reset);
	route_R13 : route_12 port map(routeRequest => routes_i(12), ne3_command => cmd_R13_ne3, track_ne3 => state_ne3, J17_state => state_J17, J17_command => cmd_R13_J17, J21_state => state_J21, J21_command =>cmd_R13_J21, routeExecute => routes_o(12), clock => clock, reset => reset);
	route_R14 : route_13 port map(routeRequest => routes_i(13), ne3_command => cmd_R14_ne3, track_ne3 => state_ne3, J21_state => state_J21, J21_command => cmd_R14_J21, T01_state => state_T01, T01_command =>cmd_R14_T01, routeExecute => routes_o(13), clock => clock, reset => reset);
	route_R15 : route_14 port map(routeRequest => routes_i(14), ne40_command => cmd_R15_ne40, track_ne40 => state_ne40, J24_state => state_J24, J24_command => cmd_R15_J24, J26_state => state_J26, J26_command =>cmd_R15_J26, routeExecute => routes_o(14), clock => clock, reset => reset);
	route_R16 : route_15 port map(routeRequest => routes_i(15), ne40_command => cmd_R16_ne40, track_ne40 => state_ne40, Sw27_command => cmd_R16_Sw27, Sw27_state => state_Sw27, Sw29_command => cmd_R16_Sw29, Sw29_state => state_Sw29, J25_state => state_J25, J25_command => cmd_R16_J25, S36_state => state_S36, S36_command =>cmd_R16_S36, routeExecute => routes_o(15), clock => clock, reset => reset);
	route_R17 : route_16 port map(routeRequest => routes_i(16), ne40_command => cmd_R17_ne40, track_ne40 => state_ne40, J26_state => state_J26, J26_command => cmd_R17_J26, T03_state => state_T03, T03_command =>cmd_R17_T03, routeExecute => routes_o(16), clock => clock, reset => reset);
	route_R18 : route_17 port map(routeRequest => routes_i(17), ne46_command => cmd_R18_ne46, track_ne46 => state_ne46, Lc10_command => cmd_R18_Lc10, Lc10_state => state_Lc10, Sw31_command => cmd_R18_Sw31, Sw31_state => state_Sw31, X31_state => state_X31, X31_command => cmd_R18_X31, C41_state => state_C41, C41_command =>cmd_R18_C41, routeExecute => routes_o(17), clock => clock, reset => reset);
	route_R19 : route_18 port map(routeRequest => routes_i(18), ne3_command => cmd_R19_ne3, track_ne3 => state_ne3, ne49_command => cmd_R19_ne49, track_ne49 => state_ne49, ne53_command => cmd_R19_ne53, track_ne53 => state_ne53, Lc11_command => cmd_R19_Lc11, Lc11_state => state_Lc11, Sw31_command => cmd_R19_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R19_Sw33, Sw33_state => state_Sw33, X33_state => state_X33, X33_command => cmd_R19_X33, J17_state => state_J17, J17_command =>cmd_R19_J17, routeExecute => routes_o(18), clock => clock, reset => reset);
	route_R20 : route_19 port map(routeRequest => routes_i(19), ne40_command => cmd_R20_ne40, track_ne40 => state_ne40, ne46_command => cmd_R20_ne46, track_ne46 => state_ne46, Sw27_command => cmd_R20_Sw27, Sw27_state => state_Sw27, S36_state => state_S36, S36_command => cmd_R20_S36, J09_state => state_J09, J09_command =>cmd_R20_J09, routeExecute => routes_o(19), clock => clock, reset => reset);
	route_R21 : route_20 port map(routeRequest => routes_i(20), ne40_command => cmd_R21_ne40, track_ne40 => state_ne40, ne48_command => cmd_R21_ne48, track_ne48 => state_ne48, ne49_command => cmd_R21_ne49, track_ne49 => state_ne49, Lc11_command => cmd_R21_Lc11, Lc11_state => state_Lc11, Sw27_command => cmd_R21_Sw27, Sw27_state => state_Sw27, Sw29_command => cmd_R21_Sw29, Sw29_state => state_Sw29, S36_state => state_S36, S36_command => cmd_R21_S36, J05_state => state_J05, J05_command =>cmd_R21_J05, routeExecute => routes_o(20), clock => clock, reset => reset);
	route_R22 : route_21 port map(routeRequest => routes_i(21), ne40_command => cmd_R22_ne40, track_ne40 => state_ne40, ne48_command => cmd_R22_ne48, track_ne48 => state_ne48, ne50_command => cmd_R22_ne50, track_ne50 => state_ne50, Lc09_command => cmd_R22_Lc09, Lc09_state => state_Lc09, Sw27_command => cmd_R22_Sw27, Sw27_state => state_Sw27, Sw29_command => cmd_R22_Sw29, Sw29_state => state_Sw29, S36_state => state_S36, S36_command => cmd_R22_S36, J07_state => state_J07, J07_command =>cmd_R22_J07, routeExecute => routes_o(21), clock => clock, reset => reset);
	route_R23 : route_22 port map(routeRequest => routes_i(22), ne3_command => cmd_R23_ne3, track_ne3 => state_ne3, ne46_command => cmd_R23_ne46, track_ne46 => state_ne46, Sw31_command => cmd_R23_Sw31, Sw31_state => state_Sw31, C41_state => state_C41, C41_command => cmd_R23_C41, J17_state => state_J17, J17_command =>cmd_R23_J17, routeExecute => routes_o(22), clock => clock, reset => reset);
	route_R24 : route_23 port map(routeRequest => routes_i(23), ne3_command => cmd_R24_ne3, track_ne3 => state_ne3, ne46_command => cmd_R24_ne46, track_ne46 => state_ne46, Lc10_command => cmd_R24_Lc10, Lc10_state => state_Lc10, Sw31_command => cmd_R24_Sw31, Sw31_state => state_Sw31, S42_state => state_S42, S42_command => cmd_R24_S42, J16_state => state_J16, J16_command =>cmd_R24_J16, routeExecute => routes_o(23), clock => clock, reset => reset);
	route_R25 : route_24 port map(routeRequest => routes_i(24), ne3_command => cmd_R25_ne3, track_ne3 => state_ne3, ne49_command => cmd_R25_ne49, track_ne49 => state_ne49, ne53_command => cmd_R25_ne53, track_ne53 => state_ne53, Lc11_command => cmd_R25_Lc11, Lc11_state => state_Lc11, Sw31_command => cmd_R25_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R25_Sw33, Sw33_state => state_Sw33, S42_state => state_S42, S42_command => cmd_R25_S42, J12_state => state_J12, J12_command =>cmd_R25_J12, routeExecute => routes_o(24), clock => clock, reset => reset);
	route_R26 : route_25 port map(routeRequest => routes_i(25), ne3_command => cmd_R26_ne3, track_ne3 => state_ne3, ne50_command => cmd_R26_ne50, track_ne50 => state_ne50, ne53_command => cmd_R26_ne53, track_ne53 => state_ne53, Lc09_command => cmd_R26_Lc09, Lc09_state => state_Lc09, Sw31_command => cmd_R26_Sw31, Sw31_state => state_Sw31, Sw33_command => cmd_R26_Sw33, Sw33_state => state_Sw33, S42_state => state_S42, S42_command => cmd_R26_S42, J14_state => state_J14, J14_command =>cmd_R26_J14, routeExecute => routes_o(25), clock => clock, reset => reset);
	route_R27 : route_26 port map(routeRequest => routes_i(26), ne40_command => cmd_R27_ne40, track_ne40 => state_ne40, ne48_command => cmd_R27_ne48, track_ne48 => state_ne48, ne50_command => cmd_R27_ne50, track_ne50 => state_ne50, Sw27_command => cmd_R27_Sw27, Sw27_state => state_Sw27, Sw29_command => cmd_R27_Sw29, Sw29_state => state_Sw29, B46_state => state_B46, B46_command => cmd_R27_B46, J24_state => state_J24, J24_command =>cmd_R27_J24, routeExecute => routes_o(26), clock => clock, reset => reset);
	processed <= processing;
	tracks_o(0) <= state_ne3;
	tracks_o(1) <= state_ne40;
	tracks_o(2) <= state_ne46;
	tracks_o(3) <= state_ne48;
	tracks_o(4) <= state_ne49;
	tracks_o(5) <= state_ne50;
	tracks_o(6) <= state_ne53;
end Behavioral;