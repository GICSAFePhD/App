--  route_90.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_90 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne996_state : in nodeStates;
			ne996_command : out routeCommands;
			ne997_state : in nodeStates;
			ne997_command : out routeCommands;
			ne297_state : in nodeStates;
			ne297_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_90;
architecture Behavioral of route_90 is
begin
	routeState <= '0';
end Behavioral;