--  route_9.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_9 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			ne1_state : in nodeStates;
			ne1_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_9;
architecture Behavioral of route_9 is
begin
	routeState <= '0';
end Behavioral;