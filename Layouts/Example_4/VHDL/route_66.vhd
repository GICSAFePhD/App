--  route_66.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_66 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne290_state : in nodeStates;
			ne290_command : out routeCommands;
			ne111_state : in nodeStates;
			ne111_command : out routeCommands;
			ne377_state : in nodeStates;
			ne377_command : out routeCommands;
			D14_state : in singleSwitchStates;
			D14_command : out routeCommands;
			D15_state : in singleSwitchStates;
			D15_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_66;
architecture Behavioral of route_66 is
begin
	routeState <= '0';
end Behavioral;