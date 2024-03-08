--  route_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_3;
architecture Behavioral of route_3 is
begin
	routeState <= '0';
end Behavioral;