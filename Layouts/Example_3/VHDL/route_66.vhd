--  route_66.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_66 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne83_state : in nodeStates;
			ne83_command : out routeCommands;
			ne32_state : in nodeStates;
			ne32_command : out routeCommands;
			Sw04_state : in singleSwitchStates;
			Sw04_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_66;
architecture Behavioral of route_66 is
begin
	routeState <= '0';
end Behavioral;