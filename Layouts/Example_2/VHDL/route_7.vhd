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
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			ne20_state : in nodeStates;
			ne20_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_7;
architecture Behavioral of route_7 is
begin
	routeState <= '0';
end Behavioral;