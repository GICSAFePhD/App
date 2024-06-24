--  system.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity system is
		port(
			clock :  in std_logic;
			r_data :  in std_logic_vector(8-1 downto 0);
			r_available :  in std_logic;
			write :  out std_logic;
			selector1 :  in std_logic;
			selector2 :  in std_logic;
			reset_uart :  out std_logic;
			N :  in integer;
			leds :  out std_logic_vector(4-1 downto 0);
			led_rgb_1 :  out std_logic_vector(3-1 downto 0);
			led_rgb_2 :  out std_logic_vector(3-1 downto 0);
			w_data :  out std_logic_vector(8-1 downto 0);
			reset :  in std_logic
		);
	end entity system;
architecture Behavioral of system is
	component detector is
		port(
			clock :  in std_logic;
			r_data :  in std_logic_vector(8-1 downto 0);
			r_available :  in std_logic;
			led_rgb_1 :  out std_logic_vector(3-1 downto 0);
			led_rgb_2 :  out std_logic_vector(3-1 downto 0);
			packet : out hex_array(62-1 downto 0);
			processing :  in std_logic;
			processed :  out std_logic;
			N :  in integer;
			wr_uart :  out std_logic;
			w_data :  out std_logic_vector(8-1 downto 0);
			reset :  in std_logic
		);
	end component detector;
	component interlocking is
		port(
			clock :  in std_logic;
			processing :  in std_logic;
			processed :  out std_logic;
			packet_i : in hex_array(62-1 downto 0);
			packet_o : out hex_array(62-1 downto 0);
			reset :  in std_logic
		);
	end component interlocking;
	component selector is
		port(
			clock :  in std_logic;
			selector :  in std_logic;
			leds :  out std_logic_vector(4-1 downto 0);
			wr_uart_1 :  in std_logic;
			wr_uart_2 :  in std_logic;
			wr_uart_3 :  out std_logic;
			w_data_1 :  in std_logic_vector(8-1 downto 0);
			w_data_2 :  in std_logic_vector(8-1 downto 0);
			w_data_3 :  out std_logic_vector(8-1 downto 0);
			reset :  in std_logic
		);
	end component selector;
	component printer is
		port(
			clock :  in std_logic;
			processing :  in std_logic;
			processed :  out std_logic;
			packet_i : in hex_array(62-1 downto 0);
			w_data :  out std_logic_vector(8-1 downto 0);
			wr_uart :  out std_logic;
			reset :  in std_logic
		);
	end component printer;
	Signal packet_i_s : hex_array(62-1 downto 0);
	Signal packet_o_s : hex_array(62-1 downto 0);
	Signal w_data_1,w_data_2,w_data_3 : std_logic_vector(8-1 downto 0);
	Signal wr_uart_1_s,wr_uart_2_s : std_logic;
	Signal pro_int_reg,pro_det_enc,pro_reg_det : std_logic;
begin
	detector_i : detector
		port map(
			clock => clock,
			reset => reset,
			r_data => r_data,
			r_available => r_available,
			led_rgb_1 => led_rgb_1,
			led_rgb_2 => led_rgb_2,
			N => N,
			wr_uart => wr_uart_1_s,
			processing => pro_reg_det,
			processed => pro_det_enc,
			packet => packet_i_s,
			w_data => w_data_1
		);
	interlocking_i : interlocking
		port map(
			clock => clock,
			reset => reset,
			processing => pro_det_enc,
			processed => pro_int_reg,
			packet_i => packet_i_s,
			packet_o => packet_o_s
		);
	printer_i : printer
		port map(
			clock => clock,
			reset => reset,
			processing => pro_int_reg,
			processed => pro_reg_det,
			packet_i => packet_o_s,
			w_data => w_data_2,
			wr_uart => wr_uart_2_s
		);
	selector_i : selector
		port map(
			clock => clock,
			reset => reset,
			leds => leds,
			selector => selector1,
			wr_uart_1 => wr_uart_1_s,
			wr_uart_2 => wr_uart_2_s,
			wr_uart_3 => write,
			w_data_1 => w_data_1,
			w_data_2 => w_data_2,
			w_data_3 => w_data_3
		);
		w_data <= w_data_3;
		process(clock)
		variable counter: integer := 0;
		begin
			if (clock = '1' and clock'event) then
				if reset = '1' then
					reset_uart <= '0';
				else
					counter := counter + 1;
					if counter = 10*125E6 then
						counter := 0;
						reset_uart <= '1';
					else
						reset_uart <= '0';
					end if;
				end if;
			end if;
		end process;
end Behavioral;