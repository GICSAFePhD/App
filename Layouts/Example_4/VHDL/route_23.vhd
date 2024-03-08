--  route_23.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_23 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne992_state : in nodeStates;
			ne992_command : out routeCommands;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_23;
architecture Behavioral of route_23 is
begin
	routeState <= '0';
end Behavioral;