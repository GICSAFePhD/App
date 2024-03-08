--  route_62.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_62 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne993_state : in nodeStates;
			ne993_command : out routeCommands;
			ne400_state : in nodeStates;
			ne400_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_62;
architecture Behavioral of route_62 is
begin
	routeState <= '0';
end Behavioral;