--  route_22.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_22 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne996_state : in nodeStates;
			ne996_command : out routeCommands;
			ne98_state : in nodeStates;
			ne98_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_22;
architecture Behavioral of route_22 is
begin
	routeState <= '0';
end Behavioral;