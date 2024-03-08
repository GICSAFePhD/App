--  route_21.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_21 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne106_state : in nodeStates;
			ne106_command : out routeCommands;
			ne99_state : in nodeStates;
			ne99_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_21;
architecture Behavioral of route_21 is
begin
	routeState <= '0';
end Behavioral;