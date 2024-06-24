--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N_TRACKCIRCUITS : natural := 7;
			N_ROUTES : natural := 10;
			N_SIGNALS : natural := 12;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 3;
			N : natural := 33
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
			reset : in std_logic := '0'
		);
	end entity splitter;
architecture Behavioral of splitter is
begin
	process(processing)
	begin
		if processing = '1' then
			tracks <= packet(6 downto 0);
			routes <= packet(16 downto 7);
			signals <= packet(28 downto 17);
			levelCrossings <= packet(29);
			singleSwitches <= packet(32 downto 30);
		end if;
	end process;
	processed <= processing;
end Behavioral;