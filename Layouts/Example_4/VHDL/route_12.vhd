--  route_12.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_12 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne122_state : in nodeStates;
			ne122_command : out routeCommands;
			ne407_state : in nodeStates;
			ne407_command : out routeCommands;
			ne400_state : in nodeStates;
			ne400_command : out routeCommands;
			D07_state : in singleSwitchStates;
			D07_command : out routeCommands;
			D16_state : in singleSwitchStates;
			D16_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_12;
architecture Behavioral of route_12 is
begin
	routeState <= '0';
end Behavioral;