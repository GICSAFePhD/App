--  route_25.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_25 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			ne9_state : in nodeStates;
			ne9_command : out routeCommands;
			Lc01_state : in levelCrossingStates;
			Lc01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_25;
architecture Behavioral of route_25 is
begin
	routeState <= '0';
end Behavioral;