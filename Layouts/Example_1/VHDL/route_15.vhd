--  route_15.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_15 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			ne13_state : in nodeStates;
			ne13_command : out routeCommands;
			Lc08_state : in levelCrossingStates;
			Lc08_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_15;
architecture Behavioral of route_15 is
begin
	routeState <= '0';
end Behavioral;