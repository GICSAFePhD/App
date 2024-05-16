--  printer.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity printer is
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			packet_i : in std_logic_vector(84-1 downto 0);
			w_data : out std_logic_vector(8-1 downto 0);
			wr_uart : out std_logic; -- 'char_disp'
			reset : in std_logic
		);
	end entity printer;
architecture Behavioral of printer is
	type states_t is (RESTART,CYCLE_1,CYCLE_2);
	signal state, next_state : states_t;
	signal mux_out_s,ena_s,rst_s,reg_aux : std_logic;
	signal mux_s : std_logic_vector(7-1 downto 0);
begin
	contador : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				mux_s <= "0000000";
			else
				if (ena_s = '1') then
					if (mux_s /= "1010100") then
						if (state = CYCLE_1 or state = CYCLE_2) then
							mux_s <= std_logic_vector(to_unsigned(to_integer(unsigned(mux_s)) + 1 , 7));
						end if;
					end if;
				end if;
				if (processing = '0') then
					mux_s <= "0000000";
				end if;
			end if;
		end if;
	end process;
	multiplexor : process(packet_i,mux_s)
	begin
		case mux_s is
			when "0000000" => mux_out_s <= packet_i(0);
			when "0000001" => mux_out_s <= packet_i(1);
			when "0000010" => mux_out_s <= packet_i(2);
			when "0000011" => mux_out_s <= packet_i(3);
			when "0000100" => mux_out_s <= packet_i(4);
			when "0000101" => mux_out_s <= packet_i(5);
			when "0000110" => mux_out_s <= packet_i(6);
			when "0000111" => mux_out_s <= packet_i(7);
			when "0001000" => mux_out_s <= packet_i(8);
			when "0001001" => mux_out_s <= packet_i(9);
			when "0001010" => mux_out_s <= packet_i(10);
			when "0001011" => mux_out_s <= packet_i(11);
			when "0001100" => mux_out_s <= packet_i(12);
			when "0001101" => mux_out_s <= packet_i(13);
			when "0001110" => mux_out_s <= packet_i(14);
			when "0001111" => mux_out_s <= packet_i(15);
			when "0010000" => mux_out_s <= packet_i(16);
			when "0010001" => mux_out_s <= packet_i(17);
			when "0010010" => mux_out_s <= packet_i(18);
			when "0010011" => mux_out_s <= packet_i(19);
			when "0010100" => mux_out_s <= packet_i(20);
			when "0010101" => mux_out_s <= packet_i(21);
			when "0010110" => mux_out_s <= packet_i(22);
			when "0010111" => mux_out_s <= packet_i(23);
			when "0011000" => mux_out_s <= packet_i(24);
			when "0011001" => mux_out_s <= packet_i(25);
			when "0011010" => mux_out_s <= packet_i(26);
			when "0011011" => mux_out_s <= packet_i(27);
			when "0011100" => mux_out_s <= packet_i(28);
			when "0011101" => mux_out_s <= packet_i(29);
			when "0011110" => mux_out_s <= packet_i(30);
			when "0011111" => mux_out_s <= packet_i(31);
			when "0100000" => mux_out_s <= packet_i(32);
			when "0100001" => mux_out_s <= packet_i(33);
			when "0100010" => mux_out_s <= packet_i(34);
			when "0100011" => mux_out_s <= packet_i(35);
			when "0100100" => mux_out_s <= packet_i(36);
			when "0100101" => mux_out_s <= packet_i(37);
			when "0100110" => mux_out_s <= packet_i(38);
			when "0100111" => mux_out_s <= packet_i(39);
			when "0101000" => mux_out_s <= packet_i(40);
			when "0101001" => mux_out_s <= packet_i(41);
			when "0101010" => mux_out_s <= packet_i(42);
			when "0101011" => mux_out_s <= packet_i(43);
			when "0101100" => mux_out_s <= packet_i(44);
			when "0101101" => mux_out_s <= packet_i(45);
			when "0101110" => mux_out_s <= packet_i(46);
			when "0101111" => mux_out_s <= packet_i(47);
			when "0110000" => mux_out_s <= packet_i(48);
			when "0110001" => mux_out_s <= packet_i(49);
			when "0110010" => mux_out_s <= packet_i(50);
			when "0110011" => mux_out_s <= packet_i(51);
			when "0110100" => mux_out_s <= packet_i(52);
			when "0110101" => mux_out_s <= packet_i(53);
			when "0110110" => mux_out_s <= packet_i(54);
			when "0110111" => mux_out_s <= packet_i(55);
			when "0111000" => mux_out_s <= packet_i(56);
			when "0111001" => mux_out_s <= packet_i(57);
			when "0111010" => mux_out_s <= packet_i(58);
			when "0111011" => mux_out_s <= packet_i(59);
			when "0111100" => mux_out_s <= packet_i(60);
			when "0111101" => mux_out_s <= packet_i(61);
			when "0111110" => mux_out_s <= packet_i(62);
			when "0111111" => mux_out_s <= packet_i(63);
			when "1000000" => mux_out_s <= packet_i(64);
			when "1000001" => mux_out_s <= packet_i(65);
			when "1000010" => mux_out_s <= packet_i(66);
			when "1000011" => mux_out_s <= packet_i(67);
			when "1000100" => mux_out_s <= packet_i(68);
			when "1000101" => mux_out_s <= packet_i(69);
			when "1000110" => mux_out_s <= packet_i(70);
			when "1000111" => mux_out_s <= packet_i(71);
			when "1001000" => mux_out_s <= packet_i(72);
			when "1001001" => mux_out_s <= packet_i(73);
			when "1001010" => mux_out_s <= packet_i(74);
			when "1001011" => mux_out_s <= packet_i(75);
			when "1001100" => mux_out_s <= packet_i(76);
			when "1001101" => mux_out_s <= packet_i(77);
			when "1001110" => mux_out_s <= packet_i(78);
			when "1001111" => mux_out_s <= packet_i(79);
			when "1010000" => mux_out_s <= packet_i(80);
			when "1010001" => mux_out_s <= packet_i(81);
			when "1010010" => mux_out_s <= packet_i(82);
			when "1010011" => mux_out_s <= packet_i(83);
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
				if (processing = '1' and mux_s /= "1010100" ) then
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
				if mux_s = "1010011" then
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