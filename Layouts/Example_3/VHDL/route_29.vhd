--  route_29.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_29 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne67_state : in nodeStates;
			ne67_command : out routeCommands;
			ne103_state : in nodeStates;
			ne103_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_29;
architecture Behavioral of route_29 is
begin
	routeState <= '0';
end Behavioral;