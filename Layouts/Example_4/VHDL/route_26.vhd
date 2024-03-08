--  route_26.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_26 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne132_state : in nodeStates;
			ne132_command : out routeCommands;
			ne114_state : in nodeStates;
			ne114_command : out routeCommands;
			D23_state : in singleSwitchStates;
			D23_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_26;
architecture Behavioral of route_26 is
begin
	routeState <= '0';
end Behavioral;