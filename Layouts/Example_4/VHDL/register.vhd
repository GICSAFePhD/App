--  register.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity register is
		port(
			clock : in std_logic;
			process : in std_logic;
			processed : out std_logic;
			paquete_i : in std_logic_vector(235-1 downto 0);
			w_data : out std_logic_vector(8-1 downto 0);
			wr_uart : out std_logic; -- 'char_disp'
			reset : in std_logic
		);
	end entity register;
architecture Behavioral of register is
	type states_t is (RESTART,CYCLE_1,CYCLE_2);
	signal state, next_state : states_t;
	signal mux_out_s,ena_s,rst_s,reg_aux : std_logic;
	signal mux_s : std_logic_vector(8-1 downto 0);
begin
	contador : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				mux_s <= '00000000';
			else
				if (ena_s = '1') then
					if (mux_s /= '11101011') then
						if (state = CYCLE_1 or state = CYCLE_2) then
							mux_s <= std_logic_vector(to_unsigned(to_integer(unsigned(mux_s)) + 1 , 8));
						end if;
					end if;
				end if;
				if (process = '0') then
					mux_s <= '00000000';
				end if;
			end if;
		end if;
	end process;
	multiplexor : process(packet_i,mux_s)
	begin
		case mux_s is
			when '00000000' => mux_out_s <= packet_i(0);
			when '00000001' => mux_out_s <= packet_i(1);
			when '00000010' => mux_out_s <= packet_i(2);
			when '00000011' => mux_out_s <= packet_i(3);
			when '00000100' => mux_out_s <= packet_i(4);
			when '00000101' => mux_out_s <= packet_i(5);
			when '00000110' => mux_out_s <= packet_i(6);
			when '00000111' => mux_out_s <= packet_i(7);
			when '00001000' => mux_out_s <= packet_i(8);
			when '00001001' => mux_out_s <= packet_i(9);
			when '00001010' => mux_out_s <= packet_i(10);
			when '00001011' => mux_out_s <= packet_i(11);
			when '00001100' => mux_out_s <= packet_i(12);
			when '00001101' => mux_out_s <= packet_i(13);
			when '00001110' => mux_out_s <= packet_i(14);
			when '00001111' => mux_out_s <= packet_i(15);
			when '00010000' => mux_out_s <= packet_i(16);
			when '00010001' => mux_out_s <= packet_i(17);
			when '00010010' => mux_out_s <= packet_i(18);
			when '00010011' => mux_out_s <= packet_i(19);
			when '00010100' => mux_out_s <= packet_i(20);
			when '00010101' => mux_out_s <= packet_i(21);
			when '00010110' => mux_out_s <= packet_i(22);
			when '00010111' => mux_out_s <= packet_i(23);
			when '00011000' => mux_out_s <= packet_i(24);
			when '00011001' => mux_out_s <= packet_i(25);
			when '00011010' => mux_out_s <= packet_i(26);
			when '00011011' => mux_out_s <= packet_i(27);
			when '00011100' => mux_out_s <= packet_i(28);
			when '00011101' => mux_out_s <= packet_i(29);
			when '00011110' => mux_out_s <= packet_i(30);
			when '00011111' => mux_out_s <= packet_i(31);
			when '00100000' => mux_out_s <= packet_i(32);
			when '00100001' => mux_out_s <= packet_i(33);
			when '00100010' => mux_out_s <= packet_i(34);
			when '00100011' => mux_out_s <= packet_i(35);
			when '00100100' => mux_out_s <= packet_i(36);
			when '00100101' => mux_out_s <= packet_i(37);
			when '00100110' => mux_out_s <= packet_i(38);
			when '00100111' => mux_out_s <= packet_i(39);
			when '00101000' => mux_out_s <= packet_i(40);
			when '00101001' => mux_out_s <= packet_i(41);
			when '00101010' => mux_out_s <= packet_i(42);
			when '00101011' => mux_out_s <= packet_i(43);
			when '00101100' => mux_out_s <= packet_i(44);
			when '00101101' => mux_out_s <= packet_i(45);
			when '00101110' => mux_out_s <= packet_i(46);
			when '00101111' => mux_out_s <= packet_i(47);
			when '00110000' => mux_out_s <= packet_i(48);
			when '00110001' => mux_out_s <= packet_i(49);
			when '00110010' => mux_out_s <= packet_i(50);
			when '00110011' => mux_out_s <= packet_i(51);
			when '00110100' => mux_out_s <= packet_i(52);
			when '00110101' => mux_out_s <= packet_i(53);
			when '00110110' => mux_out_s <= packet_i(54);
			when '00110111' => mux_out_s <= packet_i(55);
			when '00111000' => mux_out_s <= packet_i(56);
			when '00111001' => mux_out_s <= packet_i(57);
			when '00111010' => mux_out_s <= packet_i(58);
			when '00111011' => mux_out_s <= packet_i(59);
			when '00111100' => mux_out_s <= packet_i(60);
			when '00111101' => mux_out_s <= packet_i(61);
			when '00111110' => mux_out_s <= packet_i(62);
			when '00111111' => mux_out_s <= packet_i(63);
			when '01000000' => mux_out_s <= packet_i(64);
			when '01000001' => mux_out_s <= packet_i(65);
			when '01000010' => mux_out_s <= packet_i(66);
			when '01000011' => mux_out_s <= packet_i(67);
			when '01000100' => mux_out_s <= packet_i(68);
			when '01000101' => mux_out_s <= packet_i(69);
			when '01000110' => mux_out_s <= packet_i(70);
			when '01000111' => mux_out_s <= packet_i(71);
			when '01001000' => mux_out_s <= packet_i(72);
			when '01001001' => mux_out_s <= packet_i(73);
			when '01001010' => mux_out_s <= packet_i(74);
			when '01001011' => mux_out_s <= packet_i(75);
			when '01001100' => mux_out_s <= packet_i(76);
			when '01001101' => mux_out_s <= packet_i(77);
			when '01001110' => mux_out_s <= packet_i(78);
			when '01001111' => mux_out_s <= packet_i(79);
			when '01010000' => mux_out_s <= packet_i(80);
			when '01010001' => mux_out_s <= packet_i(81);
			when '01010010' => mux_out_s <= packet_i(82);
			when '01010011' => mux_out_s <= packet_i(83);
			when '01010100' => mux_out_s <= packet_i(84);
			when '01010101' => mux_out_s <= packet_i(85);
			when '01010110' => mux_out_s <= packet_i(86);
			when '01010111' => mux_out_s <= packet_i(87);
			when '01011000' => mux_out_s <= packet_i(88);
			when '01011001' => mux_out_s <= packet_i(89);
			when '01011010' => mux_out_s <= packet_i(90);
			when '01011011' => mux_out_s <= packet_i(91);
			when '01011100' => mux_out_s <= packet_i(92);
			when '01011101' => mux_out_s <= packet_i(93);
			when '01011110' => mux_out_s <= packet_i(94);
			when '01011111' => mux_out_s <= packet_i(95);
			when '01100000' => mux_out_s <= packet_i(96);
			when '01100001' => mux_out_s <= packet_i(97);
			when '01100010' => mux_out_s <= packet_i(98);
			when '01100011' => mux_out_s <= packet_i(99);
			when '01100100' => mux_out_s <= packet_i(100);
			when '01100101' => mux_out_s <= packet_i(101);
			when '01100110' => mux_out_s <= packet_i(102);
			when '01100111' => mux_out_s <= packet_i(103);
			when '01101000' => mux_out_s <= packet_i(104);
			when '01101001' => mux_out_s <= packet_i(105);
			when '01101010' => mux_out_s <= packet_i(106);
			when '01101011' => mux_out_s <= packet_i(107);
			when '01101100' => mux_out_s <= packet_i(108);
			when '01101101' => mux_out_s <= packet_i(109);
			when '01101110' => mux_out_s <= packet_i(110);
			when '01101111' => mux_out_s <= packet_i(111);
			when '01110000' => mux_out_s <= packet_i(112);
			when '01110001' => mux_out_s <= packet_i(113);
			when '01110010' => mux_out_s <= packet_i(114);
			when '01110011' => mux_out_s <= packet_i(115);
			when '01110100' => mux_out_s <= packet_i(116);
			when '01110101' => mux_out_s <= packet_i(117);
			when '01110110' => mux_out_s <= packet_i(118);
			when '01110111' => mux_out_s <= packet_i(119);
			when '01111000' => mux_out_s <= packet_i(120);
			when '01111001' => mux_out_s <= packet_i(121);
			when '01111010' => mux_out_s <= packet_i(122);
			when '01111011' => mux_out_s <= packet_i(123);
			when '01111100' => mux_out_s <= packet_i(124);
			when '01111101' => mux_out_s <= packet_i(125);
			when '01111110' => mux_out_s <= packet_i(126);
			when '01111111' => mux_out_s <= packet_i(127);
			when '10000000' => mux_out_s <= packet_i(128);
			when '10000001' => mux_out_s <= packet_i(129);
			when '10000010' => mux_out_s <= packet_i(130);
			when '10000011' => mux_out_s <= packet_i(131);
			when '10000100' => mux_out_s <= packet_i(132);
			when '10000101' => mux_out_s <= packet_i(133);
			when '10000110' => mux_out_s <= packet_i(134);
			when '10000111' => mux_out_s <= packet_i(135);
			when '10001000' => mux_out_s <= packet_i(136);
			when '10001001' => mux_out_s <= packet_i(137);
			when '10001010' => mux_out_s <= packet_i(138);
			when '10001011' => mux_out_s <= packet_i(139);
			when '10001100' => mux_out_s <= packet_i(140);
			when '10001101' => mux_out_s <= packet_i(141);
			when '10001110' => mux_out_s <= packet_i(142);
			when '10001111' => mux_out_s <= packet_i(143);
			when '10010000' => mux_out_s <= packet_i(144);
			when '10010001' => mux_out_s <= packet_i(145);
			when '10010010' => mux_out_s <= packet_i(146);
			when '10010011' => mux_out_s <= packet_i(147);
			when '10010100' => mux_out_s <= packet_i(148);
			when '10010101' => mux_out_s <= packet_i(149);
			when '10010110' => mux_out_s <= packet_i(150);
			when '10010111' => mux_out_s <= packet_i(151);
			when '10011000' => mux_out_s <= packet_i(152);
			when '10011001' => mux_out_s <= packet_i(153);
			when '10011010' => mux_out_s <= packet_i(154);
			when '10011011' => mux_out_s <= packet_i(155);
			when '10011100' => mux_out_s <= packet_i(156);
			when '10011101' => mux_out_s <= packet_i(157);
			when '10011110' => mux_out_s <= packet_i(158);
			when '10011111' => mux_out_s <= packet_i(159);
			when '10100000' => mux_out_s <= packet_i(160);
			when '10100001' => mux_out_s <= packet_i(161);
			when '10100010' => mux_out_s <= packet_i(162);
			when '10100011' => mux_out_s <= packet_i(163);
			when '10100100' => mux_out_s <= packet_i(164);
			when '10100101' => mux_out_s <= packet_i(165);
			when '10100110' => mux_out_s <= packet_i(166);
			when '10100111' => mux_out_s <= packet_i(167);
			when '10101000' => mux_out_s <= packet_i(168);
			when '10101001' => mux_out_s <= packet_i(169);
			when '10101010' => mux_out_s <= packet_i(170);
			when '10101011' => mux_out_s <= packet_i(171);
			when '10101100' => mux_out_s <= packet_i(172);
			when '10101101' => mux_out_s <= packet_i(173);
			when '10101110' => mux_out_s <= packet_i(174);
			when '10101111' => mux_out_s <= packet_i(175);
			when '10110000' => mux_out_s <= packet_i(176);
			when '10110001' => mux_out_s <= packet_i(177);
			when '10110010' => mux_out_s <= packet_i(178);
			when '10110011' => mux_out_s <= packet_i(179);
			when '10110100' => mux_out_s <= packet_i(180);
			when '10110101' => mux_out_s <= packet_i(181);
			when '10110110' => mux_out_s <= packet_i(182);
			when '10110111' => mux_out_s <= packet_i(183);
			when '10111000' => mux_out_s <= packet_i(184);
			when '10111001' => mux_out_s <= packet_i(185);
			when '10111010' => mux_out_s <= packet_i(186);
			when '10111011' => mux_out_s <= packet_i(187);
			when '10111100' => mux_out_s <= packet_i(188);
			when '10111101' => mux_out_s <= packet_i(189);
			when '10111110' => mux_out_s <= packet_i(190);
			when '10111111' => mux_out_s <= packet_i(191);
			when '11000000' => mux_out_s <= packet_i(192);
			when '11000001' => mux_out_s <= packet_i(193);
			when '11000010' => mux_out_s <= packet_i(194);
			when '11000011' => mux_out_s <= packet_i(195);
			when '11000100' => mux_out_s <= packet_i(196);
			when '11000101' => mux_out_s <= packet_i(197);
			when '11000110' => mux_out_s <= packet_i(198);
			when '11000111' => mux_out_s <= packet_i(199);
			when '11001000' => mux_out_s <= packet_i(200);
			when '11001001' => mux_out_s <= packet_i(201);
			when '11001010' => mux_out_s <= packet_i(202);
			when '11001011' => mux_out_s <= packet_i(203);
			when '11001100' => mux_out_s <= packet_i(204);
			when '11001101' => mux_out_s <= packet_i(205);
			when '11001110' => mux_out_s <= packet_i(206);
			when '11001111' => mux_out_s <= packet_i(207);
			when '11010000' => mux_out_s <= packet_i(208);
			when '11010001' => mux_out_s <= packet_i(209);
			when '11010010' => mux_out_s <= packet_i(210);
			when '11010011' => mux_out_s <= packet_i(211);
			when '11010100' => mux_out_s <= packet_i(212);
			when '11010101' => mux_out_s <= packet_i(213);
			when '11010110' => mux_out_s <= packet_i(214);
			when '11010111' => mux_out_s <= packet_i(215);
			when '11011000' => mux_out_s <= packet_i(216);
			when '11011001' => mux_out_s <= packet_i(217);
			when '11011010' => mux_out_s <= packet_i(218);
			when '11011011' => mux_out_s <= packet_i(219);
			when '11011100' => mux_out_s <= packet_i(220);
			when '11011101' => mux_out_s <= packet_i(221);
			when '11011110' => mux_out_s <= packet_i(222);
			when '11011111' => mux_out_s <= packet_i(223);
			when '11100000' => mux_out_s <= packet_i(224);
			when '11100001' => mux_out_s <= packet_i(225);
			when '11100010' => mux_out_s <= packet_i(226);
			when '11100011' => mux_out_s <= packet_i(227);
			when '11100100' => mux_out_s <= packet_i(228);
			when '11100101' => mux_out_s <= packet_i(229);
			when '11100110' => mux_out_s <= packet_i(230);
			when '11100111' => mux_out_s <= packet_i(231);
			when '11101000' => mux_out_s <= packet_i(232);
			when '11101001' => mux_out_s <= packet_i(233);
			when '11101010' => mux_out_s <= packet_i(234);
			when others => mux_out_s <= '0';
		end case;
	end process;
	w_data <= '00110001' when mux_out_s = '1' else '00110000';
	FSM_reset : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				state <= RESTART;
			else
				if (process = '1') then
					state <= next_state;
				else
					state <= RESTART;
				end if;
			end if;
		end if;
	end process;
	FSM : process(process,state,mux_s)
	begin
		next_state <= state;
		case state is
			when RESTART =>
				wr_uart <= '0';
				rst_s <= '1';
				ena_s <= '0';
				processed <= '0';
				reg_aux <= '0';
				if (process = '1' and mux_s /= '11101011' ) then
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
				if mux_s = '11101010' then
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