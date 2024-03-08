--  route_42.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_42 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne295_state : in nodeStates;
			ne295_command : out routeCommands;
			ne288_state : in nodeStates;
			ne288_command : out routeCommands;
			ne991_state : in nodeStates;
			ne991_command : out routeCommands;
			D01_state : in singleSwitchStates;
			D01_command : out routeCommands;
			D03_state : in singleSwitchStates;
			D03_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_42;
architecture Behavioral of route_42 is
begin
	routeState <= '0';
end Behavioral;