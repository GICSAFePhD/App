--  route_8.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_8 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne105_state : in nodeStates;
			ne105_command : out routeCommands;
			ne98_state : in nodeStates;
			ne98_command : out routeCommands;
			ne96_state : in nodeStates;
			ne96_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_8;
architecture Behavioral of route_8 is
begin
	routeState <= '0';
end Behavioral;