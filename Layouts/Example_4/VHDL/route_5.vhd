--  route_5.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_5 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne450_state : in nodeStates;
			ne450_command : out routeCommands;
			ne127_state : in nodeStates;
			ne127_command : out routeCommands;
			D12__state : in singleSwitchStates;
			D12__command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_5;
architecture Behavioral of route_5 is
begin
	routeState <= '0';
end Behavioral;