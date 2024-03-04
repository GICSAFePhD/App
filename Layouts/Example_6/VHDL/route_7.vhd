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
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			ne41_state : in nodeStates;
			ne41_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_7;
architecture Behavioral of route_7 is
begin
	routeState <= '0';
end Behavioral;