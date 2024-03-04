--  my_package.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	package my_package is
		type signals_type is record
			msb : std_logic_vector(82-1 downto 0);
			lsb : std_logic_vector(82-1 downto 0);
		end record signals_type;
		type signal_type is record
			msb : std_logic;
			lsb : std_logic;
		end record signal_type;
		type dSwitches_type is record
			msb : std_logic_vector(8-1 downto 0);
			lsb : std_logic_vector(8-1 downto 0);
		end record dSwitches_type;
		type dSwitch_type is record
			msb : std_logic;
			lsb : std_logic;
		end record dSwitch_type;
	end my_package;