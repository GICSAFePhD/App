--  route_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			ne27_state : in nodeStates;
			ne27_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Lc09_state : in levelCrossingStates;
			Lc09_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_9;
architecture Behavioral of route_9 is
begin
	routeState <= '0';
end Behavioral;