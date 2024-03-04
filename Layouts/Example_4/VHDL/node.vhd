--  node.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity node is
		port(
			clock : in std_logic;
			ocupation : in std_logic;
			out_test : out std_logic
		);
	end entity node;
architecture Behavioral of node is
begin
	out_test <= ocupation;
end Behavioral;