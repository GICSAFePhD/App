--  route_16.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity route_16 is
		port(
			clock : in std_logic;
			routeRequest : in std_logic;
			ne95_state : in nodeStates;
			ne95_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_16;
architecture Behavioral of route_16 is
begin
	routeState <= '0';
end Behavioral;