--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne18_state : in nodeStates;
			ne18_command : out routeCommands;
			ne16_state : in nodeStates;
			ne16_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_5;
architecture Behavioral of route_5 is
begin
	routeState <= '0';
end Behavioral;