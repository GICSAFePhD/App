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
			ne24_state : in nodeStates;
			ne24_command : out routeCommands;
			ne64_state : in nodeStates;
			ne64_command : out routeCommands;
			ne103_state : in nodeStates;
			ne103_command : out routeCommands;
			s70W01_state : in singleSwitchStates;
			s70W01_command : out routeCommands;
			routeState : out std_logic
		);
	end entity route_27;
architecture Behavioral of route_27 is
begin
	routeState <= '0';
end Behavioral;