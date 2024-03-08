--  route_17.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_17 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne97_state : in nodeStates;
			ne97_command : out routeCommands;
			ne94_state : in nodeStates;
			ne94_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_17;
architecture Behavioral of route_17 is
begin
	routeState <= '0';
end Behavioral;