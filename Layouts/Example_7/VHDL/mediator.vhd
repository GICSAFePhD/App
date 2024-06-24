--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N_TRACKCIRCUITS : natural := 7;
			N_ROUTES : natural := 11;
			N_SIGNALS : natural := 13;
			N_SINGLESWITCHES : natural := 3;
			N : natural := 34
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			tracks :  in hex_array(N_TRACKCIRCUITS-1 downto 0);
			routes : in hex_array(N_ROUTES-1 downto 0);
			signals : in hex_array(N_SIGNALS-1 downto 0);
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
			output(6 downto 0) <= tracks;
			output(17 downto 7) <= routes;
			output(30 downto 18) <= signals;
			output(33 downto 31) <= singleSwitches;
		end if;
	end process;
	processed <= processing;
end Behavioral;