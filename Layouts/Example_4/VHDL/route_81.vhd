--  route_81.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_81 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne127_state : in nodeStates;
			ne127_command : out routeCommands;
			ne135_state : in nodeStates;
			ne135_command : out routeCommands;
			ne910_state : in nodeStates;
			ne910_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			D09_state : in singleSwitchStates;
			D09_command : out routeCommands;
			D10_state : in singleSwitchStates;
			D10_command : out routeCommands;
			D24_state : in singleSwitchStates;
			D24_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_81;
architecture Behavioral of route_81 is
begin
	routeState <= '0';
end Behavioral;