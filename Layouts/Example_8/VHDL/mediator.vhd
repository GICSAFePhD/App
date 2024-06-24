--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N_TRACKCIRCUITS : natural := 5;
			N_ROUTES : natural := 13;
			N_SIGNALS : natural := 16;
			N_LEVELCROSSINGS : natural := 6;
			N_SINGLESWITCHES : natural := 2;
			N : natural := 42
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
			output : out hex_array(N-1 downto 0);
			reset : in std_logic
		);
	end entity mediator;
architecture Behavioral of mediator is
begin
	process(processing)
	begin
		if (processing = '1') then
			output(4 downto 0) <= tracks;
			output(17 downto 5) <= routes;
			output(33 downto 18) <= signals;
			output(39 downto 34) <= levelCrossings;
			output(41 downto 40) <= singleSwitches;
		end if;
	end process;
	processed <= processing;
end Behavioral;