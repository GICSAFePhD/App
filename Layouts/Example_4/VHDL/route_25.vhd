--  route_25.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_25 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne912_state : in nodeStates;
			ne912_command : out routeCommands;
			ne101_state : in nodeStates;
			ne101_command : out routeCommands;
			D09_state : in singleSwitchStates;
			D09_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_25;
architecture Behavioral of route_25 is
begin
	routeState <= '0';
end Behavioral;