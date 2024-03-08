--  route_59.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_59 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne102_state : in nodeStates;
			ne102_command : out routeCommands;
			ne44_state : in nodeStates;
			ne44_command : out routeCommands;
			s71W01_state : in singleSwitchStates;
			s71W01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_59;
architecture Behavioral of route_59 is
begin
	routeState <= '0';
end Behavioral;