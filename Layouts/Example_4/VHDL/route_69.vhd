--  route_69.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_69 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne65_state : in nodeStates;
			ne65_command : out routeCommands;
			ne63_state : in nodeStates;
			ne63_command : out routeCommands;
			D18_state : in singleSwitchStates;
			D18_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_69;
architecture Behavioral of route_69 is
begin
	routeState <= '0';
end Behavioral;