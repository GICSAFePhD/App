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
			N_ROUTES : natural := 10;
			N_SIGNALS : natural := 12;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 3;
			N : natural := 33
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
			levelCrossings_i : in hex_char;
			levelCrossings_o : out hex_char;
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
			track_ne16 : in hex_char;
			track_ne14 : in hex_char;
			track_ne15 : in hex_char;
			track_ne18 : in hex_char;
			track_ne17 : in hex_char;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component levelCrossing_0;
	component singleSwitch_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R2_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			R4_command : in routeCommands := RELEASE;
			R5_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
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
			R6_command : in routeCommands := RELEASE;
			R7_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			R2_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_1;
	component singleSwitch_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R1_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_2;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne14 : in hex_char;
			correspondence_P09 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_0;
	component railwaySignal_1 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne14 : in hex_char;
			correspondence_C13 : out hex_char;
			--Ocupation level 1
			track_ne16 : in hex_char;
			correspondence_S18 : in hex_char;
			Sw01_state : in hex_char;
			--Ocupation level 2
			track_ne20 : in hex_char;
			track_ne17 : in hex_char;
			track_ne18 : in hex_char;
			correspondence_P12 : in hex_char;
			correspondence_L06 : in hex_char;
			Sw02_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne15 : in hex_char;
			correspondence_L04 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne15 : in hex_char;
			correspondence_B14 : out hex_char;
			--Ocupation level 1
			track_ne16 : in hex_char;
			correspondence_S18 : in hex_char;
			Sw01_state : in hex_char;
			--Ocupation level 2
			track_ne20 : in hex_char;
			track_ne17 : in hex_char;
			track_ne18 : in hex_char;
			correspondence_P12 : in hex_char;
			correspondence_L06 : in hex_char;
			Sw02_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R9_command : in routeCommands;
			Lc01_state : in hex_char;
			--Ocupation level 0
			track_ne16 : in hex_char;
			correspondence_S15 : out hex_char;
			--Ocupation level 1
			track_ne14 : in hex_char;
			track_ne15 : in hex_char;
			correspondence_P09 : in hex_char;
			correspondence_L04 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			Lc01_state : in hex_char;
			--Ocupation level 0
			track_ne16 : in hex_char;
			correspondence_S18 : out hex_char;
			--Ocupation level 1
			track_ne18 : in hex_char;
			track_ne17 : in hex_char;
			track_ne20 : in hex_char;
			correspondence_P12 : in hex_char;
			correspondence_L06 : in hex_char;
			Sw02_state : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			--Ocupation level 0
			track_ne18 : in hex_char;
			correspondence_P12 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne18 : in hex_char;
			correspondence_C17 : out hex_char;
			--Ocupation level 1
			track_ne16 : in hex_char;
			correspondence_S15 : in hex_char;
			Sw02_state : in hex_char;
			--Ocupation level 2
			track_ne15 : in hex_char;
			track_ne14 : in hex_char;
			correspondence_P09 : in hex_char;
			correspondence_L04 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			--Ocupation level 0
			track_ne19 : in hex_char;
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
			--Ocupation level 0
			track_ne19 : in hex_char;
			correspondence_T02 : out hex_char;
			--Ocupation level 1
			track_ne20 : in hex_char;
			correspondence_L06 : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			--Ocupation level 0
			track_ne20 : in hex_char;
			correspondence_L06 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			--Ocupation level 0
			track_ne20 : in hex_char;
			correspondence_S21 : out hex_char;
			--Ocupation level 1
			track_ne17 : in hex_char;
			track_ne16 : in hex_char;
			track_ne19 : in hex_char;
			correspondence_S15 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw02_state : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne15 : in hex_char;
			track_ne14 : in hex_char;
			correspondence_P09 : in hex_char;
			correspondence_L04 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_11;
	component node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_0;
	component node_1 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R5_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_1;
	component node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_2;
	component node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_3;
	component node_4 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R7_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_4;
	component node_5 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R10_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_5;
	component node_6 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R8_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_6;
--sw  R1 ['Sw03'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 [] 
	component route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne19 : in hex_char;
			ne19_command : out routeCommands := RELEASE;
			track_ne20 : in hex_char;
			ne20_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			L06_state : in hex_char;
			L06_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_0;
--sw  R2 ['Sw01', 'Sw02'] 
--dw  R2 [] 
--sc  R2 [] 
--lc  R2 [] 
	component route_1 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne14 : in hex_char;
			ne14_command : out routeCommands := RELEASE;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			C13_state : in hex_char;
			C13_command : out routeCommands := RELEASE;
			S18_state : in hex_char;
			S18_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_1;
--sw  R3 ['Sw01', 'Sw02'] 
--dw  R3 [] 
--sc  R3 [] 
--lc  R3 [] 
	component route_2 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne15 : in hex_char;
			ne15_command : out routeCommands := RELEASE;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			B14_state : in hex_char;
			B14_command : out routeCommands := RELEASE;
			S18_state : in hex_char;
			S18_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_2;
--sw  R4 ['Sw01'] 
--dw  R4 [] 
--sc  R4 [] 
--lc  R4 ['Lc01'] 
	component route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			track_ne14 : in hex_char;
			ne14_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			S15_state : in hex_char;
			S15_command : out routeCommands := RELEASE;
			P09_state : in hex_char;
			P09_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_3;
--sw  R5 ['Sw01'] 
--dw  R5 [] 
--sc  R5 [] 
--lc  R5 ['Lc01'] 
	component route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			track_ne15 : in hex_char;
			ne15_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			S15_state : in hex_char;
			S15_command : out routeCommands := RELEASE;
			L04_state : in hex_char;
			L04_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_4;
--sw  R6 ['Sw01', 'Sw02'] 
--dw  R6 [] 
--sc  R6 [] 
--lc  R6 [] 
	component route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne18 : in hex_char;
			ne18_command : out routeCommands := RELEASE;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			C17_state : in hex_char;
			C17_command : out routeCommands := RELEASE;
			S15_state : in hex_char;
			S15_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_5;
--sw  R7 ['Sw02'] 
--dw  R7 [] 
--sc  R7 [] 
--lc  R7 ['Lc01'] 
	component route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			track_ne18 : in hex_char;
			ne18_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			S18_state : in hex_char;
			S18_command : out routeCommands := RELEASE;
			P12_state : in hex_char;
			P12_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_6;
--sw  R8 ['Sw02', 'Sw03'] 
--dw  R8 [] 
--sc  R8 [] 
--lc  R8 ['Lc01'] 
	component route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			track_ne17 : in hex_char;
			ne17_command : out routeCommands := RELEASE;
			track_ne20 : in hex_char;
			ne20_command : out routeCommands := RELEASE;
			Lc01_state : in hex_char;
			Lc01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S18_state : in hex_char;
			S18_command : out routeCommands := RELEASE;
			L06_state : in hex_char;
			L06_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_7;
--sw  R9 ['Sw01', 'Sw02', 'Sw03'] 
--dw  R9 [] 
--sc  R9 [] 
--lc  R9 [] 
	component route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne20 : in hex_char;
			ne20_command : out routeCommands := RELEASE;
			track_ne17 : in hex_char;
			ne17_command : out routeCommands := RELEASE;
			track_ne16 : in hex_char;
			ne16_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S21_state : in hex_char;
			S21_command : out routeCommands := RELEASE;
			S15_state : in hex_char;
			S15_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_8;
--sw  R10 ['Sw03'] 
--dw  R10 [] 
--sc  R10 [] 
--lc  R10 [] 
	component route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne20 : in hex_char;
			ne20_command : out routeCommands := RELEASE;
			track_ne19 : in hex_char;
			ne19_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			S21_state : in hex_char;
			S21_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_9;
	signal state_Lc01 : hex_char;
	signal state_Sw01 , state_Sw02 , state_Sw03 : hex_char;
	signal state_P09 , state_C13 , state_L04 , state_B14 , state_S15 , state_S18 , state_P12 , state_C17 , state_T01 , state_T02 , state_L06 , state_S21 : hex_char;
	signal cmd_R1_ne19 , cmd_R1_ne20 , cmd_R2_ne14 , cmd_R2_ne16 , cmd_R3_ne15 , cmd_R3_ne16 , cmd_R4_ne16 , cmd_R4_ne14 , cmd_R5_ne16 , cmd_R5_ne15 , cmd_R6_ne18 , cmd_R6_ne16 , cmd_R7_ne16 , cmd_R7_ne18 , cmd_R8_ne16 , cmd_R8_ne17 , cmd_R8_ne20 , cmd_R9_ne20 , cmd_R9_ne17 , cmd_R9_ne16 , cmd_R10_ne20 , cmd_R10_ne19 : routeCommands := RELEASE;
	signal state_ne14 , state_ne15 , state_ne16 , state_ne17 , state_ne18 , state_ne19 , state_ne20 : hex_char;
	signal cmd_R4_Lc01 , cmd_R5_Lc01 , cmd_R7_Lc01 , cmd_R8_Lc01 : routeCommands := RELEASE;
	signal cmd_R2_Sw01 , cmd_R3_Sw01 , cmd_R4_Sw01 , cmd_R5_Sw01 , cmd_R6_Sw01 , cmd_R9_Sw01 , cmd_R6_Sw02 , cmd_R7_Sw02 , cmd_R8_Sw02 , cmd_R9_Sw02 , cmd_R2_Sw02 , cmd_R3_Sw02 , cmd_R1_Sw03 , cmd_R8_Sw03 , cmd_R9_Sw03 , cmd_R10_Sw03 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_C13 , cmd_R3_B14 , cmd_R4_S15 , cmd_R5_S15 , cmd_R6_C17 , cmd_R7_S18 , cmd_R8_S18 , cmd_R9_S21 , cmd_R10_S21 : routeCommands := RELEASE;
	signal cmd_R1_L06 , cmd_R2_S18 , cmd_R3_S18 , cmd_R4_P09 , cmd_R5_L04 , cmd_R6_S15 , cmd_R7_P12 , cmd_R8_L06 , cmd_R9_S15 , cmd_R10_T01 : routeCommands := RELEASE;
begin
	levelCrossing_Lc01 : levelCrossing_0 port map(track_ne16 => tracks_i(2), track_ne14 => tracks_i(0), track_ne15 => tracks_i(1), track_ne18 => tracks_i(4), track_ne17 => tracks_i(3), R4_command => cmd_R4_Lc01, R5_command => cmd_R5_Lc01, R7_command => cmd_R7_Lc01, R8_command => cmd_R8_Lc01, indication => levelCrossings_i, command  => levelCrossings_o, correspondence => state_Lc01, clock => clock, reset => reset);
	singleSwitch_Sw01 : singleSwitch_0 port map(R2_command => cmd_R2_Sw01, R3_command => cmd_R3_Sw01, R4_command => cmd_R4_Sw01, R5_command => cmd_R5_Sw01, R6_command => cmd_R6_Sw01, R9_command => cmd_R9_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence => state_Sw01, clock => clock, reset => reset);
	singleSwitch_Sw02 : singleSwitch_1 port map(R6_command => cmd_R6_Sw02, R7_command => cmd_R7_Sw02, R8_command => cmd_R8_Sw02, R9_command => cmd_R9_Sw02, R2_command => cmd_R2_Sw02, R3_command => cmd_R3_Sw02, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence => state_Sw02, clock => clock, reset => reset);
	singleSwitch_Sw03 : singleSwitch_2 port map(R1_command => cmd_R1_Sw03, R8_command => cmd_R8_Sw03, R9_command => cmd_R9_Sw03, R10_command => cmd_R10_Sw03, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence => state_Sw03, clock => clock, reset => reset);
	railwaySignal_P09 : railwaySignal_0 port map(R4_command => cmd_R4_P09, track_ne14 => tracks_i(0), indication => signals_i(0), command => signals_o(0), correspondence_P09 => state_P09, clock => clock, reset => reset);
	railwaySignal_C13 : railwaySignal_1 port map(R2_command => cmd_R2_C13, track_ne14 => tracks_i(0), track_ne16 => tracks_i(2), track_ne20 => tracks_i(6), track_ne17 => tracks_i(3), track_ne18 => tracks_i(4), correspondence_S18 => state_S18, correspondence_P12 => state_P12, correspondence_L06 => state_L06, Sw01_state => state_Sw01, Sw02_state => state_Sw02, Sw03_state => state_Sw03, indication => signals_i(1), command => signals_o(1), correspondence_C13 => state_C13, clock => clock, reset => reset);
	railwaySignal_L04 : railwaySignal_2 port map(R5_command => cmd_R5_L04, track_ne15 => tracks_i(1), indication => signals_i(2), command => signals_o(2), correspondence_L04 => state_L04, clock => clock, reset => reset);
	railwaySignal_B14 : railwaySignal_3 port map(R3_command => cmd_R3_B14, track_ne15 => tracks_i(1), track_ne16 => tracks_i(2), track_ne20 => tracks_i(6), track_ne17 => tracks_i(3), track_ne18 => tracks_i(4), correspondence_S18 => state_S18, correspondence_P12 => state_P12, correspondence_L06 => state_L06, Sw01_state => state_Sw01, Sw02_state => state_Sw02, Sw03_state => state_Sw03, indication => signals_i(3), command => signals_o(3), correspondence_B14 => state_B14, clock => clock, reset => reset);
	railwaySignal_S15 : railwaySignal_4 port map(R4_command => cmd_R4_S15, R5_command => cmd_R5_S15, R6_command => cmd_R6_S15, R9_command => cmd_R9_S15, track_ne16 => tracks_i(2), track_ne14 => tracks_i(0), track_ne15 => tracks_i(1), correspondence_P09 => state_P09, correspondence_L04 => state_L04, Sw01_state => state_Sw01, Lc01_state => state_Lc01, indication => signals_i(4), command => signals_o(4), correspondence_S15 => state_S15, clock => clock, reset => reset);
	railwaySignal_S18 : railwaySignal_5 port map(R7_command => cmd_R7_S18, R8_command => cmd_R8_S18, R2_command => cmd_R2_S18, R3_command => cmd_R3_S18, track_ne16 => tracks_i(2), track_ne18 => tracks_i(4), track_ne17 => tracks_i(3), track_ne20 => tracks_i(6), correspondence_P12 => state_P12, correspondence_L06 => state_L06, Sw02_state => state_Sw02, Sw03_state => state_Sw03, Lc01_state => state_Lc01, indication => signals_i(5), command => signals_o(5), correspondence_S18 => state_S18, clock => clock, reset => reset);
	railwaySignal_P12 : railwaySignal_6 port map(R7_command => cmd_R7_P12, track_ne18 => tracks_i(4), indication => signals_i(6), command => signals_o(6), correspondence_P12 => state_P12, clock => clock, reset => reset);
	railwaySignal_C17 : railwaySignal_7 port map(R6_command => cmd_R6_C17, track_ne18 => tracks_i(4), track_ne16 => tracks_i(2), track_ne15 => tracks_i(1), track_ne14 => tracks_i(0), correspondence_S15 => state_S15, correspondence_P09 => state_P09, correspondence_L04 => state_L04, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication => signals_i(7), command => signals_o(7), correspondence_C17 => state_C17, clock => clock, reset => reset);
	railwaySignal_T01 : railwaySignal_8 port map(R10_command => cmd_R10_T01, track_ne19 => tracks_i(5), indication => signals_i(8), command => signals_o(8), correspondence_T01 => state_T01, clock => clock, reset => reset);
	railwaySignal_T02 : railwaySignal_9 port map(R1_command => cmd_R1_T02, track_ne19 => tracks_i(5), track_ne20 => tracks_i(6), correspondence_L06 => state_L06, Sw03_state => state_Sw03, indication => signals_i(9), command => signals_o(9), correspondence_T02 => state_T02, clock => clock, reset => reset);
	railwaySignal_L06 : railwaySignal_10 port map(R1_command => cmd_R1_L06, R8_command => cmd_R8_L06, track_ne20 => tracks_i(6), indication => signals_i(10), command => signals_o(10), correspondence_L06 => state_L06, clock => clock, reset => reset);
	railwaySignal_S21 : railwaySignal_11 port map(R9_command => cmd_R9_S21, R10_command => cmd_R10_S21, track_ne20 => tracks_i(6), track_ne17 => tracks_i(3), track_ne16 => tracks_i(2), track_ne19 => tracks_i(5), track_ne15 => tracks_i(1), track_ne14 => tracks_i(0), correspondence_S15 => state_S15, correspondence_T01 => state_T01, correspondence_P09 => state_P09, correspondence_L04 => state_L04, Sw02_state => state_Sw02, Sw03_state => state_Sw03, Sw01_state => state_Sw01, indication => signals_i(11), command => signals_o(11), correspondence_S21 => state_S21, clock => clock, reset => reset);
	node_ne14 : node_0 port map(track_i => tracks_i(0), track_o => state_ne14, R2_command => cmd_R2_ne14, R4_command => cmd_R4_ne14, reset => reset);
	node_ne15 : node_1 port map(track_i => tracks_i(1), track_o => state_ne15, R3_command => cmd_R3_ne15, R5_command => cmd_R5_ne15, reset => reset);
	node_ne16 : node_2 port map(track_i => tracks_i(2), track_o => state_ne16, R2_command => cmd_R2_ne16, R3_command => cmd_R3_ne16, R4_command => cmd_R4_ne16, R5_command => cmd_R5_ne16, R6_command => cmd_R6_ne16, R7_command => cmd_R7_ne16, R8_command => cmd_R8_ne16, R9_command => cmd_R9_ne16, reset => reset);
	node_ne17 : node_3 port map(track_i => tracks_i(3), track_o => state_ne17, R8_command => cmd_R8_ne17, R9_command => cmd_R9_ne17, reset => reset);
	node_ne18 : node_4 port map(track_i => tracks_i(4), track_o => state_ne18, R6_command => cmd_R6_ne18, R7_command => cmd_R7_ne18, reset => reset);
	node_ne19 : node_5 port map(track_i => tracks_i(5), track_o => state_ne19, R1_command => cmd_R1_ne19, R10_command => cmd_R10_ne19, reset => reset);
	node_ne20 : node_6 port map(track_i => tracks_i(6), track_o => state_ne20, R1_command => cmd_R1_ne20, R8_command => cmd_R8_ne20, R9_command => cmd_R9_ne20, R10_command => cmd_R10_ne20, reset => reset);
	route_R1 : route_0 port map(routeRequest => routes_i(0), ne19_command => cmd_R1_ne19, track_ne19 => state_ne19, ne20_command => cmd_R1_ne20, track_ne20 => state_ne20, Sw03_command => cmd_R1_Sw03, Sw03_state => state_Sw03, T02_state => state_T02, T02_command => cmd_R1_T02, L06_state => state_L06, L06_command =>cmd_R1_L06, routeExecute => routes_o(0), clock => clock, reset => reset);
	route_R2 : route_1 port map(routeRequest => routes_i(1), ne14_command => cmd_R2_ne14, track_ne14 => state_ne14, ne16_command => cmd_R2_ne16, track_ne16 => state_ne16, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R2_Sw02, Sw02_state => state_Sw02, C13_state => state_C13, C13_command => cmd_R2_C13, S18_state => state_S18, S18_command =>cmd_R2_S18, routeExecute => routes_o(1), clock => clock, reset => reset);
	route_R3 : route_2 port map(routeRequest => routes_i(2), ne15_command => cmd_R3_ne15, track_ne15 => state_ne15, ne16_command => cmd_R3_ne16, track_ne16 => state_ne16, Sw01_command => cmd_R3_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R3_Sw02, Sw02_state => state_Sw02, B14_state => state_B14, B14_command => cmd_R3_B14, S18_state => state_S18, S18_command =>cmd_R3_S18, routeExecute => routes_o(2), clock => clock, reset => reset);
	route_R4 : route_3 port map(routeRequest => routes_i(3), ne14_command => cmd_R4_ne14, track_ne14 => state_ne14, ne16_command => cmd_R4_ne16, track_ne16 => state_ne16, Lc01_command => cmd_R4_Lc01, Lc01_state => state_Lc01, Sw01_command => cmd_R4_Sw01, Sw01_state => state_Sw01, S15_state => state_S15, S15_command => cmd_R4_S15, P09_state => state_P09, P09_command =>cmd_R4_P09, routeExecute => routes_o(3), clock => clock, reset => reset);
	route_R5 : route_4 port map(routeRequest => routes_i(4), ne15_command => cmd_R5_ne15, track_ne15 => state_ne15, ne16_command => cmd_R5_ne16, track_ne16 => state_ne16, Lc01_command => cmd_R5_Lc01, Lc01_state => state_Lc01, Sw01_command => cmd_R5_Sw01, Sw01_state => state_Sw01, S15_state => state_S15, S15_command => cmd_R5_S15, L04_state => state_L04, L04_command =>cmd_R5_L04, routeExecute => routes_o(4), clock => clock, reset => reset);
	route_R6 : route_5 port map(routeRequest => routes_i(5), ne16_command => cmd_R6_ne16, track_ne16 => state_ne16, ne18_command => cmd_R6_ne18, track_ne18 => state_ne18, Sw01_command => cmd_R6_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R6_Sw02, Sw02_state => state_Sw02, C17_state => state_C17, C17_command => cmd_R6_C17, S15_state => state_S15, S15_command =>cmd_R6_S15, routeExecute => routes_o(5), clock => clock, reset => reset);
	route_R7 : route_6 port map(routeRequest => routes_i(6), ne16_command => cmd_R7_ne16, track_ne16 => state_ne16, ne18_command => cmd_R7_ne18, track_ne18 => state_ne18, Lc01_command => cmd_R7_Lc01, Lc01_state => state_Lc01, Sw02_command => cmd_R7_Sw02, Sw02_state => state_Sw02, S18_state => state_S18, S18_command => cmd_R7_S18, P12_state => state_P12, P12_command =>cmd_R7_P12, routeExecute => routes_o(6), clock => clock, reset => reset);
	route_R8 : route_7 port map(routeRequest => routes_i(7), ne16_command => cmd_R8_ne16, track_ne16 => state_ne16, ne17_command => cmd_R8_ne17, track_ne17 => state_ne17, ne20_command => cmd_R8_ne20, track_ne20 => state_ne20, Lc01_command => cmd_R8_Lc01, Lc01_state => state_Lc01, Sw02_command => cmd_R8_Sw02, Sw02_state => state_Sw02, Sw03_command => cmd_R8_Sw03, Sw03_state => state_Sw03, S18_state => state_S18, S18_command => cmd_R8_S18, L06_state => state_L06, L06_command =>cmd_R8_L06, routeExecute => routes_o(7), clock => clock, reset => reset);
	route_R9 : route_8 port map(routeRequest => routes_i(8), ne16_command => cmd_R9_ne16, track_ne16 => state_ne16, ne17_command => cmd_R9_ne17, track_ne17 => state_ne17, ne20_command => cmd_R9_ne20, track_ne20 => state_ne20, Sw01_command => cmd_R9_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R9_Sw02, Sw02_state => state_Sw02, Sw03_command => cmd_R9_Sw03, Sw03_state => state_Sw03, S21_state => state_S21, S21_command => cmd_R9_S21, S15_state => state_S15, S15_command =>cmd_R9_S15, routeExecute => routes_o(8), clock => clock, reset => reset);
	route_R10 : route_9 port map(routeRequest => routes_i(9), ne19_command => cmd_R10_ne19, track_ne19 => state_ne19, ne20_command => cmd_R10_ne20, track_ne20 => state_ne20, Sw03_command => cmd_R10_Sw03, Sw03_state => state_Sw03, S21_state => state_S21, S21_command => cmd_R10_S21, T01_state => state_T01, T01_command =>cmd_R10_T01, routeExecute => routes_o(9), clock => clock, reset => reset);
	processed <= processing;
	tracks_o(0) <= state_ne14;
	tracks_o(1) <= state_ne15;
	tracks_o(2) <= state_ne16;
	tracks_o(3) <= state_ne17;
	tracks_o(4) <= state_ne18;
	tracks_o(5) <= state_ne19;
	tracks_o(6) <= state_ne20;
end Behavioral;