--  route_88.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_88 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne77_state : in nodeStates;
			ne77_command : out routeCommands;
			ne79_state : in nodeStates;
			ne79_command : out routeCommands;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_88;
architecture Behavioral of route_88 is
begin
	routeState <= '0';
end Behavioral;