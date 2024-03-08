--  route_36.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_36 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			ne94_state : in nodeStates;
			ne94_command : out routeCommands;
			ne97_state : in nodeStates;
			ne97_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_36;
architecture Behavioral of route_36 is
begin
	routeState <= '0';
end Behavioral;