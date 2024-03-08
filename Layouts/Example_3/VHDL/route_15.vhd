--  route_15.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_15 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne93_state : in nodeStates;
			ne93_command : out routeCommands;
			ne96_state : in nodeStates;
			ne96_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_15;
architecture Behavioral of route_15 is
begin
	routeState <= '0';
end Behavioral;