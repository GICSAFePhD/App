--  railwaySignal.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity railwaySignal is
		port(
			clock : in std_logic;
			indication : in signal_type;
			command_in : in signal_type;
			command_out : out signal_type;
			correspondence : out signal_type
		);
	end entity railwaySignal;
architecture Behavioral of railwaySignal is
begin
	command_out <= command_in;
	correspondence <= indication;
end Behavioral;