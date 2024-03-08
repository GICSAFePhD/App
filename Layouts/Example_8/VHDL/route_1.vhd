--  route_1.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_1 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne26_state : in nodeStates;
			ne26_command : out routeCommands;
			Lc03_state : in levelCrossingStates;
			Lc03_command : out routeCommands;
			Lc04_state : in levelCrossingStates;
			Lc04_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_1;
architecture Behavioral of route_1 is
begin
	routeState <= '0';
end Behavioral;