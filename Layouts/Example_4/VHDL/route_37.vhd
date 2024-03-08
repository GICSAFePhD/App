--  route_37.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_37 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			ne63_state : in nodeStates;
			ne63_command : out routeCommands;
			D05_state : in singleSwitchStates;
			D05_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_37;
architecture Behavioral of route_37 is
begin
	routeState <= '0';
end Behavioral;