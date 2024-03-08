--  route_60.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_60 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne910_state : in nodeStates;
			ne910_command : out routeCommands;
			ne130_state : in nodeStates;
			ne130_command : out routeCommands;
			D10_state : in singleSwitchStates;
			D10_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_60;
architecture Behavioral of route_60 is
begin
	routeState <= '0';
end Behavioral;