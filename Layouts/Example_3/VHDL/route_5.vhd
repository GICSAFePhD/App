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
			ne84_state : in nodeStates;
			ne84_command : out routeCommands;
			ne85_state : in nodeStates;
			ne85_command : out routeCommands;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_5;
architecture Behavioral of route_5 is
begin
	routeState <= '0';
end Behavioral;