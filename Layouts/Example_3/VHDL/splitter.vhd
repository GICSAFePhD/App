--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity splitter is
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
			clock : in std_logic := '0';
			processing :  in std_logic := '0';
			processed :  out std_logic := '0';
			packet :  in hex_array(N-1 downto 0) := (others => '0');
			tracks :  out hex_array(N_TRACKCIRCUITS-1 downto 0) := (others => '0');
			routes : out hex_array(N_ROUTES-1 downto 0);
			signals : out hex_array(N_SIGNALS-1 downto 0);
			levelCrossings : out hex_char;
			singleSwitches : out hex_array(N_SINGLESWITCHES-1 downto 0);
			scissorCrossings : out hex_char;
			doubleSwitches : out hex_array(N_DOUBLESWITCHES-1 downto 0);
			reset : in std_logic := '0'
		);
	end entity splitter;
architecture Behavioral of splitter is
begin
	process(processing)
	begin
		if processing = '1' then
			tracks <= packet(52 downto 0);
			routes <= packet(143 downto 53);
			signals <= packet(225 downto 144);
			levelCrossings <= packet(226);
			singleSwitches <= packet(241 downto 227);
			doubleSwitches <= packet(243 downto 242);
			scissorCrossings <= packet(244);
		end if;
	end process;
	processed <= processing;
end Behavioral;