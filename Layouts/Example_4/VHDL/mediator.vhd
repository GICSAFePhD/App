--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity mediator is
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
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			tracks :  in hex_array(N_TRACKCIRCUITS-1 downto 0);
			routes : in hex_array(N_ROUTES-1 downto 0);
			signals : in hex_array(N_SIGNALS-1 downto 0);
			levelCrossings : in hex_array(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches : in hex_array(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches : in hex_char;
			output : out hex_array(N-1 downto 0);
			reset : in std_logic
		);
	end entity mediator;
architecture Behavioral of mediator is
begin
	process(processing)
	begin
		if (processing = '1') then
			output(46 downto 0) <= tracks;
			output(135 downto 47) <= routes;
			output(212 downto 136) <= signals;
			output(214 downto 213) <= levelCrossings;
			output(236 downto 215) <= singleSwitches;
			output(237) <= doubleSwitches;
		end if;
	end process;
	processed <= processing;
end Behavioral;