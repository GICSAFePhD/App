--  route_70.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_70 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne88_state : in nodeStates;
			ne88_command : out routeCommands;
			ne86_state : in nodeStates;
			ne86_command : out routeCommands;
			Sw11_state : in singleSwitchStates;
			Sw11_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_70;
architecture Behavioral of route_70 is
begin
	routeState <= '0';
end Behavioral;