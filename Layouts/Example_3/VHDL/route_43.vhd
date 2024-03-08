--  route_43.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_43 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne52_state : in nodeStates;
			ne52_command : out routeCommands;
			ne11_state : in nodeStates;
			ne11_command : out routeCommands;
			ne59_state : in nodeStates;
			ne59_command : out routeCommands;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			s69W03_state : in singleSwitchStates;
			s69W03_command : out routeCommands;
			s69W04_state : in singleSwitchStates;
			s69W04_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_43;
architecture Behavioral of route_43 is
begin
	routeState <= '0';
end Behavioral;