--  interlocking.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity interlocking is
		generic(
			N : natural := 245;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLESWITCHES : natural := 2;
			N_SCISSORCROSSINGS : natural := 1;
			N_TRACKCIRCUITS : natural := 53
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			packet_i : in hex_array(245-1 downto 0);
			packet_o : out hex_array(245-1 downto 0);
			reset : in std_logic
		);
	end entity interlocking;
architecture Behavioral of interlocking is
	component splitter is
		generic(
			N_TRACKCIRCUITS : natural := 53;
			N_ROUTES : natural := 91;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLESWITCHES : natural := 2;
			N_SCRISSORCROSSINGS : natural := 1;
			N : natural := 245
		);
		port(
			clock : in std_logic;
			processing :  in std_logic;
			processed :  out std_logic;
			packet :  in hex_array(N-1 downto 0);
			tracks :  out hex_array(N_TRACKCIRCUITS-1 downto 0);
			routes : out hex_array(N_ROUTES-1 downto 0);
			signals : out hex_array(N_SIGNALS-1 downto 0);
			levelCrossings : out hex_char;
			singleSwitches : out hex_array(N_SINGLESWITCHES-1 downto 0);
			scissorCrossings : out hex_char;
			doubleSwitches : out hex_array(N_DOUBLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end component splitter;
	component network is
		generic(
			N_TRACKCIRCUITS : natural := 53;
			N_ROUTES : natural := 91;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLESWITCHES : natural := 2;
			N_SCRISSORCROSSINGS : natural := 1;
			N : natural := 245
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
			levelCrossings_i : in hex_char;
			levelCrossings_o : out hex_char;
			singleSwitches_i : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out hex_array(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches_i : in hex_array(N_DOUBLESWITCHES-1 downto 0);
			doubleSwitches_o : out hex_array(N_DOUBLESWITCHES-1 downto 0);
			scissorCrossings_i : in hex_char;
			scissorCrossings_o : out hex_char;
			reset : in std_logic
		);
	end component network;
	component mediator is
		generic(
			N_TRACKCIRCUITS : natural := 53;
			N_ROUTES : natural := 91;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLESWITCHES : natural := 2;
			N_SCRISSORCROSSINGS : natural := 1;
			N : natural := 245
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			tracks :  in hex_array(N_TRACKCIRCUITS-1 downto 0);
			routes : in hex_array(N_ROUTES-1 downto 0);
			signals : in hex_array(N_SIGNALS-1 downto 0);
			levelCrossings : in hex_char;
			singleSwitches : in hex_array(N_SINGLESWITCHES-1 downto 0);
			scissorCrossings : in hex_char;
			doubleSwitches : in hex_array(N_DOUBLESWITCHES-1 downto 0);
			output : out hex_array(245-1 downto 0);
			reset : in std_logic
		);
	end component mediator;
	component voter is
		generic(
			N_TRACKCIRCUITS : natural := 53;
			N_ROUTES : natural := 91;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLESWITCHES : natural := 2;
			N_SCRISSORCROSSINGS : natural := 1;
			N : natural := 245
		);
		port(
			clock : in std_logic;
			processing_A : in std_logic;
			processing_B : in std_logic;
			processing_C : in std_logic;
			processed_V : out std_logic;
			tracks_A: in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_B: in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_C: in hex_array(N_TRACKCIRCUITS-1 downto 0);
			tracks_V: out hex_array(N_TRACKCIRCUITS-1 downto 0);
			signals_A : in hex_array(N_SIGNALS-1 downto 0);
			signals_B : in hex_array(N_SIGNALS-1 downto 0);
			signals_C : in hex_array(N_SIGNALS-1 downto 0);
			signals_V : out hex_array(N_SIGNALS-1 downto 0);
			routes_A : in hex_array(N_ROUTES-1 downto 0);
			routes_B : in hex_array(N_ROUTES-1 downto 0);
			routes_C : in hex_array(N_ROUTES-1 downto 0);
			routes_V : out hex_array(N_ROUTES-1 downto 0);
			levelCrossings_A : in hex_char;
			levelCrossings_B : in hex_char;
			levelCrossings_C : in hex_char;
			levelCrossings_V : out hex_char;
			singleSwitches_A : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_B : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_C : in hex_array(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_V : out hex_array(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches_A : in hex_array(N_DOUBLESWITCHES-1 downto 0);
			doubleSwitches_B : in hex_array(N_DOUBLESWITCHES-1 downto 0);
			doubleSwitches_C : in hex_array(N_DOUBLESWITCHES-1 downto 0);
			doubleSwitches_V : out hex_array(N_DOUBLESWITCHES-1 downto 0);
			scissorCrossings_A : in hex_char;
			scissorCrossings_B : in hex_char;
			scissorCrossings_C : in hex_char;
			scissorCrossings_V : out hex_char;
			reset : in std_logic
		);
	end component voter;
	Signal tc_s_i,tc_s_o,tc_s_o_A,tc_s_o_B,tc_s_o_C : hex_array(53-1 downto 0);
	Signal sig_s_i,sig_s_o,sig_s_o_A,sig_s_o_B,sig_s_o_C : hex_array(82-1 downto 0);
	Signal rt_s_i,rt_s_o,rt_s_o_A,rt_s_o_B,rt_s_o_C : hex_array(91-1 downto 0);
	Signal lc_s_i,lc_s_o,lc_s_o_A,lc_s_o_B,lc_s_o_C : hex_char;
	Signal ssw_s_i,ssw_s_o,ssw_s_o_A,ssw_s_o_B,ssw_s_o_C : hex_array(15-1 downto 0);
	Signal sc_s_i,sc_s_o,sc_s_o_A,sc_s_o_B,sc_s_o_C : hex_char;
	Signal dsw_s_i,dsw_s_o,dsw_s_o_A,dsw_s_o_B,dsw_s_o_C : hex_array(2-1 downto 0);
	Signal process_spt_int,process_int_med,process_A,process_B,process_C : std_logic;

begin
	splitter_i : splitter port map(
		clock => clock,
		packet => packet_i,
		processing => processing,
		processed => process_spt_int,
		tracks => tc_s_i,
		signals => sig_s_i,
		routes => rt_s_i,
		levelCrossings => lc_s_i,
		singleSwitches => ssw_s_i,
		doubleSwitches => dsw_s_i,
		scissorCrossings => sc_s_i,
		reset => reset
		);
	mediator_i : mediator port map(
		clock => clock,
		processing => process_int_med,
		processed => processed,
		signals => sig_s_o,
		routes => rt_s_o,
		levelCrossings => lc_s_o,
		singleSwitches => ssw_s_o,
		doubleSwitches => dsw_s_o,
		scissorCrossings => sc_s_o,
		tracks => tc_s_o,
		output => packet_o,
		reset => reset
		);
	network_A : network port map(
		clock => clock,
		tracks_i => tc_s_i,
		tracks_o => tc_s_o_A,
		processing => process_spt_int,
		processed => process_A,
		signals_i => sig_s_i,
		signals_o => sig_s_o_A,
		routes_i => rt_s_i,
		routes_o => rt_s_o_A,
		levelCrossings_i => lc_s_i,
		levelCrossings_o => lc_s_o_A,
		singleSwitches_i => ssw_s_i,
		singleSwitches_o => ssw_s_o_A,
		doubleSwitches_i => dsw_s_i,
		doubleSwitches_o => dsw_s_o_A,
		scissorCrossings_i => sc_s_i,
		scissorCrossings_o => sc_s_o_A,
		reset => reset
		);
	network_B : network port map(
		clock => clock,
		tracks_i => tc_s_i,
		tracks_o => tc_s_o_B,
		processing => process_spt_int,
		processed => process_B,
		signals_i => sig_s_i,
		signals_o => sig_s_o_B,
		routes_i => rt_s_i,
		routes_o => rt_s_o_B,
		levelCrossings_i => lc_s_i,
		levelCrossings_o => lc_s_o_B,
		singleSwitches_i => ssw_s_i,
		singleSwitches_o => ssw_s_o_B,
		doubleSwitches_i => dsw_s_i,
		doubleSwitches_o => dsw_s_o_B,
		scissorCrossings_i => sc_s_i,
		scissorCrossings_o => sc_s_o_B,
		reset => reset
		);
	network_C : network port map(
		clock => clock,
		tracks_i => tc_s_i,
		tracks_o => tc_s_o_C,
		processing => process_spt_int,
		processed => process_C,
		signals_i => sig_s_i,
		signals_o => sig_s_o_C,
		routes_i => rt_s_i,
		routes_o => rt_s_o_C,
		levelCrossings_i => lc_s_i,
		levelCrossings_o => lc_s_o_C,
		singleSwitches_i => ssw_s_i,
		singleSwitches_o => ssw_s_o_C,
		doubleSwitches_i => dsw_s_i,
		doubleSwitches_o => dsw_s_o_C,
		scissorCrossings_i => sc_s_i,
		scissorCrossings_o => sc_s_o_C,
		reset => reset
		);
	voter_i : voter port map(
		clock => clock,
		tracks_A => tc_s_o_A,
		tracks_B => tc_s_o_B,
		tracks_C => tc_s_o_C,
		tracks_V => tc_s_o,
		processing_A => process_A,
		processing_B => process_B,
		processing_C => process_C,
		processed_V => process_int_med,
		signals_A => sig_s_o_A,
		signals_B => sig_s_o_B,
		signals_C => sig_s_o_C,
		signals_V => sig_s_o,
		routes_A => rt_s_o_A,
		routes_B => rt_s_o_B,
		routes_C => rt_s_o_C,
		routes_V => rt_s_o,
		levelCrossings_A => lc_s_o_A,
		levelCrossings_B => lc_s_o_B,
		levelCrossings_C => lc_s_o_C,
		levelCrossings_V => lc_s_o,
		singleSwitches_A => ssw_s_o_A,
		singleSwitches_B => ssw_s_o_B,
		singleSwitches_C => ssw_s_o_C,
		singleSwitches_V => ssw_s_o,
		doubleSwitches_A => dsw_s_o_A,
		doubleSwitches_B => dsw_s_o_B,
		doubleSwitches_C => dsw_s_o_C,
		doubleSwitches_V => dsw_s_o,
		scissorCrossings_A => sc_s_o_A,
		scissorCrossings_B => sc_s_o_B,
		scissorCrossings_C => sc_s_o_C,
		scissorCrossings_V => sc_s_o,
		reset => reset
		);
end Behavioral;