--  route_32.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_32 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne96_state : in nodeStates;
			ne96_command : out routeCommands;
			ne93_state : in nodeStates;
			ne93_command : out routeCommands;
			ne78_state : in nodeStates;
			ne78_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_32;
architecture Behavioral of route_32 is
begin
	routeState <= '0';
end Behavioral;