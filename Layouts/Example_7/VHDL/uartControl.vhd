--  uartControl.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
	entity uartControl is
		port(
			clock : in std_logic;
			N : out integer;
			write : in std_logic;
			empty_in : in std_logic;
			rd_uart : out std_logic;
			wr_uart : out std_logic;
			reset : in std_logic
		);
	end entity uartControl;
architecture Behavioral of uartControl is
begin
	reading : process(clock)
		variable count_i: integer := 0;
		variable L : integer := 0;
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				L := 0;
				rd_uart <= '0';
			elsif empty_in = '0' then   -- Data available
				count_i := count_i + 1;
				if count_i = 125E3 then    -- Count 100 msecs
					count_i := 0;
					rd_uart <= '1';     -- Request new data"+"
					L := L + 1;
				else
					rd_uart <= '0';
				end if;
			else                    -- No data
				N <= L;
				rd_uart <= '0';
			end if;
		end if;
	end process;
	writing : process(clock)
		variable count_j: integer := 0;
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				wr_uart <= '0';
			else
				wr_uart <= write;
			end if;
		end if;
	end process;
end Behavioral;