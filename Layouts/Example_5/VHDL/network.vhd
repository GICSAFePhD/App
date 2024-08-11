--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N_TRACKCIRCUITS : natural := 8;
			N_ROUTES : natural := 16;
			N_SIGNALS : natural := 16;
			N_SINGLESWITCHES : natural := 4;
			N : natural := 44
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
			R1_command : in routeCommands := RELEASE;
			R2_command : in routeCommands := RELEASE;
			R9_command : in routeCommands := RELEASE;
			R10_command : in routeCommands := RELEASE;
			R3_command : in routeCommands := RELEASE;
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
			R3_command : in routeCommands := RELEASE;
			R4_command : in routeCommands := RELEASE;
			R11_command : in routeCommands := RELEASE;
			R12_command : in routeCommands := RELEASE;
			R1_command : in routeCommands := RELEASE;
			R2_command : in routeCommands := RELEASE;
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
			R6_command : in routeCommands := RELEASE;
			R13_command : in routeCommands := RELEASE;
			R14_command : in routeCommands := RELEASE;
			R7_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_2;
	component singleSwitch_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			R7_command : in routeCommands := RELEASE;
			R8_command : in routeCommands := RELEASE;
			R15_command : in routeCommands := RELEASE;
			R16_command : in routeCommands := RELEASE;
			R5_command : in routeCommands := RELEASE;
			R6_command : in routeCommands := RELEASE;
			indication : in hex_char;
			command : out hex_char;
			correspondence : out hex_char
		);
	end component singleSwitch_3;
	component railwaySignal_0 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			--Ocupation level 0
			track_ne01 : in hex_char;
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
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne01 : in hex_char;
			correspondence_T02 : out hex_char;
			--Ocupation level 1
			track_ne02 : in hex_char;
			track_ne03 : in hex_char;
			correspondence_C25 : in hex_char;
			correspondence_B26 : in hex_char;
			Sw01_state : in hex_char;
			--Ocupation level 2
			track_ne04 : in hex_char;
			correspondence_T03 : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_1;
	component railwaySignal_2 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R9_command : in routeCommands;
			R3_command : in routeCommands;
			--Ocupation level 0
			track_ne02 : in hex_char;
			correspondence_C21 : out hex_char;
			--Ocupation level 1
			track_ne01 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_2;
	component railwaySignal_3 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R1_command : in routeCommands;
			--Ocupation level 0
			track_ne02 : in hex_char;
			correspondence_C25 : out hex_char;
			--Ocupation level 1
			track_ne04 : in hex_char;
			correspondence_T03 : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_3;
	component railwaySignal_4 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R10_command : in routeCommands;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne03 : in hex_char;
			correspondence_B22 : out hex_char;
			--Ocupation level 1
			track_ne01 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_4;
	component railwaySignal_5 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R12_command : in routeCommands;
			R2_command : in routeCommands;
			--Ocupation level 0
			track_ne03 : in hex_char;
			correspondence_B26 : out hex_char;
			--Ocupation level 1
			track_ne04 : in hex_char;
			correspondence_T03 : in hex_char;
			Sw02_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_5;
	component railwaySignal_6 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			--Ocupation level 0
			track_ne04 : in hex_char;
			correspondence_T03 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_6;
	component railwaySignal_7 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			--Ocupation level 0
			track_ne04 : in hex_char;
			correspondence_T04 : out hex_char;
			--Ocupation level 1
			track_ne02 : in hex_char;
			track_ne03 : in hex_char;
			correspondence_C21 : in hex_char;
			correspondence_B22 : in hex_char;
			Sw02_state : in hex_char;
			--Ocupation level 2
			track_ne01 : in hex_char;
			correspondence_T01 : in hex_char;
			Sw01_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_7;
	component railwaySignal_8 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			--Ocupation level 0
			track_ne05 : in hex_char;
			correspondence_T05 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_8;
	component railwaySignal_9 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne05 : in hex_char;
			correspondence_T06 : out hex_char;
			--Ocupation level 1
			track_ne06 : in hex_char;
			track_ne07 : in hex_char;
			correspondence_C33 : in hex_char;
			correspondence_B34 : in hex_char;
			Sw03_state : in hex_char;
			--Ocupation level 2
			track_ne08 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_9;
	component railwaySignal_10 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R13_command : in routeCommands;
			R7_command : in routeCommands;
			--Ocupation level 0
			track_ne06 : in hex_char;
			correspondence_C29 : out hex_char;
			--Ocupation level 1
			track_ne05 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_10;
	component railwaySignal_11 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			R5_command : in routeCommands;
			--Ocupation level 0
			track_ne06 : in hex_char;
			correspondence_C33 : out hex_char;
			--Ocupation level 1
			track_ne08 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_11;
	component railwaySignal_12 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R14_command : in routeCommands;
			R8_command : in routeCommands;
			--Ocupation level 0
			track_ne07 : in hex_char;
			correspondence_B30 : out hex_char;
			--Ocupation level 1
			track_ne05 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_12;
	component railwaySignal_13 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R16_command : in routeCommands;
			R6_command : in routeCommands;
			--Ocupation level 0
			track_ne07 : in hex_char;
			correspondence_B34 : out hex_char;
			--Ocupation level 1
			track_ne08 : in hex_char;
			correspondence_T07 : in hex_char;
			Sw04_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_13;
	component railwaySignal_14 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			--Ocupation level 0
			track_ne08 : in hex_char;
			correspondence_T07 : out hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_14;
	component railwaySignal_15 is
		port(
			clock : in std_logic;
			reset : in std_logic;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			--Ocupation level 0
			track_ne08 : in hex_char;
			correspondence_T08 : out hex_char;
			--Ocupation level 1
			track_ne06 : in hex_char;
			track_ne07 : in hex_char;
			correspondence_C29 : in hex_char;
			correspondence_B30 : in hex_char;
			Sw04_state : in hex_char;
			--Ocupation level 2
			track_ne05 : in hex_char;
			correspondence_T05 : in hex_char;
			Sw03_state : in hex_char;
			indication : in hex_char;
			command : out hex_char
		);
	end component railwaySignal_15;
	component node_0 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R2_command : in routeCommands;
			R9_command : in routeCommands;
			R10_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_0;
	component node_1 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R1_command : in routeCommands;
			R3_command : in routeCommands;
			R9_command : in routeCommands;
			R11_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_1;
	component node_2 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R2_command : in routeCommands;
			R4_command : in routeCommands;
			R10_command : in routeCommands;
			R12_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_2;
	component node_3 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R3_command : in routeCommands;
			R4_command : in routeCommands;
			R11_command : in routeCommands;
			R12_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_3;
	component node_4 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R6_command : in routeCommands;
			R13_command : in routeCommands;
			R14_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_4;
	component node_5 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R5_command : in routeCommands;
			R7_command : in routeCommands;
			R13_command : in routeCommands;
			R15_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_5;
	component node_6 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R6_command : in routeCommands;
			R8_command : in routeCommands;
			R14_command : in routeCommands;
			R16_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_6;
	component node_7 is
		port(
			reset : in std_logic;
			track_i : in hex_char;
			R7_command : in routeCommands;
			R8_command : in routeCommands;
			R15_command : in routeCommands;
			R16_command : in routeCommands;
			track_o : out hex_char
		);
	end component node_7;
--sw  R1 ['Sw01', 'Sw02'] 
--dw  R1 [] 
--sc  R1 [] 
--lc  R1 [] 
	component route_0 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne01 : in hex_char;
			ne01_command : out routeCommands := RELEASE;
			track_ne02 : in hex_char;
			ne02_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			C25_state : in hex_char;
			C25_command : out routeCommands := RELEASE;
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
			track_ne01 : in hex_char;
			ne01_command : out routeCommands := RELEASE;
			track_ne03 : in hex_char;
			ne03_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			T02_state : in hex_char;
			T02_command : out routeCommands := RELEASE;
			B26_state : in hex_char;
			B26_command : out routeCommands := RELEASE;
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
			track_ne04 : in hex_char;
			ne04_command : out routeCommands := RELEASE;
			track_ne02 : in hex_char;
			ne02_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_2;
--sw  R4 ['Sw01', 'Sw02'] 
--dw  R4 [] 
--sc  R4 [] 
--lc  R4 [] 
	component route_3 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne04 : in hex_char;
			ne04_command : out routeCommands := RELEASE;
			track_ne03 : in hex_char;
			ne03_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			T04_state : in hex_char;
			T04_command : out routeCommands := RELEASE;
			B22_state : in hex_char;
			B22_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_3;
--sw  R5 ['Sw03', 'Sw04'] 
--dw  R5 [] 
--sc  R5 [] 
--lc  R5 [] 
	component route_4 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne05 : in hex_char;
			ne05_command : out routeCommands := RELEASE;
			track_ne06 : in hex_char;
			ne06_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			C33_state : in hex_char;
			C33_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_4;
--sw  R6 ['Sw03', 'Sw04'] 
--dw  R6 [] 
--sc  R6 [] 
--lc  R6 [] 
	component route_5 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne05 : in hex_char;
			ne05_command : out routeCommands := RELEASE;
			track_ne07 : in hex_char;
			ne07_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			T06_state : in hex_char;
			T06_command : out routeCommands := RELEASE;
			B34_state : in hex_char;
			B34_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_5;
--sw  R7 ['Sw03', 'Sw04'] 
--dw  R7 [] 
--sc  R7 [] 
--lc  R7 [] 
	component route_6 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne08 : in hex_char;
			ne08_command : out routeCommands := RELEASE;
			track_ne06 : in hex_char;
			ne06_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			T08_state : in hex_char;
			T08_command : out routeCommands := RELEASE;
			C29_state : in hex_char;
			C29_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_6;
--sw  R8 ['Sw03', 'Sw04'] 
--dw  R8 [] 
--sc  R8 [] 
--lc  R8 [] 
	component route_7 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne08 : in hex_char;
			ne08_command : out routeCommands := RELEASE;
			track_ne07 : in hex_char;
			ne07_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			T08_state : in hex_char;
			T08_command : out routeCommands := RELEASE;
			B30_state : in hex_char;
			B30_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_7;
--sw  R9 ['Sw01'] 
--dw  R9 [] 
--sc  R9 [] 
--lc  R9 [] 
	component route_8 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne02 : in hex_char;
			ne02_command : out routeCommands := RELEASE;
			track_ne01 : in hex_char;
			ne01_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			C21_state : in hex_char;
			C21_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_8;
--sw  R10 ['Sw01'] 
--dw  R10 [] 
--sc  R10 [] 
--lc  R10 [] 
	component route_9 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne03 : in hex_char;
			ne03_command : out routeCommands := RELEASE;
			track_ne01 : in hex_char;
			ne01_command : out routeCommands := RELEASE;
			Sw01_state : in hex_char;
			Sw01_command : out routeCommands := RELEASE;
			B22_state : in hex_char;
			B22_command : out routeCommands := RELEASE;
			T01_state : in hex_char;
			T01_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_9;
--sw  R11 ['Sw02'] 
--dw  R11 [] 
--sc  R11 [] 
--lc  R11 [] 
	component route_10 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne02 : in hex_char;
			ne02_command : out routeCommands := RELEASE;
			track_ne04 : in hex_char;
			ne04_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			C25_state : in hex_char;
			C25_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_10;
--sw  R12 ['Sw02'] 
--dw  R12 [] 
--sc  R12 [] 
--lc  R12 [] 
	component route_11 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne03 : in hex_char;
			ne03_command : out routeCommands := RELEASE;
			track_ne04 : in hex_char;
			ne04_command : out routeCommands := RELEASE;
			Sw02_state : in hex_char;
			Sw02_command : out routeCommands := RELEASE;
			B26_state : in hex_char;
			B26_command : out routeCommands := RELEASE;
			T03_state : in hex_char;
			T03_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_11;
--sw  R13 ['Sw03'] 
--dw  R13 [] 
--sc  R13 [] 
--lc  R13 [] 
	component route_12 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne06 : in hex_char;
			ne06_command : out routeCommands := RELEASE;
			track_ne05 : in hex_char;
			ne05_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			C29_state : in hex_char;
			C29_command : out routeCommands := RELEASE;
			T05_state : in hex_char;
			T05_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_12;
--sw  R14 ['Sw03'] 
--dw  R14 [] 
--sc  R14 [] 
--lc  R14 [] 
	component route_13 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne07 : in hex_char;
			ne07_command : out routeCommands := RELEASE;
			track_ne05 : in hex_char;
			ne05_command : out routeCommands := RELEASE;
			Sw03_state : in hex_char;
			Sw03_command : out routeCommands := RELEASE;
			B30_state : in hex_char;
			B30_command : out routeCommands := RELEASE;
			T05_state : in hex_char;
			T05_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_13;
--sw  R15 ['Sw04'] 
--dw  R15 [] 
--sc  R15 [] 
--lc  R15 [] 
	component route_14 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne06 : in hex_char;
			ne06_command : out routeCommands := RELEASE;
			track_ne08 : in hex_char;
			ne08_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			C33_state : in hex_char;
			C33_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_14;
--sw  R16 ['Sw04'] 
--dw  R16 [] 
--sc  R16 [] 
--lc  R16 [] 
	component route_15 is
		port(
			clock : in std_logic := '0';
			reset : in std_logic := '0';
			routeRequest : in hex_char;
			track_ne07 : in hex_char;
			ne07_command : out routeCommands := RELEASE;
			track_ne08 : in hex_char;
			ne08_command : out routeCommands := RELEASE;
			Sw04_state : in hex_char;
			Sw04_command : out routeCommands := RELEASE;
			B34_state : in hex_char;
			B34_command : out routeCommands := RELEASE;
			T07_state : in hex_char;
			T07_command : out routeCommands := RELEASE;
			routeExecute : out hex_char
		);
	end component route_15;
	signal state_Sw01 , state_Sw02 , state_Sw03 , state_Sw04 : hex_char;
	signal state_T01 , state_T02 , state_C21 , state_C25 , state_B22 , state_B26 , state_T03 , state_T04 , state_T05 , state_T06 , state_C29 , state_C33 , state_B30 , state_B34 , state_T07 , state_T08 : hex_char;
	signal cmd_R1_ne01 , cmd_R1_ne02 , cmd_R2_ne01 , cmd_R2_ne03 , cmd_R3_ne04 , cmd_R3_ne02 , cmd_R4_ne04 , cmd_R4_ne03 , cmd_R5_ne05 , cmd_R5_ne06 , cmd_R6_ne05 , cmd_R6_ne07 , cmd_R7_ne08 , cmd_R7_ne06 , cmd_R8_ne08 , cmd_R8_ne07 , cmd_R9_ne02 , cmd_R9_ne01 , cmd_R10_ne03 , cmd_R10_ne01 , cmd_R11_ne02 , cmd_R11_ne04 , cmd_R12_ne03 , cmd_R12_ne04 , cmd_R13_ne06 , cmd_R13_ne05 , cmd_R14_ne07 , cmd_R14_ne05 , cmd_R15_ne06 , cmd_R15_ne08 , cmd_R16_ne07 , cmd_R16_ne08 : routeCommands := RELEASE;
	signal state_ne01 , state_ne02 , state_ne03 , state_ne04 , state_ne05 , state_ne06 , state_ne07 , state_ne08 : hex_char;
	signal cmd_R1_Sw01 , cmd_R2_Sw01 , cmd_R9_Sw01 , cmd_R10_Sw01 , cmd_R3_Sw01 , cmd_R4_Sw01 , cmd_R3_Sw02 , cmd_R4_Sw02 , cmd_R11_Sw02 , cmd_R12_Sw02 , cmd_R1_Sw02 , cmd_R2_Sw02 , cmd_R5_Sw03 , cmd_R6_Sw03 , cmd_R13_Sw03 , cmd_R14_Sw03 , cmd_R7_Sw03 , cmd_R8_Sw03 , cmd_R7_Sw04 , cmd_R8_Sw04 , cmd_R15_Sw04 , cmd_R16_Sw04 , cmd_R5_Sw04 , cmd_R6_Sw04 : routeCommands := RELEASE;
	signal cmd_R1_T02 , cmd_R2_T02 , cmd_R3_T04 , cmd_R4_T04 , cmd_R5_T06 , cmd_R6_T06 , cmd_R7_T08 , cmd_R8_T08 , cmd_R9_C21 , cmd_R10_B22 , cmd_R11_C25 , cmd_R12_B26 , cmd_R13_C29 , cmd_R14_B30 , cmd_R15_C33 , cmd_R16_B34 : routeCommands := RELEASE;
	signal cmd_R1_C25 , cmd_R2_B26 , cmd_R3_C21 , cmd_R4_B22 , cmd_R5_C33 , cmd_R6_B34 , cmd_R7_C29 , cmd_R8_B30 , cmd_R9_T01 , cmd_R10_T01 , cmd_R11_T03 , cmd_R12_T03 , cmd_R13_T05 , cmd_R14_T05 , cmd_R15_T07 , cmd_R16_T07 : routeCommands := RELEASE;
begin
	singleSwitch_Sw01 : singleSwitch_0 port map(R1_command => cmd_R1_Sw01, R2_command => cmd_R2_Sw01, R9_command => cmd_R9_Sw01, R10_command => cmd_R10_Sw01, R3_command => cmd_R3_Sw01, R4_command => cmd_R4_Sw01, indication => singleSwitches_i(0), command => singleSwitches_o(0), correspondence => state_Sw01, clock => clock, reset => reset);
	singleSwitch_Sw02 : singleSwitch_1 port map(R3_command => cmd_R3_Sw02, R4_command => cmd_R4_Sw02, R11_command => cmd_R11_Sw02, R12_command => cmd_R12_Sw02, R1_command => cmd_R1_Sw02, R2_command => cmd_R2_Sw02, indication => singleSwitches_i(1), command => singleSwitches_o(1), correspondence => state_Sw02, clock => clock, reset => reset);
	singleSwitch_Sw03 : singleSwitch_2 port map(R5_command => cmd_R5_Sw03, R6_command => cmd_R6_Sw03, R13_command => cmd_R13_Sw03, R14_command => cmd_R14_Sw03, R7_command => cmd_R7_Sw03, R8_command => cmd_R8_Sw03, indication => singleSwitches_i(2), command => singleSwitches_o(2), correspondence => state_Sw03, clock => clock, reset => reset);
	singleSwitch_Sw04 : singleSwitch_3 port map(R7_command => cmd_R7_Sw04, R8_command => cmd_R8_Sw04, R15_command => cmd_R15_Sw04, R16_command => cmd_R16_Sw04, R5_command => cmd_R5_Sw04, R6_command => cmd_R6_Sw04, indication => singleSwitches_i(3), command => singleSwitches_o(3), correspondence => state_Sw04, clock => clock, reset => reset);
	railwaySignal_T01 : railwaySignal_0 port map(R9_command => cmd_R9_T01, R10_command => cmd_R10_T01, track_ne01 => tracks_i(0), indication => signals_i(0), command => signals_o(0), correspondence_T01 => state_T01, clock => clock, reset => reset);
	railwaySignal_T02 : railwaySignal_1 port map(R1_command => cmd_R1_T02, R2_command => cmd_R2_T02, track_ne01 => tracks_i(0), track_ne02 => tracks_i(1), track_ne03 => tracks_i(2), track_ne04 => tracks_i(3), correspondence_C25 => state_C25, correspondence_B26 => state_B26, correspondence_T03 => state_T03, Sw01_state => state_Sw01, Sw02_state => state_Sw02, indication => signals_i(1), command => signals_o(1), correspondence_T02 => state_T02, clock => clock, reset => reset);
	railwaySignal_C21 : railwaySignal_2 port map(R9_command => cmd_R9_C21, R3_command => cmd_R3_C21, track_ne02 => tracks_i(1), track_ne01 => tracks_i(0), correspondence_T01 => state_T01, Sw01_state => state_Sw01, indication => signals_i(2), command => signals_o(2), correspondence_C21 => state_C21, clock => clock, reset => reset);
	railwaySignal_C25 : railwaySignal_3 port map(R11_command => cmd_R11_C25, R1_command => cmd_R1_C25, track_ne02 => tracks_i(1), track_ne04 => tracks_i(3), correspondence_T03 => state_T03, Sw02_state => state_Sw02, indication => signals_i(3), command => signals_o(3), correspondence_C25 => state_C25, clock => clock, reset => reset);
	railwaySignal_B22 : railwaySignal_4 port map(R10_command => cmd_R10_B22, R4_command => cmd_R4_B22, track_ne03 => tracks_i(2), track_ne01 => tracks_i(0), correspondence_T01 => state_T01, Sw01_state => state_Sw01, indication => signals_i(4), command => signals_o(4), correspondence_B22 => state_B22, clock => clock, reset => reset);
	railwaySignal_B26 : railwaySignal_5 port map(R12_command => cmd_R12_B26, R2_command => cmd_R2_B26, track_ne03 => tracks_i(2), track_ne04 => tracks_i(3), correspondence_T03 => state_T03, Sw02_state => state_Sw02, indication => signals_i(5), command => signals_o(5), correspondence_B26 => state_B26, clock => clock, reset => reset);
	railwaySignal_T03 : railwaySignal_6 port map(R11_command => cmd_R11_T03, R12_command => cmd_R12_T03, track_ne04 => tracks_i(3), indication => signals_i(6), command => signals_o(6), correspondence_T03 => state_T03, clock => clock, reset => reset);
	railwaySignal_T04 : railwaySignal_7 port map(R3_command => cmd_R3_T04, R4_command => cmd_R4_T04, track_ne04 => tracks_i(3), track_ne02 => tracks_i(1), track_ne03 => tracks_i(2), track_ne01 => tracks_i(0), correspondence_C21 => state_C21, correspondence_B22 => state_B22, correspondence_T01 => state_T01, Sw02_state => state_Sw02, Sw01_state => state_Sw01, indication => signals_i(7), command => signals_o(7), correspondence_T04 => state_T04, clock => clock, reset => reset);
	railwaySignal_T05 : railwaySignal_8 port map(R13_command => cmd_R13_T05, R14_command => cmd_R14_T05, track_ne05 => tracks_i(4), indication => signals_i(8), command => signals_o(8), correspondence_T05 => state_T05, clock => clock, reset => reset);
	railwaySignal_T06 : railwaySignal_9 port map(R5_command => cmd_R5_T06, R6_command => cmd_R6_T06, track_ne05 => tracks_i(4), track_ne06 => tracks_i(5), track_ne07 => tracks_i(6), track_ne08 => tracks_i(7), correspondence_C33 => state_C33, correspondence_B34 => state_B34, correspondence_T07 => state_T07, Sw03_state => state_Sw03, Sw04_state => state_Sw04, indication => signals_i(9), command => signals_o(9), correspondence_T06 => state_T06, clock => clock, reset => reset);
	railwaySignal_C29 : railwaySignal_10 port map(R13_command => cmd_R13_C29, R7_command => cmd_R7_C29, track_ne06 => tracks_i(5), track_ne05 => tracks_i(4), correspondence_T05 => state_T05, Sw03_state => state_Sw03, indication => signals_i(10), command => signals_o(10), correspondence_C29 => state_C29, clock => clock, reset => reset);
	railwaySignal_C33 : railwaySignal_11 port map(R15_command => cmd_R15_C33, R5_command => cmd_R5_C33, track_ne06 => tracks_i(5), track_ne08 => tracks_i(7), correspondence_T07 => state_T07, Sw04_state => state_Sw04, indication => signals_i(11), command => signals_o(11), correspondence_C33 => state_C33, clock => clock, reset => reset);
	railwaySignal_B30 : railwaySignal_12 port map(R14_command => cmd_R14_B30, R8_command => cmd_R8_B30, track_ne07 => tracks_i(6), track_ne05 => tracks_i(4), correspondence_T05 => state_T05, Sw03_state => state_Sw03, indication => signals_i(12), command => signals_o(12), correspondence_B30 => state_B30, clock => clock, reset => reset);
	railwaySignal_B34 : railwaySignal_13 port map(R16_command => cmd_R16_B34, R6_command => cmd_R6_B34, track_ne07 => tracks_i(6), track_ne08 => tracks_i(7), correspondence_T07 => state_T07, Sw04_state => state_Sw04, indication => signals_i(13), command => signals_o(13), correspondence_B34 => state_B34, clock => clock, reset => reset);
	railwaySignal_T07 : railwaySignal_14 port map(R15_command => cmd_R15_T07, R16_command => cmd_R16_T07, track_ne08 => tracks_i(7), indication => signals_i(14), command => signals_o(14), correspondence_T07 => state_T07, clock => clock, reset => reset);
	railwaySignal_T08 : railwaySignal_15 port map(R7_command => cmd_R7_T08, R8_command => cmd_R8_T08, track_ne08 => tracks_i(7), track_ne06 => tracks_i(5), track_ne07 => tracks_i(6), track_ne05 => tracks_i(4), correspondence_C29 => state_C29, correspondence_B30 => state_B30, correspondence_T05 => state_T05, Sw04_state => state_Sw04, Sw03_state => state_Sw03, indication => signals_i(15), command => signals_o(15), correspondence_T08 => state_T08, clock => clock, reset => reset);
	node_ne01 : node_0 port map(track_i => tracks_i(0), track_o => state_ne01, R1_command => cmd_R1_ne01, R2_command => cmd_R2_ne01, R9_command => cmd_R9_ne01, R10_command => cmd_R10_ne01, reset => reset);
	node_ne02 : node_1 port map(track_i => tracks_i(1), track_o => state_ne02, R1_command => cmd_R1_ne02, R3_command => cmd_R3_ne02, R9_command => cmd_R9_ne02, R11_command => cmd_R11_ne02, reset => reset);
	node_ne03 : node_2 port map(track_i => tracks_i(2), track_o => state_ne03, R2_command => cmd_R2_ne03, R4_command => cmd_R4_ne03, R10_command => cmd_R10_ne03, R12_command => cmd_R12_ne03, reset => reset);
	node_ne04 : node_3 port map(track_i => tracks_i(3), track_o => state_ne04, R3_command => cmd_R3_ne04, R4_command => cmd_R4_ne04, R11_command => cmd_R11_ne04, R12_command => cmd_R12_ne04, reset => reset);
	node_ne05 : node_4 port map(track_i => tracks_i(4), track_o => state_ne05, R5_command => cmd_R5_ne05, R6_command => cmd_R6_ne05, R13_command => cmd_R13_ne05, R14_command => cmd_R14_ne05, reset => reset);
	node_ne06 : node_5 port map(track_i => tracks_i(5), track_o => state_ne06, R5_command => cmd_R5_ne06, R7_command => cmd_R7_ne06, R13_command => cmd_R13_ne06, R15_command => cmd_R15_ne06, reset => reset);
	node_ne07 : node_6 port map(track_i => tracks_i(6), track_o => state_ne07, R6_command => cmd_R6_ne07, R8_command => cmd_R8_ne07, R14_command => cmd_R14_ne07, R16_command => cmd_R16_ne07, reset => reset);
	node_ne08 : node_7 port map(track_i => tracks_i(7), track_o => state_ne08, R7_command => cmd_R7_ne08, R8_command => cmd_R8_ne08, R15_command => cmd_R15_ne08, R16_command => cmd_R16_ne08, reset => reset);
	route_R1 : route_0 port map(routeRequest => routes_i(0), ne01_command => cmd_R1_ne01, track_ne01 => state_ne01, ne02_command => cmd_R1_ne02, track_ne02 => state_ne02, Sw01_command => cmd_R1_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R1_Sw02, Sw02_state => state_Sw02, T02_state => state_T02, T02_command => cmd_R1_T02, C25_state => state_C25, C25_command =>cmd_R1_C25, routeExecute => routes_o(0), clock => clock, reset => reset);
	route_R2 : route_1 port map(routeRequest => routes_i(1), ne01_command => cmd_R2_ne01, track_ne01 => state_ne01, ne03_command => cmd_R2_ne03, track_ne03 => state_ne03, Sw01_command => cmd_R2_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R2_Sw02, Sw02_state => state_Sw02, T02_state => state_T02, T02_command => cmd_R2_T02, B26_state => state_B26, B26_command =>cmd_R2_B26, routeExecute => routes_o(1), clock => clock, reset => reset);
	route_R3 : route_2 port map(routeRequest => routes_i(2), ne02_command => cmd_R3_ne02, track_ne02 => state_ne02, ne04_command => cmd_R3_ne04, track_ne04 => state_ne04, Sw01_command => cmd_R3_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R3_Sw02, Sw02_state => state_Sw02, T04_state => state_T04, T04_command => cmd_R3_T04, C21_state => state_C21, C21_command =>cmd_R3_C21, routeExecute => routes_o(2), clock => clock, reset => reset);
	route_R4 : route_3 port map(routeRequest => routes_i(3), ne03_command => cmd_R4_ne03, track_ne03 => state_ne03, ne04_command => cmd_R4_ne04, track_ne04 => state_ne04, Sw01_command => cmd_R4_Sw01, Sw01_state => state_Sw01, Sw02_command => cmd_R4_Sw02, Sw02_state => state_Sw02, T04_state => state_T04, T04_command => cmd_R4_T04, B22_state => state_B22, B22_command =>cmd_R4_B22, routeExecute => routes_o(3), clock => clock, reset => reset);
	route_R5 : route_4 port map(routeRequest => routes_i(4), ne05_command => cmd_R5_ne05, track_ne05 => state_ne05, ne06_command => cmd_R5_ne06, track_ne06 => state_ne06, Sw03_command => cmd_R5_Sw03, Sw03_state => state_Sw03, Sw04_command => cmd_R5_Sw04, Sw04_state => state_Sw04, T06_state => state_T06, T06_command => cmd_R5_T06, C33_state => state_C33, C33_command =>cmd_R5_C33, routeExecute => routes_o(4), clock => clock, reset => reset);
	route_R6 : route_5 port map(routeRequest => routes_i(5), ne05_command => cmd_R6_ne05, track_ne05 => state_ne05, ne07_command => cmd_R6_ne07, track_ne07 => state_ne07, Sw03_command => cmd_R6_Sw03, Sw03_state => state_Sw03, Sw04_command => cmd_R6_Sw04, Sw04_state => state_Sw04, T06_state => state_T06, T06_command => cmd_R6_T06, B34_state => state_B34, B34_command =>cmd_R6_B34, routeExecute => routes_o(5), clock => clock, reset => reset);
	route_R7 : route_6 port map(routeRequest => routes_i(6), ne06_command => cmd_R7_ne06, track_ne06 => state_ne06, ne08_command => cmd_R7_ne08, track_ne08 => state_ne08, Sw03_command => cmd_R7_Sw03, Sw03_state => state_Sw03, Sw04_command => cmd_R7_Sw04, Sw04_state => state_Sw04, T08_state => state_T08, T08_command => cmd_R7_T08, C29_state => state_C29, C29_command =>cmd_R7_C29, routeExecute => routes_o(6), clock => clock, reset => reset);
	route_R8 : route_7 port map(routeRequest => routes_i(7), ne07_command => cmd_R8_ne07, track_ne07 => state_ne07, ne08_command => cmd_R8_ne08, track_ne08 => state_ne08, Sw03_command => cmd_R8_Sw03, Sw03_state => state_Sw03, Sw04_command => cmd_R8_Sw04, Sw04_state => state_Sw04, T08_state => state_T08, T08_command => cmd_R8_T08, B30_state => state_B30, B30_command =>cmd_R8_B30, routeExecute => routes_o(7), clock => clock, reset => reset);
	route_R9 : route_8 port map(routeRequest => routes_i(8), ne01_command => cmd_R9_ne01, track_ne01 => state_ne01, ne02_command => cmd_R9_ne02, track_ne02 => state_ne02, Sw01_command => cmd_R9_Sw01, Sw01_state => state_Sw01, C21_state => state_C21, C21_command => cmd_R9_C21, T01_state => state_T01, T01_command =>cmd_R9_T01, routeExecute => routes_o(8), clock => clock, reset => reset);
	route_R10 : route_9 port map(routeRequest => routes_i(9), ne01_command => cmd_R10_ne01, track_ne01 => state_ne01, ne03_command => cmd_R10_ne03, track_ne03 => state_ne03, Sw01_command => cmd_R10_Sw01, Sw01_state => state_Sw01, B22_state => state_B22, B22_command => cmd_R10_B22, T01_state => state_T01, T01_command =>cmd_R10_T01, routeExecute => routes_o(9), clock => clock, reset => reset);
	route_R11 : route_10 port map(routeRequest => routes_i(10), ne02_command => cmd_R11_ne02, track_ne02 => state_ne02, ne04_command => cmd_R11_ne04, track_ne04 => state_ne04, Sw02_command => cmd_R11_Sw02, Sw02_state => state_Sw02, C25_state => state_C25, C25_command => cmd_R11_C25, T03_state => state_T03, T03_command =>cmd_R11_T03, routeExecute => routes_o(10), clock => clock, reset => reset);
	route_R12 : route_11 port map(routeRequest => routes_i(11), ne03_command => cmd_R12_ne03, track_ne03 => state_ne03, ne04_command => cmd_R12_ne04, track_ne04 => state_ne04, Sw02_command => cmd_R12_Sw02, Sw02_state => state_Sw02, B26_state => state_B26, B26_command => cmd_R12_B26, T03_state => state_T03, T03_command =>cmd_R12_T03, routeExecute => routes_o(11), clock => clock, reset => reset);
	route_R13 : route_12 port map(routeRequest => routes_i(12), ne05_command => cmd_R13_ne05, track_ne05 => state_ne05, ne06_command => cmd_R13_ne06, track_ne06 => state_ne06, Sw03_command => cmd_R13_Sw03, Sw03_state => state_Sw03, C29_state => state_C29, C29_command => cmd_R13_C29, T05_state => state_T05, T05_command =>cmd_R13_T05, routeExecute => routes_o(12), clock => clock, reset => reset);
	route_R14 : route_13 port map(routeRequest => routes_i(13), ne05_command => cmd_R14_ne05, track_ne05 => state_ne05, ne07_command => cmd_R14_ne07, track_ne07 => state_ne07, Sw03_command => cmd_R14_Sw03, Sw03_state => state_Sw03, B30_state => state_B30, B30_command => cmd_R14_B30, T05_state => state_T05, T05_command =>cmd_R14_T05, routeExecute => routes_o(13), clock => clock, reset => reset);
	route_R15 : route_14 port map(routeRequest => routes_i(14), ne06_command => cmd_R15_ne06, track_ne06 => state_ne06, ne08_command => cmd_R15_ne08, track_ne08 => state_ne08, Sw04_command => cmd_R15_Sw04, Sw04_state => state_Sw04, C33_state => state_C33, C33_command => cmd_R15_C33, T07_state => state_T07, T07_command =>cmd_R15_T07, routeExecute => routes_o(14), clock => clock, reset => reset);
	route_R16 : route_15 port map(routeRequest => routes_i(15), ne07_command => cmd_R16_ne07, track_ne07 => state_ne07, ne08_command => cmd_R16_ne08, track_ne08 => state_ne08, Sw04_command => cmd_R16_Sw04, Sw04_state => state_Sw04, B34_state => state_B34, B34_command => cmd_R16_B34, T07_state => state_T07, T07_command =>cmd_R16_T07, routeExecute => routes_o(15), clock => clock, reset => reset);
	processed <= processing;
	tracks_o(0) <= state_ne01;
	tracks_o(1) <= state_ne02;
	tracks_o(2) <= state_ne03;
	tracks_o(3) <= state_ne04;
	tracks_o(4) <= state_ne05;
	tracks_o(5) <= state_ne06;
	tracks_o(6) <= state_ne07;
	tracks_o(7) <= state_ne08;
end Behavioral;