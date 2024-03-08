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
			ne421_state : in nodeStates;
			ne421_command : out routeCommands;
			ne126_state : in nodeStates;
			ne126_command : out routeCommands;
			D19_state : in singleSwitchStates;
			D19_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_4;
architecture Behavioral of route_4 is
begin
	routeState <= '0';
end Behavioral;