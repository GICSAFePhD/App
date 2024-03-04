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
			ne43_state : in nodeStates;
			ne43_command : out routeCommands;
			ne42_state : in nodeStates;
			ne42_command : out routeCommands;
			Sw19_state : in singleSwitchStates;
			Sw19_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_4;
architecture Behavioral of route_4 is
begin
	routeState <= '0';
end Behavioral;