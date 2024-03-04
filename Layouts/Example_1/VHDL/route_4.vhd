--  route_4.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_4 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne22_state : in nodeStates;
			ne22_command : out routeCommands;
			ne8_state : in nodeStates;
			ne8_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_4;
architecture Behavioral of route_4 is
begin
	routeState <= '0';
end Behavioral;