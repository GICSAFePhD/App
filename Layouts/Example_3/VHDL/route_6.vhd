--  route_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne89_state : in nodeStates;
			ne89_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_6;
architecture Behavioral of route_6 is
begin
	routeState <= '0';
end Behavioral;