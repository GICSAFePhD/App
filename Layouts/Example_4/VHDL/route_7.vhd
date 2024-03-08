--  route_7.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_7 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne465_state : in nodeStates;
			ne465_command : out routeCommands;
			ne131_state : in nodeStates;
			ne131_command : out routeCommands;
			ne912_state : in nodeStates;
			ne912_command : out routeCommands;
			D20_state : in singleSwitchStates;
			D20_command : out routeCommands;
			D21_state : in singleSwitchStates;
			D21_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_7;
architecture Behavioral of route_7 is
begin
	routeState <= '0';
end Behavioral;