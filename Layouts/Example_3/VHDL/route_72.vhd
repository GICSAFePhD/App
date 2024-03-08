--  route_72.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_72 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne86_state : in nodeStates;
			ne86_command : out routeCommands;
			ne87_state : in nodeStates;
			ne87_command : out routeCommands;
			ne91_state : in nodeStates;
			ne91_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			Sw13_state : in singleSwitchStates;
			Sw13_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_72;
architecture Behavioral of route_72 is
begin
	routeState <= '0';
end Behavioral;