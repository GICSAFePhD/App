--  route_53.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_53 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			ne29_state : in nodeStates;
			ne29_command : out routeCommands;
			ne110_state : in nodeStates;
			ne110_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			Sw09_state : in singleSwitchStates;
			Sw09_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_53;
architecture Behavioral of route_53 is
begin
	routeState <= '0';
end Behavioral;