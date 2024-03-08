--  printer.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
	entity printer is
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			packet_i : in std_logic_vector(276-1 downto 0);
			w_data : out std_logic_vector(8-1 downto 0);
			wr_uart : out std_logic; -- 'char_disp'
			reset : in std_logic
		);
	end entity printer;
architecture Behavioral of printer is
	type states_t is (RESTART,CYCLE_1,CYCLE_2);
	signal state, next_state : states_t;
	signal mux_out_s,ena_s,rst_s,reg_aux : std_logic;
	signal mux_s : std_logic_vector(9-1 downto 0);
begin
	contador : process(clock)
	begin
		if (clock = '1' and clock'event) then
			if reset = '1' then
				mux_s <= "000000000";
			else
				if (ena_s = '1') then
					if (mux_s /= "100010100") then
						if (state = CYCLE_1 or state = CYCLE_2) then
							mux_s <= std_logic_vector(to_unsigned(to_integer(unsigned(mux_s)) + 1 , 9));
						end if;
					end if;
				end if;
				if (processing = '0') then
					mux_s <= "000000000";
				end if;
			end if;
		end if;
	end process;
	multiplexor : process(packet_i,mux_s)
	begin
		case mux_s is
			when "000000000" => mux_out_s <= packet_i(0);
			when "000000001" => mux_out_s <= packet_i(1);
			when "000000010" => mux_out_s <= packet_i(2);
			when "000000011" => mux_out_s <= packet_i(3);
			when "000000100" => mux_out_s <= packet_i(4);
			when "000000101" => mux_out_s <= packet_i(5);
			when "000000110" => mux_out_s <= packet_i(6);
			when "000000111" => mux_out_s <= packet_i(7);
			when "000001000" => mux_out_s <= packet_i(8);
			when "000001001" => mux_out_s <= packet_i(9);
			when "000001010" => mux_out_s <= packet_i(10);
			when "000001011" => mux_out_s <= packet_i(11);
			when "000001100" => mux_out_s <= packet_i(12);
			when "000001101" => mux_out_s <= packet_i(13);
			when "000001110" => mux_out_s <= packet_i(14);
			when "000001111" => mux_out_s <= packet_i(15);
			when "000010000" => mux_out_s <= packet_i(16);
			when "000010001" => mux_out_s <= packet_i(17);
			when "000010010" => mux_out_s <= packet_i(18);
			when "000010011" => mux_out_s <= packet_i(19);
			when "000010100" => mux_out_s <= packet_i(20);
			when "000010101" => mux_out_s <= packet_i(21);
			when "000010110" => mux_out_s <= packet_i(22);
			when "000010111" => mux_out_s <= packet_i(23);
			when "000011000" => mux_out_s <= packet_i(24);
			when "000011001" => mux_out_s <= packet_i(25);
			when "000011010" => mux_out_s <= packet_i(26);
			when "000011011" => mux_out_s <= packet_i(27);
			when "000011100" => mux_out_s <= packet_i(28);
			when "000011101" => mux_out_s <= packet_i(29);
			when "000011110" => mux_out_s <= packet_i(30);
			when "000011111" => mux_out_s <= packet_i(31);
			when "000100000" => mux_out_s <= packet_i(32);
			when "000100001" => mux_out_s <= packet_i(33);
			when "000100010" => mux_out_s <= packet_i(34);
			when "000100011" => mux_out_s <= packet_i(35);
			when "000100100" => mux_out_s <= packet_i(36);
			when "000100101" => mux_out_s <= packet_i(37);
			when "000100110" => mux_out_s <= packet_i(38);
			when "000100111" => mux_out_s <= packet_i(39);
			when "000101000" => mux_out_s <= packet_i(40);
			when "000101001" => mux_out_s <= packet_i(41);
			when "000101010" => mux_out_s <= packet_i(42);
			when "000101011" => mux_out_s <= packet_i(43);
			when "000101100" => mux_out_s <= packet_i(44);
			when "000101101" => mux_out_s <= packet_i(45);
			when "000101110" => mux_out_s <= packet_i(46);
			when "000101111" => mux_out_s <= packet_i(47);
			when "000110000" => mux_out_s <= packet_i(48);
			when "000110001" => mux_out_s <= packet_i(49);
			when "000110010" => mux_out_s <= packet_i(50);
			when "000110011" => mux_out_s <= packet_i(51);
			when "000110100" => mux_out_s <= packet_i(52);
			when "000110101" => mux_out_s <= packet_i(53);
			when "000110110" => mux_out_s <= packet_i(54);
			when "000110111" => mux_out_s <= packet_i(55);
			when "000111000" => mux_out_s <= packet_i(56);
			when "000111001" => mux_out_s <= packet_i(57);
			when "000111010" => mux_out_s <= packet_i(58);
			when "000111011" => mux_out_s <= packet_i(59);
			when "000111100" => mux_out_s <= packet_i(60);
			when "000111101" => mux_out_s <= packet_i(61);
			when "000111110" => mux_out_s <= packet_i(62);
			when "000111111" => mux_out_s <= packet_i(63);
			when "001000000" => mux_out_s <= packet_i(64);
			when "001000001" => mux_out_s <= packet_i(65);
			when "001000010" => mux_out_s <= packet_i(66);
			when "001000011" => mux_out_s <= packet_i(67);
			when "001000100" => mux_out_s <= packet_i(68);
			when "001000101" => mux_out_s <= packet_i(69);
			when "001000110" => mux_out_s <= packet_i(70);
			when "001000111" => mux_out_s <= packet_i(71);
			when "001001000" => mux_out_s <= packet_i(72);
			when "001001001" => mux_out_s <= packet_i(73);
			when "001001010" => mux_out_s <= packet_i(74);
			when "001001011" => mux_out_s <= packet_i(75);
			when "001001100" => mux_out_s <= packet_i(76);
			when "001001101" => mux_out_s <= packet_i(77);
			when "001001110" => mux_out_s <= packet_i(78);
			when "001001111" => mux_out_s <= packet_i(79);
			when "001010000" => mux_out_s <= packet_i(80);
			when "001010001" => mux_out_s <= packet_i(81);
			when "001010010" => mux_out_s <= packet_i(82);
			when "001010011" => mux_out_s <= packet_i(83);
			when "001010100" => mux_out_s <= packet_i(84);
			when "001010101" => mux_out_s <= packet_i(85);
			when "001010110" => mux_out_s <= packet_i(86);
			when "001010111" => mux_out_s <= packet_i(87);
			when "001011000" => mux_out_s <= packet_i(88);
			when "001011001" => mux_out_s <= packet_i(89);
			when "001011010" => mux_out_s <= packet_i(90);
			when "001011011" => mux_out_s <= packet_i(91);
			when "001011100" => mux_out_s <= packet_i(92);
			when "001011101" => mux_out_s <= packet_i(93);
			when "001011110" => mux_out_s <= packet_i(94);
			when "001011111" => mux_out_s <= packet_i(95);
			when "001100000" => mux_out_s <= packet_i(96);
			when "001100001" => mux_out_s <= packet_i(97);
			when "001100010" => mux_out_s <= packet_i(98);
			when "001100011" => mux_out_s <= packet_i(99);
			when "001100100" => mux_out_s <= packet_i(100);
			when "001100101" => mux_out_s <= packet_i(101);
			when "001100110" => mux_out_s <= packet_i(102);
			when "001100111" => mux_out_s <= packet_i(103);
			when "001101000" => mux_out_s <= packet_i(104);
			when "001101001" => mux_out_s <= packet_i(105);
			when "001101010" => mux_out_s <= packet_i(106);
			when "001101011" => mux_out_s <= packet_i(107);
			when "001101100" => mux_out_s <= packet_i(108);
			when "001101101" => mux_out_s <= packet_i(109);
			when "001101110" => mux_out_s <= packet_i(110);
			when "001101111" => mux_out_s <= packet_i(111);
			when "001110000" => mux_out_s <= packet_i(112);
			when "001110001" => mux_out_s <= packet_i(113);
			when "001110010" => mux_out_s <= packet_i(114);
			when "001110011" => mux_out_s <= packet_i(115);
			when "001110100" => mux_out_s <= packet_i(116);
			when "001110101" => mux_out_s <= packet_i(117);
			when "001110110" => mux_out_s <= packet_i(118);
			when "001110111" => mux_out_s <= packet_i(119);
			when "001111000" => mux_out_s <= packet_i(120);
			when "001111001" => mux_out_s <= packet_i(121);
			when "001111010" => mux_out_s <= packet_i(122);
			when "001111011" => mux_out_s <= packet_i(123);
			when "001111100" => mux_out_s <= packet_i(124);
			when "001111101" => mux_out_s <= packet_i(125);
			when "001111110" => mux_out_s <= packet_i(126);
			when "001111111" => mux_out_s <= packet_i(127);
			when "010000000" => mux_out_s <= packet_i(128);
			when "010000001" => mux_out_s <= packet_i(129);
			when "010000010" => mux_out_s <= packet_i(130);
			when "010000011" => mux_out_s <= packet_i(131);
			when "010000100" => mux_out_s <= packet_i(132);
			when "010000101" => mux_out_s <= packet_i(133);
			when "010000110" => mux_out_s <= packet_i(134);
			when "010000111" => mux_out_s <= packet_i(135);
			when "010001000" => mux_out_s <= packet_i(136);
			when "010001001" => mux_out_s <= packet_i(137);
			when "010001010" => mux_out_s <= packet_i(138);
			when "010001011" => mux_out_s <= packet_i(139);
			when "010001100" => mux_out_s <= packet_i(140);
			when "010001101" => mux_out_s <= packet_i(141);
			when "010001110" => mux_out_s <= packet_i(142);
			when "010001111" => mux_out_s <= packet_i(143);
			when "010010000" => mux_out_s <= packet_i(144);
			when "010010001" => mux_out_s <= packet_i(145);
			when "010010010" => mux_out_s <= packet_i(146);
			when "010010011" => mux_out_s <= packet_i(147);
			when "010010100" => mux_out_s <= packet_i(148);
			when "010010101" => mux_out_s <= packet_i(149);
			when "010010110" => mux_out_s <= packet_i(150);
			when "010010111" => mux_out_s <= packet_i(151);
			when "010011000" => mux_out_s <= packet_i(152);
			when "010011001" => mux_out_s <= packet_i(153);
			when "010011010" => mux_out_s <= packet_i(154);
			when "010011011" => mux_out_s <= packet_i(155);
			when "010011100" => mux_out_s <= packet_i(156);
			when "010011101" => mux_out_s <= packet_i(157);
			when "010011110" => mux_out_s <= packet_i(158);
			when "010011111" => mux_out_s <= packet_i(159);
			when "010100000" => mux_out_s <= packet_i(160);
			when "010100001" => mux_out_s <= packet_i(161);
			when "010100010" => mux_out_s <= packet_i(162);
			when "010100011" => mux_out_s <= packet_i(163);
			when "010100100" => mux_out_s <= packet_i(164);
			when "010100101" => mux_out_s <= packet_i(165);
			when "010100110" => mux_out_s <= packet_i(166);
			when "010100111" => mux_out_s <= packet_i(167);
			when "010101000" => mux_out_s <= packet_i(168);
			when "010101001" => mux_out_s <= packet_i(169);
			when "010101010" => mux_out_s <= packet_i(170);
			when "010101011" => mux_out_s <= packet_i(171);
			when "010101100" => mux_out_s <= packet_i(172);
			when "010101101" => mux_out_s <= packet_i(173);
			when "010101110" => mux_out_s <= packet_i(174);
			when "010101111" => mux_out_s <= packet_i(175);
			when "010110000" => mux_out_s <= packet_i(176);
			when "010110001" => mux_out_s <= packet_i(177);
			when "010110010" => mux_out_s <= packet_i(178);
			when "010110011" => mux_out_s <= packet_i(179);
			when "010110100" => mux_out_s <= packet_i(180);
			when "010110101" => mux_out_s <= packet_i(181);
			when "010110110" => mux_out_s <= packet_i(182);
			when "010110111" => mux_out_s <= packet_i(183);
			when "010111000" => mux_out_s <= packet_i(184);
			when "010111001" => mux_out_s <= packet_i(185);
			when "010111010" => mux_out_s <= packet_i(186);
			when "010111011" => mux_out_s <= packet_i(187);
			when "010111100" => mux_out_s <= packet_i(188);
			when "010111101" => mux_out_s <= packet_i(189);
			when "010111110" => mux_out_s <= packet_i(190);
			when "010111111" => mux_out_s <= packet_i(191);
			when "011000000" => mux_out_s <= packet_i(192);
			when "011000001" => mux_out_s <= packet_i(193);
			when "011000010" => mux_out_s <= packet_i(194);
			when "011000011" => mux_out_s <= packet_i(195);
			when "011000100" => mux_out_s <= packet_i(196);
			when "011000101" => mux_out_s <= packet_i(197);
			when "011000110" => mux_out_s <= packet_i(198);
			when "011000111" => mux_out_s <= packet_i(199);
			when "011001000" => mux_out_s <= packet_i(200);
			when "011001001" => mux_out_s <= packet_i(201);
			when "011001010" => mux_out_s <= packet_i(202);
			when "011001011" => mux_out_s <= packet_i(203);
			when "011001100" => mux_out_s <= packet_i(204);
			when "011001101" => mux_out_s <= packet_i(205);
			when "011001110" => mux_out_s <= packet_i(206);
			when "011001111" => mux_out_s <= packet_i(207);
			when "011010000" => mux_out_s <= packet_i(208);
			when "011010001" => mux_out_s <= packet_i(209);
			when "011010010" => mux_out_s <= packet_i(210);
			when "011010011" => mux_out_s <= packet_i(211);
			when "011010100" => mux_out_s <= packet_i(212);
			when "011010101" => mux_out_s <= packet_i(213);
			when "011010110" => mux_out_s <= packet_i(214);
			when "011010111" => mux_out_s <= packet_i(215);
			when "011011000" => mux_out_s <= packet_i(216);
			when "011011001" => mux_out_s <= packet_i(217);
			when "011011010" => mux_out_s <= packet_i(218);
			when "011011011" => mux_out_s <= packet_i(219);
			when "011011100" => mux_out_s <= packet_i(220);
			when "011011101" => mux_out_s <= packet_i(221);
			when "011011110" => mux_out_s <= packet_i(222);
			when "011011111" => mux_out_s <= packet_i(223);
			when "011100000" => mux_out_s <= packet_i(224);
			when "011100001" => mux_out_s <= packet_i(225);
			when "011100010" => mux_out_s <= packet_i(226);
			when "011100011" => mux_out_s <= packet_i(227);
			when "011100100" => mux_out_s <= packet_i(228);
			when "011100101" => mux_out_s <= packet_i(229);
			when "011100110" => mux_out_s <= packet_i(230);
			when "011100111" => mux_out_s <= packet_i(231);
			when "011101000" => mux_out_s <= packet_i(232);
			when "011101001" => mux_out_s <= packet_i(233);
			when "011101010" => mux_out_s <= packet_i(234);
			when "011101011" => mux_out_s <= packet_i(235);
			when "011101100" => mux_out_s <= packet_i(236);
			when "011101101" => mux_out_s <= packet_i(237);
			when "011101110" => mux_out_s <= packet_i(238);
			when "011101111" => mux_out_s <= packet_i(239);
			when "011110000" => mux_out_s <= packet_i(240);
			when "011110001" => mux_out_s <= packet_i(241);
			when "011110010" => mux_out_s <= packet_i(242);
			when "011110011" => mux_out_s <= packet_i(243);
			when "011110100" => mux_out_s <= packet_i(244);
			when "011110101" => mux_out_s <= packet_i(245);
			when "011110110" => mux_out_s <= packet_i(246);
			when "011110111" => mux_out_s <= packet_i(247);
			when "011111000" => mux_out_s <= packet_i(248);
			when "011111001" => mux_out_s <= packet_i(249);
			when "011111010" => mux_out_s <= packet_i(250);
			when "011111011" => mux_out_s <= packet_i(251);
			when "011111100" => mux_out_s <= packet_i(252);
			when "011111101" => mux_out_s <= packet_i(253);
			when "011111110" => mux_out_s <= packet_i(254);
			when "011111111" => mux_out_s <= packet_i(255);
			when "100000000" => mux_out_s <= packet_i(256);
			when "100000001" => mux_out_s <= packet_i(257);
			when "100000010" => mux_out_s <= packet_i(258);
			when "100000011" => mux_out_s <= packet_i(259);
			when "100000100" => mux_out_s <= packet_i(260);
			when "100000101" => mux_out_s <= packet_i(261);
			when "100000110" => mux_out_s <= packet_i(262);
			when "100000111" => mux_out_s <= packet_i(263);
			when "100001000" => mux_out_s <= packet_i(264);
			when "100001001" => mux_out_s <= packet_i(265);
			when "100001010" => mux_out_s <= packet_i(266);
			when "100001011" => mux_out_s <= packet_i(267);
			when "100001100" => mux_out_s <= packet_i(268);
			when "100001101" => mux_out_s <= packet_i(269);
			when "100001110" => mux_out_s <= packet_i(270);
			when "100001111" => mux_out_s <= packet_i(271);
			when "100010000" => mux_out_s <= packet_i(272);
			when "100010001" => mux_out_s <= packet_i(273);
			when "100010010" => mux_out_s <= packet_i(274);
			when "100010011" => mux_out_s <= packet_i(275);
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
				if (processing = '1' and mux_s /= "100010100" ) then
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
				if mux_s = "100010011" then
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