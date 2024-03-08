--  route_31.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_31 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc03_command : out routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc04_command : out routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc05_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_31;
architecture Behavioral of route_31 is
begin
	routeState <= '0';
end Behavioral;