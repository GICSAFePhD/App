--  route_65.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_65 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			ne79_state : in nodeStates;
			ne79_command : out routeCommands;
			ne21_state : in nodeStates;
			ne21_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			Sw07_state : in singleSwitchStates;
			Sw07_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_65;
architecture Behavioral of route_65 is
begin
	routeState <= '0';
end Behavioral;