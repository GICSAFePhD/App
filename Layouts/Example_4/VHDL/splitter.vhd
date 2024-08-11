--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N_TRACKCIRCUITS : natural := 47;
			N_ROUTES : natural := 89;
			N_SIGNALS : natural := 77;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 22;
			N_DOUBLESWITCHES : natural := 1;
			N : natural := 238
		);
		port(
			clock : in std_logic := '0';
			processing :  in std_logic := '0';
			processed :  out std_logic := '0';
			packet :  in hex_array(N-1 downto 0) := (others => '0');
			tracks :  out hex_array(N_TRACKCIRCUITS-1 downto 0) := (others => '0');
			routes : out hex_array(N_ROUTES-1 downto 0);
			signals : out hex_array(N_SIGNALS-1 downto 0);
			levelCrossings : out hex_array(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches : out hex_array(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches : out hex_char;
			reset : in std_logic := '0'
		);
	end entity splitter;
architecture Behavioral of splitter is
begin
	process(processing)
	begin
		if processing = '1' then
			tracks <= packet(46 downto 0);
			routes <= packet(135 downto 47);
			signals <= packet(212 downto 136);
			levelCrossings <= packet(214 downto 213);
			singleSwitches <= packet(236 downto 215);
				doubleSwitches <= packet(237);
		end if;
	end process;
	processed <= processing;
end Behavioral;