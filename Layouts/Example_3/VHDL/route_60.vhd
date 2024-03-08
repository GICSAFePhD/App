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
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			ne43_state : in nodeStates;
			ne43_command : out routeCommands;
			ne48_state : in nodeStates;
			ne48_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_command : out routeCommands;
			s71W02_state : in singleSwitchStates;
			s71W02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_60;
architecture Behavioral of route_60 is
begin
	routeState <= '0';
end Behavioral;