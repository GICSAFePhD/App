--  route_32.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_32 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne992_state : in nodeStates;
			ne992_command : out routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc03_command : out routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc05_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_32;
architecture Behavioral of route_32 is
begin
	routeState <= '0';
end Behavioral;