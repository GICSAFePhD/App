--  doubleSwitch.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity doubleSwitch is
		port(
			clock : in std_logic;
			indication : in dSwitch_type;
			command_in : in dSwitch_type;
			command_out : out dSwitch_type;
			correspondence : out dSwitch_type
		);
	end entity doubleSwitch;
architecture Behavioral of doubleSwitch is
begin
	command_out <= command_in;
	correspondence <= indication;
end Behavioral;