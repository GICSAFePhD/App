--  route_63.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_63 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			ne17_state : in nodeStates;
			ne17_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_63;
architecture Behavioral of route_63 is
begin
	routeState <= '0';
end Behavioral;