--  route_13.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_13 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne12_state : in nodeStates;
			ne12_command : out routeCommands;
			ne2_state : in nodeStates;
			ne2_command : out routeCommands;
			Sw06_state : in singleSwitchStates;
			Sw06_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_13;
architecture Behavioral of route_13 is
begin
	routeState <= '0';
end Behavioral;