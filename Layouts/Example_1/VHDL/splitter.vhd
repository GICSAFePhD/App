--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N_TRACKCIRCUITS : natural := 11;
			N_ROUTES : natural := 21;
			N_SIGNALS : natural := 23;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 5;
			N : natural := 62
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
			tracks <= packet(10 downto 0);
			routes <= packet(31 downto 11);
			signals <= packet(54 downto 32);
			levelCrossings <= packet(56 downto 55);
			singleSwitches <= packet(61 downto 57);
		end if;
	end process;
	processed <= processing;
end Behavioral;