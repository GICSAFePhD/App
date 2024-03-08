--  route_46.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_46 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne64_state : in nodeStates;
			ne64_command : out routeCommands;
			ne23_state : in nodeStates;
			ne23_command : out routeCommands;
			s70W01_state : in singleSwitchStates;
			s70W01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_46;
architecture Behavioral of route_46 is
begin
	routeState <= '0';
end Behavioral;