--  printer.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
--Declare the package
use work.my_package.all;
	entity printer is
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			packet_i : in hex_array(62-1 downto 0);
			w_data : out std_logic_vector(8-1 downto 0);
			wr_uart : out std_logic; -- 'char_disp'
			reset : in std_logic
		);
	end entity printer;
architecture Behavioral of printer is
	type states_t is (RESTART,CYCLE_1,CYCLE_2);
	signal mux_out_s : hex_char;
	signal state, next_state : states_t;
	signal ena_s,rst_s,reg_aux : std_logic;
	signal mux_s : std_logic_vector(6-1 downto 0);
	-- Lookup table for hex_char to ASCII conversion
	constant hex_to_ascii : ascii_packet := (
		'0' => "00110000", '1' => "00110001", '2' => "00110010", '3' => "00110011",
		'4' => "00110100", '5' => "00110101", '6' => "00110110", '7' => "00110111",
		'8' => "00111000", '9' => "00111001", 'A' => "01000001", 'B' => "01000010",
		'C' => "01000011", 'D' => "01000100", 'E' => "01000101", 'F' => "01000110"
	);
	-- Function to convert mux_s to integer
	function mux_to_int(mux : std_logic_vector) return integer is
	begin
		return to_integer(unsigned(mux));
	end function mux_to_int;
begin
	contador : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				mux_s <= "000000";
			else
				if (ena_s = '1') then
					if (mux_s /= "111110") then
						if (state = CYCLE_1 or state = CYCLE_2) then
							mux_s <= std_logic_vector(to_unsigned(to_integer(unsigned(mux_s)) + 1 , 6));
						end if;
					end if;
				end if;
				if (processing = '0') then
					mux_s <= "000000";
				end if;
			end if;
		end if;
	end process;
	multiplexor : process(packet_i,mux_s)
	begin
		mux_out_s <= packet_i(mux_to_int(mux_s));
	end process;
	w_data <= hex_to_ascii(mux_out_s);
	FSM_reset : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				state <= RESTART;
			else
				if (processing = '1') then
					state <= next_state;
				else
					state <= RESTART;
				end if;
			end if;
		end if;
	end process;
	FSM : process(processing,state,mux_s)
	begin
		next_state <= state;
		case state is
			when RESTART =>
				wr_uart <= '0';
				rst_s <= '1';
				ena_s <= '0';
				processed <= '0';
				reg_aux <= '0';
				if (processing = '1' and mux_s /= "111110" ) then
					next_state <= CYCLE_1;
				end if;
			when CYCLE_1 =>
				wr_uart <= '0';
				rst_s <= '0';
				ena_s <= '0';
				--processed <= '0';
				next_state <= CYCLE_2;
			when CYCLE_2 =>
				wr_uart <= '1';
				rst_s <= '0';
				ena_s <= '1';
				processed <= '0';
				reg_aux <= '0';
				if mux_s = "111101" then
					processed <= '1';
					reg_aux <= '1';
					next_state <= RESTART;
				else
					next_state <= CYCLE_1;
				end if;
			when others => null;
		end case;
	end process;
end Behavioral;