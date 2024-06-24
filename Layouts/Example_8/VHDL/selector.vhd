--  selector.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
	entity selector is
		port(
			clock : in std_logic;
			selector : in std_logic;
			leds : out std_logic_vector(4-1 downto 0);
			wr_uart_1 : in std_logic;
			wr_uart_2 : in std_logic;
			wr_uart_3 : out std_logic;
			w_data_1 : in std_logic_vector(8-1 downto 0);
			w_data_2 : in std_logic_vector(8-1 downto 0);
			w_data_3 : out std_logic_vector(8-1 downto 0);
			reset : in std_logic
		);
	end entity selector;
architecture Behavioral of selector is
	signal disp_aux : std_logic_vector(8-1 downto 0);
begin
	selectors : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				w_data_3 <= "00000000";
				wr_uart_3 <= '0';
			else
				if selector = '1' then
					disp_aux <= w_data_2;
					w_data_3 <= disp_aux;
					wr_uart_3 <= wr_uart_2;
					leds <= "0010";
				else
					disp_aux <= w_data_1;
					w_data_3 <= disp_aux;
					wr_uart_3 <= wr_uart_1;
					leds <= "0001";
				end if;
			end if;
		end if;
	end process;
end Behavioral;