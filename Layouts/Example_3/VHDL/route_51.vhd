--  route_51.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_51 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne83_state : in nodeStates;
			ne83_command : out routeCommands;
			ne30_state : in nodeStates;
			ne30_command : out routeCommands;
			Sw08_state : in singleSwitchStates;
			Sw08_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_51;
architecture Behavioral of route_51 is
begin
	routeState <= '0';
end Behavioral;