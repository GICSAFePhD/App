--  route_83.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_83 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne65_state : in nodeStates;
			ne65_command : out routeCommands;
			ne992_state : in nodeStates;
			ne992_command : out routeCommands;
			Sw01_state : in singleSwitchStates;
			Sw01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_83;
architecture Behavioral of route_83 is
begin
	routeState <= '0';
end Behavioral;