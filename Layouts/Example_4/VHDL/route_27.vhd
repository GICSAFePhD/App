--  route_27.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_27 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne132_state : in nodeStates;
			ne132_command : out routeCommands;
			ne912_state : in nodeStates;
			ne912_command : out routeCommands;
			D20_state : in singleSwitchStates;
			D20_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_27;
architecture Behavioral of route_27 is
begin
	routeState <= '0';
end Behavioral;