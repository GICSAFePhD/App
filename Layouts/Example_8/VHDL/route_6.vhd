--  route_6.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_6 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne3_state : in nodeStates;
			ne3_command : out routeCommands;
			Lc06_state : in levelCrossingStates;
			Lc06_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_6;
architecture Behavioral of route_6 is
begin
	routeState <= '0';
end Behavioral;