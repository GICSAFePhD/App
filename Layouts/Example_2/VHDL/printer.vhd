--  printer.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity printer is
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			packet_i : in std_logic_vector(37-1 downto 0);
			w_data : out std_logic_vector(8-1 downto 0);
			wr_uart : out std_logic; -- 'char_disp'
			reset : in std_logic
		);
	end entity printer;
architecture Behavioral of printer is
	type states_t is (RESTART,CYCLE_1,CYCLE_2);
	signal state, next_state : states_t;
	signal mux_out_s,ena_s,rst_s,reg_aux : std_logic;
	signal mux_s : std_logic_vector(6-1 downto 0);
begin
	contador : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				mux_s <= "000000";
			else
				if (ena_s = '1') then
					if (mux_s /= "100101") then
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
		case mux_s is
			when "000000" => mux_out_s <= packet_i(0);
			when "000001" => mux_out_s <= packet_i(1);
			when "000010" => mux_out_s <= packet_i(2);
			when "000011" => mux_out_s <= packet_i(3);
			when "000100" => mux_out_s <= packet_i(4);
			when "000101" => mux_out_s <= packet_i(5);
			when "000110" => mux_out_s <= packet_i(6);
			when "000111" => mux_out_s <= packet_i(7);
			when "001000" => mux_out_s <= packet_i(8);
			when "001001" => mux_out_s <= packet_i(9);
			when "001010" => mux_out_s <= packet_i(10);
			when "001011" => mux_out_s <= packet_i(11);
			when "001100" => mux_out_s <= packet_i(12);
			when "001101" => mux_out_s <= packet_i(13);
			when "001110" => mux_out_s <= packet_i(14);
			when "001111" => mux_out_s <= packet_i(15);
			when "010000" => mux_out_s <= packet_i(16);
			when "010001" => mux_out_s <= packet_i(17);
			when "010010" => mux_out_s <= packet_i(18);
			when "010011" => mux_out_s <= packet_i(19);
			when "010100" => mux_out_s <= packet_i(20);
			when "010101" => mux_out_s <= packet_i(21);
			when "010110" => mux_out_s <= packet_i(22);
			when "010111" => mux_out_s <= packet_i(23);
			when "011000" => mux_out_s <= packet_i(24);
			when "011001" => mux_out_s <= packet_i(25);
			when "011010" => mux_out_s <= packet_i(26);
			when "011011" => mux_out_s <= packet_i(27);
			when "011100" => mux_out_s <= packet_i(28);
			when "011101" => mux_out_s <= packet_i(29);
			when "011110" => mux_out_s <= packet_i(30);
			when "011111" => mux_out_s <= packet_i(31);
			when "100000" => mux_out_s <= packet_i(32);
			when "100001" => mux_out_s <= packet_i(33);
			when "100010" => mux_out_s <= packet_i(34);
			when "100011" => mux_out_s <= packet_i(35);
			when "100100" => mux_out_s <= packet_i(36);
			when others => mux_out_s <= '0';
		end case;
	end process;
	w_data <= "00110001" when mux_out_s = '1' else "00110000";
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
				if (processing = '1' and mux_s /= "100101" ) then
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
				if mux_s = "100100" then
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