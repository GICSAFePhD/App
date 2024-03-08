--  route_44.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_44 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			ne14_state : in nodeStates;
			ne14_command : out routeCommands;
			s69W04_state : in singleSwitchStates;
			s69W04_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_44;
architecture Behavioral of route_44 is
begin
	routeState <= '0';
end Behavioral;