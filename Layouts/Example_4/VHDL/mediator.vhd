--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N : natural := 321;
			N_SIGNALS : natural := 79;
			N_ROUTES : natural := 91;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 21;
			N_DOUBLESWITCHES : natural := 1;
			N_TRACKCIRCUITS : natural := 47
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			signals : in signals_type;
			routes : in std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings : in std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches : in dSwitches_type;
			output : out std_logic_vector(274-1 downto 0);
			reset : in std_logic
		);
	end entity mediator;
architecture Behavioral of mediator is
begin
	process(clock,reset)
	begin
		if (clock = '1' and Clock'Event) then
			if (reset = '1') then
				output <= (others => '0');
				processed <= '0';
			else
				processed <= processing;
				if (processing = '1') then
					output(90 downto 0) <= routes;
					output(91) <= signals.msb(0);
					output(92) <= signals.lsb(0);
					output(93) <= signals.msb(1);
					output(94) <= signals.lsb(1);
					output(95) <= signals.msb(2);
					output(96) <= signals.lsb(2);
					output(97) <= signals.msb(3);
					output(98) <= signals.lsb(3);
					output(99) <= signals.msb(4);
					output(100) <= signals.lsb(4);
					output(101) <= signals.msb(5);
					output(102) <= signals.lsb(5);
					output(103) <= signals.msb(6);
					output(104) <= signals.lsb(6);
					output(105) <= signals.msb(7);
					output(106) <= signals.lsb(7);
					output(107) <= signals.msb(8);
					output(108) <= signals.lsb(8);
					output(109) <= signals.msb(9);
					output(110) <= signals.lsb(9);
					output(111) <= signals.msb(10);
					output(112) <= signals.lsb(10);
					output(113) <= signals.msb(11);
					output(114) <= signals.lsb(11);
					output(115) <= signals.msb(12);
					output(116) <= signals.lsb(12);
					output(117) <= signals.msb(13);
					output(118) <= signals.lsb(13);
					output(119) <= signals.msb(14);
					output(120) <= signals.lsb(14);
					output(121) <= signals.msb(15);
					output(122) <= signals.lsb(15);
					output(123) <= signals.msb(16);
					output(124) <= signals.lsb(16);
					output(125) <= signals.msb(17);
					output(126) <= signals.lsb(17);
					output(127) <= signals.msb(18);
					output(128) <= signals.lsb(18);
					output(129) <= signals.msb(19);
					output(130) <= signals.lsb(19);
					output(131) <= signals.msb(20);
					output(132) <= signals.lsb(20);
					output(133) <= signals.msb(21);
					output(134) <= signals.lsb(21);
					output(135) <= signals.msb(22);
					output(136) <= signals.lsb(22);
					output(137) <= signals.msb(23);
					output(138) <= signals.lsb(23);
					output(139) <= signals.msb(24);
					output(140) <= signals.lsb(24);
					output(141) <= signals.msb(25);
					output(142) <= signals.lsb(25);
					output(143) <= signals.msb(26);
					output(144) <= signals.lsb(26);
					output(145) <= signals.msb(27);
					output(146) <= signals.lsb(27);
					output(147) <= signals.msb(28);
					output(148) <= signals.lsb(28);
					output(149) <= signals.msb(29);
					output(150) <= signals.lsb(29);
					output(151) <= signals.msb(30);
					output(152) <= signals.lsb(30);
					output(153) <= signals.msb(31);
					output(154) <= signals.lsb(31);
					output(155) <= signals.msb(32);
					output(156) <= signals.lsb(32);
					output(157) <= signals.msb(33);
					output(158) <= signals.lsb(33);
					output(159) <= signals.msb(34);
					output(160) <= signals.lsb(34);
					output(161) <= signals.msb(35);
					output(162) <= signals.lsb(35);
					output(163) <= signals.msb(36);
					output(164) <= signals.lsb(36);
					output(165) <= signals.msb(37);
					output(166) <= signals.lsb(37);
					output(167) <= signals.msb(38);
					output(168) <= signals.lsb(38);
					output(169) <= signals.msb(39);
					output(170) <= signals.lsb(39);
					output(171) <= signals.msb(40);
					output(172) <= signals.lsb(40);
					output(173) <= signals.msb(41);
					output(174) <= signals.lsb(41);
					output(175) <= signals.msb(42);
					output(176) <= signals.lsb(42);
					output(177) <= signals.msb(43);
					output(178) <= signals.lsb(43);
					output(179) <= signals.msb(44);
					output(180) <= signals.lsb(44);
					output(181) <= signals.msb(45);
					output(182) <= signals.lsb(45);
					output(183) <= signals.msb(46);
					output(184) <= signals.lsb(46);
					output(185) <= signals.msb(47);
					output(186) <= signals.lsb(47);
					output(187) <= signals.msb(48);
					output(188) <= signals.lsb(48);
					output(189) <= signals.msb(49);
					output(190) <= signals.lsb(49);
					output(191) <= signals.msb(50);
					output(192) <= signals.lsb(50);
					output(193) <= signals.msb(51);
					output(194) <= signals.lsb(51);
					output(195) <= signals.msb(52);
					output(196) <= signals.lsb(52);
					output(197) <= signals.msb(53);
					output(198) <= signals.lsb(53);
					output(199) <= signals.msb(54);
					output(200) <= signals.lsb(54);
					output(201) <= signals.msb(55);
					output(202) <= signals.lsb(55);
					output(203) <= signals.msb(56);
					output(204) <= signals.lsb(56);
					output(205) <= signals.msb(57);
					output(206) <= signals.lsb(57);
					output(207) <= signals.msb(58);
					output(208) <= signals.lsb(58);
					output(209) <= signals.msb(59);
					output(210) <= signals.lsb(59);
					output(211) <= signals.msb(60);
					output(212) <= signals.lsb(60);
					output(213) <= signals.msb(61);
					output(214) <= signals.lsb(61);
					output(215) <= signals.msb(62);
					output(216) <= signals.lsb(62);
					output(217) <= signals.msb(63);
					output(218) <= signals.lsb(63);
					output(219) <= signals.msb(64);
					output(220) <= signals.lsb(64);
					output(221) <= signals.msb(65);
					output(222) <= signals.lsb(65);
					output(223) <= signals.msb(66);
					output(224) <= signals.lsb(66);
					output(225) <= signals.msb(67);
					output(226) <= signals.lsb(67);
					output(227) <= signals.msb(68);
					output(228) <= signals.lsb(68);
					output(229) <= signals.msb(69);
					output(230) <= signals.lsb(69);
					output(231) <= signals.msb(70);
					output(232) <= signals.lsb(70);
					output(233) <= signals.msb(71);
					output(234) <= signals.lsb(71);
					output(235) <= signals.msb(72);
					output(236) <= signals.lsb(72);
					output(237) <= signals.msb(73);
					output(238) <= signals.lsb(73);
					output(239) <= signals.msb(74);
					output(240) <= signals.lsb(74);
					output(241) <= signals.msb(75);
					output(242) <= signals.lsb(75);
					output(243) <= signals.msb(76);
					output(244) <= signals.lsb(76);
					output(245) <= signals.msb(77);
					output(246) <= signals.lsb(77);
					output(247) <= signals.msb(78);
					output(248) <= signals.lsb(78);
					output(250 downto 249) <= levelCrossings;
					output(271 downto 251) <= singleSwitches;
					output(0) <= doubleSwitches.msb(0);
					output(1) <= doubleSwitches.lsb(0);
				end if;
			end if;
		end if;
	end process;
end Behavioral;