--  interlocking.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity interlocking is
		generic(
			N : natural := 329;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLEWITCHES : natural := 2;
			N_SCISSORCROSSINGS : natural := 1;
			N_TRACKCIRCUITS : natural := 53
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			packet_i : in std_logic_vector(329-1 downto 0);
			packet_o : out std_logic_vector(276-1 downto 0);
			reset : in std_logic
		);
	end entity interlocking;
architecture Behavioral of interlocking is
	component splitter is
		generic(
			N : natural := 329;
			N_SIGNALS : natural := 82;
			N_ROUTES : natural := 91;
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
			packet : in std_logic_vector(N-1 downto 0);
			ocupation : out std_logic_vector(N_TRACKCIRCUITS-1 downto 0);
			signals : out signals_type;
			routes :  out std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings :  out std_logic;
			singleSwitches :  out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches :  out std_logic_vector(N_DOUBLESWITCHES-1 downto 0);
			scissorCrossings :  out std_logic;
			reset :  in std_logic
		);
	end component splitter;
	component network is
		generic(
			N : natural := 329;
			N_SIGNALS : natural := 82;
			N_ROUTES : natural := 91;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 15;
			N_DOUBLEWITCHES : natural := 2;
			N_SCISSORCROSSINGS : natural := 1;
			N_TRACKCIRCUITS : natural := 53
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
			levelCrossings_i : in std_logic;
			levelCrossings_o : out std_logic;
			singleSwitches_i : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches_i : in dSwitches_type;
			doubleSwitches_o : out dSwitches_type;
			scrissorCrossings_i : in std_logic;
			scrissorCrossings_o : out std_logic;
			reset : in std_logic
		);
	end component network;
	component mediator is
		generic(
			N : natural := 329;
			N_SIGNALS : natural := 82;
			N_ROUTES : natural := 91;
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
			signals : in signals_type;
			routes : in std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings : in std_logic;
			singleSwitches : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			scissorCrossings : in std_logic;
			doubleSwitches : in dSwitches_type;
			output : out std_logic_vector(276-1 downto 0);
			reset : in std_logic
		);
	end component mediator;
	Signal tc_s : std_logic_vector(53-1 downto 0);
	Signal sig_s_i,sig_s_o : signals_type;
	Signal rt_s_i,rt_s_o : std_logic_vector(91-1 downto 0);
	Signal lc_s_i,lc_s_o : std_logic;
	Signal ssw_s_i,ssw_s_o : std_logic_vector(15-1 downto 0);
	Signal sc_s_i,sc_s_o : std_logic;
	Signal dsw_s_i,dsw_s_o : dSwitches_type;
	Signal process_spt_int, process_int_med : std_logic;

begin
	splitter_i : splitter port map(
		clock => clock,
		packet => packet_i,
		processing => processing,
		processed => process_spt_int,
		ocupation => tc_s,
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
		output => packet_o,
		reset => reset
		);
	network_i : network port map(
		clock => clock,
		ocupation => tc_s,
		processing => process_spt_int,
		processed => process_int_med,
		signals_i => sig_s_i,
		signals_o => sig_s_o,
		routes_i => rt_s_i,
		routes_o => rt_s_o,
		levelCrossings_i => lc_s_i,
		levelCrossings_o => lc_s_o,
		singleSwitches_i => ssw_s_i,
		singleSwitches_o => ssw_s_o,
		doubleSwitches_i => dsw_s_i,
		doubleSwitches_o => dsw_s_o,
		scrissorCrossings_i => sc_s_i,
		scrissorCrossings_o => sc_s_o,
		reset => reset
		);
end Behavioral;