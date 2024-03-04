--  route_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			ne40_state : in nodeStates;
			ne40_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw14_state : in singleSwitchStates;
			Sw14_command : out routeCommands;
			Sw18_state : in singleSwitchStates;
			Sw18_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_2;
architecture Behavioral of route_2 is
begin
	routeState <= '0';
end Behavioral;