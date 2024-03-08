--  route_31.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_31 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			ne106_state : in nodeStates;
			ne106_command : out routeCommands;
			ne4_state : in nodeStates;
			ne4_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_31;
architecture Behavioral of route_31 is
begin
	routeState <= '0';
end Behavioral;