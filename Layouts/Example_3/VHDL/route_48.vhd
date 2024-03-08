--  route_48.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_48 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne24_state : in nodeStates;
			ne24_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_48;
architecture Behavioral of route_48 is
begin
	routeState <= '0';
end Behavioral;