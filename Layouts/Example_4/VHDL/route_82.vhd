--  route_82.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_82 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne127_state : in nodeStates;
			ne127_command : out routeCommands;
			ne134_state : in nodeStates;
			ne134_command : out routeCommands;
			D24_state : in singleSwitchStates;
			D24_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_82;
architecture Behavioral of route_82 is
begin
	routeState <= '0';
end Behavioral;