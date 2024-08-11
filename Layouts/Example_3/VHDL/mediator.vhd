--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity mediator is
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
			output : out hex_array(N-1 downto 0);
			reset : in std_logic
		);
	end entity mediator;
architecture Behavioral of mediator is
begin
	process(processing)
	begin
		if (processing = '1') then
			output(52 downto 0) <= tracks;
			output(143 downto 53) <= routes;
			output(225 downto 144) <= signals;
			output(226) <= levelCrossings;
			output(241 downto 227) <= singleSwitches;
			output(243 downto 242) <= doubleSwitches;
			output(244) <= scissorCrossings;
		end if;
	end process;
	processed <= processing;
end Behavioral;