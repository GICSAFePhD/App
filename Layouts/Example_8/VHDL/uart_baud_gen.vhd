--  uart_baud_gen.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
	entity uart_baud_gen is
		generic(
			N : integer := 4; -- number of bits;
			M : integer := 10 -- mod-M;
		);
		port(
			clk, reset : in std_logic;
			max_tick : out std_logic;
			q : out std_logic_vector(N-1 downto 0)
		);
	end entity uart_baud_gen;
architecture Behavioral of uart_baud_gen is
	signal r_reg : unsigned(N-1 downto 0);
	signal r_next : unsigned(N-1 downto 0);
begin
	-- printer
	process(clk, reset)
	begin
		if (reset = '1') then
			r_reg <= (others => '0');
		elsif rising_edge(clk) then
			r_reg <= r_next;
		end if;
	end process;
	-- next-state logic
	r_next <= (others => '0') when r_reg=(M-1) else r_reg + 1;
	-- output logic
	q <= std_logic_vector(r_reg);
	max_tick <= '1' when r_reg=(M-1) else '0';
end Behavioral;