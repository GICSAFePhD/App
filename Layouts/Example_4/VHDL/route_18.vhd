--  route_18.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_18 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne100_state : in nodeStates;
			ne100_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_18;
architecture Behavioral of route_18 is
begin
	routeState <= '0';
end Behavioral;