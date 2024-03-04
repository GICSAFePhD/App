--  levelCrossing.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity levelCrossing is
		port(
			clock : in std_logic;
			indication : in std_logic;
			command_in : in std_logic;
			command_out : out std_logic;
			correspondence : out std_logic
		);
	end entity levelCrossing;
architecture Behavioral of levelCrossing is
begin
	command_out <= command_in;
	correspondence <= indication;
end Behavioral;