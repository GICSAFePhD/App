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
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			ne43_state : in nodeStates;
			ne43_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_10;
architecture Behavioral of route_10 is
begin
	routeState <= '0';
end Behavioral;