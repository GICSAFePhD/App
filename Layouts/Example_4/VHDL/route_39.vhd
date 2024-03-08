--  route_39.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_39 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			ne910_state : in nodeStates;
			ne910_command : out routeCommands;
			D09_state : in singleSwitchStates;
			D09_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_39;
architecture Behavioral of route_39 is
begin
	routeState <= '0';
end Behavioral;