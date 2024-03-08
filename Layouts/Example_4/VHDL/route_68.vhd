--  route_68.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_68 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne407_state : in nodeStates;
			ne407_command : out routeCommands;
			ne123_state : in nodeStates;
			ne123_command : out routeCommands;
			ne61_state : in nodeStates;
			ne61_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			ne98_state : in nodeStates;
			ne98_command : out routeCommands;
			D05_state : in singleSwitchStates;
			D05_command : out routeCommands;
			D08_state : in singleSwitchStates;
			D08_command : out routeCommands;
			D16_state : in singleSwitchStates;
			D16_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_68;
architecture Behavioral of route_68 is
begin
	routeState <= '0';
end Behavioral;