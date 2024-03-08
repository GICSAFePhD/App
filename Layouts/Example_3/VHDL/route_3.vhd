--  route_3.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_3 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne47_state : in nodeStates;
			ne47_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_command : out routeCommands;
			s71W02_state : in singleSwitchStates;
			s71W02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_3;
architecture Behavioral of route_3 is
begin
	routeState <= '0';
end Behavioral;