--  route_71.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_71 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne63_state : in nodeStates;
			ne63_command : out routeCommands;
			ne124_state : in nodeStates;
			ne124_command : out routeCommands;
			ne421_state : in nodeStates;
			ne421_command : out routeCommands;
			D18_state : in singleSwitchStates;
			D18_command : out routeCommands;
			D19_state : in singleSwitchStates;
			D19_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_71;
architecture Behavioral of route_71 is
begin
	routeState <= '0';
end Behavioral;