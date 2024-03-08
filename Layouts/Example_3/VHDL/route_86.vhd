--  route_86.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_86 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne104_state : in nodeStates;
			ne104_command : out routeCommands;
			ne70_state : in nodeStates;
			ne70_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_86;
architecture Behavioral of route_86 is
begin
	routeState <= '0';
end Behavioral;