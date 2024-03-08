--  route_85.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_85 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			ne85_state : in nodeStates;
			ne85_command : out routeCommands;
			Sw41_state : in singleSwitchStates;
			Sw41_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_85;
architecture Behavioral of route_85 is
begin
	routeState <= '0';
end Behavioral;