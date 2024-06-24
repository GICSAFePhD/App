--  global.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
	entity global is
		port(
			clock : in std_logic;
			uart_rxd_i : in std_logic;
			uart_txd_o : out std_logic;
			leds : out std_logic_vector(4-1 downto 0);
			rgb_1 : out std_logic_vector(3-1 downto 0);
			rgb_2 : out std_logic_vector(3-1 downto 0);
			selector1 : in std_logic;
			selector2 : in std_logic;
			reset : in std_logic
		);
	end entity global;
architecture Behavioral of global is
	component uartControl is
		port(
			clock : in std_logic;
			N : out integer;
			write : in std_logic;
			empty_in : in std_logic;
			rd_uart : out std_logic;
			wr_uart : out std_logic;
			reset : in std_logic
		);
	end component uartControl;
	component system is
		port(
			clock : in std_logic;
			reset_uart : out std_logic;
			r_available : in std_logic;
			write : out std_logic;
			r_data : in std_logic_vector(8-1 downto 0);
			selector1 : in std_logic;
			selector2 : in std_logic;
			N : in integer;
			leds : out std_logic_vector(4-1 downto 0);
			led_rgb_1 : out std_logic_vector(3-1 downto 0);
			led_rgb_2 : out std_logic_vector(3-1 downto 0);
			w_data : out std_logic_vector(8-1 downto 0);
			reset : in std_logic
		);
	end component system;
	signal w_data_signal, r_dataSignal: std_logic_vector(7 downto 0);
	signal rd_uart_signal, wr_uart_signal: std_logic;
	signal emptySignal,empty_s,tx_empty_s,switch_s,reset_s,reset_uart: std_logic;
	signal led_s : std_logic_vector(4-1 downto 0);
	signal led_rgb_1,led_rgb_2 : std_logic_vector(3-1 downto 0);
	signal N_s : integer;
	signal read_s,write_s : std_logic;
begin
	uart_inst : entity work.uart
		generic map(
			DVSR      => 407,	-- baud rate divisor DVSR = 125M / (16 * baud rate) baud rate = 19200
			DVSR_BIT  => 9,   --  bits of DVSR
			FIFO_W_RX	=> 7, 	--  addr bits of FIFO words in FIFO=2^FIFO_W
			FIFO_W_TX	=> 7 	--  addr bits of FIFO words in FIFO=2^FIFO_W
		)
		port map(
			clk 		=> clock,
			reset 		=> reset,
			rd_uart 	=> rd_uart_signal,
			wr_uart 	=> wr_uart_signal,
			rx 			=> uart_rxd_i,
			w_data 		=> w_data_signal,
			rx_empty	=> emptySignal,
			r_data  	=> r_dataSignal,
			tx  		=> uart_txd_o
		);
	uartControl_i : uartControl
		port map(
			clock => clock,
			reset => reset_uart,
			N => N_s,
			write => write_s,
			empty_in => emptySignal,
			rd_uart => rd_uart_signal,
			wr_uart => wr_uart_signal
		);
	system_i : system
		port map(
			clock => clock,
			reset => reset,
			reset_uart => reset_s,
			r_available => rd_uart_signal,
			write => write_s,
			r_data => r_dataSignal,
			selector1 => selector1,
			selector2 => selector2,
			N => N_s,
			leds => led_s,
			led_rgb_1 => led_rgb_1,
			led_rgb_2 => led_rgb_2,
			w_data => w_data_signal
		);
	rgb_1 <= led_rgb_1;
	rgb_2 <= led_rgb_2;
	leds <= led_s;
	reset_uart <= Reset or reset_s;
end Behavioral;