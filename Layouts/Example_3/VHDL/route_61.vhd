--  route_61.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_61 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			ne102_state : in nodeStates;
			ne102_command : out routeCommands;
			ne65_state : in nodeStates;
			ne65_command : out routeCommands;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_61;
architecture Behavioral of route_61 is
begin
	routeState <= '0';
end Behavioral;