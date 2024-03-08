--  route_59.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_59 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne135_state : in nodeStates;
			ne135_command : out routeCommands;
			ne127_state : in nodeStates;
			ne127_command : out routeCommands;
			D24_state : in singleSwitchStates;
			D24_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_59;
architecture Behavioral of route_59 is
begin
	routeState <= '0';
end Behavioral;