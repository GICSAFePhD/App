--  route_29.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_29 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne98_state : in nodeStates;
			ne98_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Lc02_state : in levelCrossingStates;
			Lc02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_29;
architecture Behavioral of route_29 is
begin
	routeState <= '0';
end Behavioral;