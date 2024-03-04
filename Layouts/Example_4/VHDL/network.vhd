--  network.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity network is
		generic(
			N : natural := 326;
			N_SIGNALS : natural := 79;
			N_ROUTES : natural := 91;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 20;
			N_DOUBLEWITCHES : natural := 4;
			N_TRACKCIRCUITS : natural := 47
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
			levelCrossings_i : in std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			levelCrossings_o : out std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches_i : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			singleSwitches_o : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches_i : in dSwitches_type;
			doubleSwitches_o : out dSwitches_type;
			reset : in std_logic
		);
	end entity network;
architecture Behavioral of network is
