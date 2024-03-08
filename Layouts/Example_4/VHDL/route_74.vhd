--  route_74.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_74 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne114_state : in nodeStates;
			ne114_command : out routeCommands;
			ne129_state : in nodeStates;
			ne129_command : out routeCommands;
			ne130_state : in nodeStates;
			ne130_command : out routeCommands;
			D23_state : in singleSwitchStates;
			D23_command : out routeCommands;
			D12__state : in singleSwitchStates;
			D12__command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_74;
architecture Behavioral of route_74 is
begin
	routeState <= '0';
end Behavioral;