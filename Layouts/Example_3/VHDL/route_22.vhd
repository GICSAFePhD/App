--  route_22.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_22 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne7_state : in nodeStates;
			ne7_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			s68W02_state : in singleSwitchStates;
			s68W02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_22;
architecture Behavioral of route_22 is
begin
	routeState <= '0';
end Behavioral;