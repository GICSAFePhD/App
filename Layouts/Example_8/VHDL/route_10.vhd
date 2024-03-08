--  route_10.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_10 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc04_command : out routeCommands;
			Sw12_state : in singleSwitchStates;
			Sw12_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_10;
architecture Behavioral of route_10 is
begin
	routeState <= '0';
end Behavioral;