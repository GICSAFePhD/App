--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne25_state : in nodeStates;
			ne25_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			Lc05_state : in levelCrossingStates;
			Lc05_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_5;
architecture Behavioral of route_5 is
begin
	routeState <= '0';
end Behavioral;