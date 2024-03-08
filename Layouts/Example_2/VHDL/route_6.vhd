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
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			ne18_state : in nodeStates;
			ne18_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_6;
architecture Behavioral of route_6 is
begin
	routeState <= '0';
end Behavioral;