--  route_2.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_2 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne10_state : in nodeStates;
			ne10_command : out routeCommands;
			ne5_state : in nodeStates;
			ne5_command : out routeCommands;
			Sw05_state : in singleSwitchStates;
			Sw05_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_2;
architecture Behavioral of route_2 is
begin
	routeState <= '0';
end Behavioral;