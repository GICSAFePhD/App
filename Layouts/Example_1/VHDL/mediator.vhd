--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N_TRACKCIRCUITS : natural := 11;
			N_ROUTES : natural := 21;
			N_SIGNALS : natural := 23;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 5;
			N : natural := 62
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
			output(10 downto 0) <= tracks;
			output(31 downto 11) <= routes;
			output(54 downto 32) <= signals;
			output(56 downto 55) <= levelCrossings;
			output(61 downto 57) <= singleSwitches;
		end if;
	end process;
	processed <= processing;
end Behavioral;