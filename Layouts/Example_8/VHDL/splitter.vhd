--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N_TRACKCIRCUITS : natural := 5;
			N_ROUTES : natural := 13;
			N_SIGNALS : natural := 16;
			N_LEVELCROSSINGS : natural := 6;
			N_SINGLESWITCHES : natural := 2;
			N : natural := 42
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
			reset : in std_logic := '0'
		);
	end entity splitter;
architecture Behavioral of splitter is
begin
	process(processing)
	begin
		if processing = '1' then
			tracks <= packet(4 downto 0);
			routes <= packet(17 downto 5);
			signals <= packet(33 downto 18);
			levelCrossings <= packet(39 downto 34);
			singleSwitches <= packet(41 downto 40);
		end if;
	end process;
	processed <= processing;
end Behavioral;