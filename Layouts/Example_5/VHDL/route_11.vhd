--  route_11.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_11 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne03_state : in nodeStates;
			ne03_command : out routeCommands;
			ne04_state : in nodeStates;
			ne04_command : out routeCommands;
			Sw02_state : in singleSwitchStates;
			Sw02_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_11;
architecture Behavioral of route_11 is
begin
	routeState <= '0';
end Behavioral;