--  route_13.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_13 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne70_state : in nodeStates;
			ne70_command : out routeCommands;
			ne104_state : in nodeStates;
			ne104_command : out routeCommands;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			Sw03_state : in singleSwitchStates;
			Sw03_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_13;
architecture Behavioral of route_13 is
begin
	routeState <= '0';
end Behavioral;