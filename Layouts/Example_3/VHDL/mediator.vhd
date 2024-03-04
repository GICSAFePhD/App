--  mediator.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity mediator is
		generic(
			N : natural := 248;
			N_SIGNALS : natural := 82;
			N_LEVELCROSSINGS : natural := 1;
			N_SINGLESWITCHES : natural := 14;
			N_DOUBLESWITCHES : natural := 8;
			N_TRACKCIRCUITS : natural := 53
		);
		port(
			clock : in std_logic;
			processing : in std_logic;
			processed : out std_logic;
			signals : in signals_type;
			levelCrossings : in std_logic;
			singleSwitches : in std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			doubleSwitches : in dSwitches_type;
			output : out std_logic_vector(195-1 downto 0);
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
					output(0) <= signals.msb(0);
					output(1) <= signals.lsb(0);
					output(2) <= signals.msb(1);
					output(3) <= signals.lsb(1);
					output(4) <= signals.msb(2);
					output(5) <= signals.lsb(2);
					output(6) <= signals.msb(3);
					output(7) <= signals.lsb(3);
					output(8) <= signals.msb(4);
					output(9) <= signals.lsb(4);
					output(10) <= signals.msb(5);
					output(11) <= signals.lsb(5);
					output(12) <= signals.msb(6);
					output(13) <= signals.lsb(6);
					output(14) <= signals.msb(7);
					output(15) <= signals.lsb(7);
					output(16) <= signals.msb(8);
					output(17) <= signals.lsb(8);
					output(18) <= signals.msb(9);
					output(19) <= signals.lsb(9);
					output(20) <= signals.msb(10);
					output(21) <= signals.lsb(10);
					output(22) <= signals.msb(11);
					output(23) <= signals.lsb(11);
					output(24) <= signals.msb(12);
					output(25) <= signals.lsb(12);
					output(26) <= signals.msb(13);
					output(27) <= signals.lsb(13);
					output(28) <= signals.msb(14);
					output(29) <= signals.lsb(14);
					output(30) <= signals.msb(15);
					output(31) <= signals.lsb(15);
					output(32) <= signals.msb(16);
					output(33) <= signals.lsb(16);
					output(34) <= signals.msb(17);
					output(35) <= signals.lsb(17);
					output(36) <= signals.msb(18);
					output(37) <= signals.lsb(18);
					output(38) <= signals.msb(19);
					output(39) <= signals.lsb(19);
					output(40) <= signals.msb(20);
					output(41) <= signals.lsb(20);
					output(42) <= signals.msb(21);
					output(43) <= signals.lsb(21);
					output(44) <= signals.msb(22);
					output(45) <= signals.lsb(22);
					output(46) <= signals.msb(23);
					output(47) <= signals.lsb(23);
					output(48) <= signals.msb(24);
					output(49) <= signals.lsb(24);
					output(50) <= signals.msb(25);
					output(51) <= signals.lsb(25);
					output(52) <= signals.msb(26);
					output(53) <= signals.lsb(26);
					output(54) <= signals.msb(27);
					output(55) <= signals.lsb(27);
					output(56) <= signals.msb(28);
					output(57) <= signals.lsb(28);
					output(58) <= signals.msb(29);
					output(59) <= signals.lsb(29);
					output(60) <= signals.msb(30);
					output(61) <= signals.lsb(30);
					output(62) <= signals.msb(31);
					output(63) <= signals.lsb(31);
					output(64) <= signals.msb(32);
					output(65) <= signals.lsb(32);
					output(66) <= signals.msb(33);
					output(67) <= signals.lsb(33);
					output(68) <= signals.msb(34);
					output(69) <= signals.lsb(34);
					output(70) <= signals.msb(35);
					output(71) <= signals.lsb(35);
					output(72) <= signals.msb(36);
					output(73) <= signals.lsb(36);
					output(74) <= signals.msb(37);
					output(75) <= signals.lsb(37);
					output(76) <= signals.msb(38);
					output(77) <= signals.lsb(38);
					output(78) <= signals.msb(39);
					output(79) <= signals.lsb(39);
					output(80) <= signals.msb(40);
					output(81) <= signals.lsb(40);
					output(82) <= signals.msb(41);
					output(83) <= signals.lsb(41);
					output(84) <= signals.msb(42);
					output(85) <= signals.lsb(42);
					output(86) <= signals.msb(43);
					output(87) <= signals.lsb(43);
					output(88) <= signals.msb(44);
					output(89) <= signals.lsb(44);
					output(90) <= signals.msb(45);
					output(91) <= signals.lsb(45);
					output(92) <= signals.msb(46);
					output(93) <= signals.lsb(46);
					output(94) <= signals.msb(47);
					output(95) <= signals.lsb(47);
					output(96) <= signals.msb(48);
					output(97) <= signals.lsb(48);
					output(98) <= signals.msb(49);
					output(99) <= signals.lsb(49);
					output(100) <= signals.msb(50);
					output(101) <= signals.lsb(50);
					output(102) <= signals.msb(51);
					output(103) <= signals.lsb(51);
					output(104) <= signals.msb(52);
					output(105) <= signals.lsb(52);
					output(106) <= signals.msb(53);
					output(107) <= signals.lsb(53);
					output(108) <= signals.msb(54);
					output(109) <= signals.lsb(54);
					output(110) <= signals.msb(55);
					output(111) <= signals.lsb(55);
					output(112) <= signals.msb(56);
					output(113) <= signals.lsb(56);
					output(114) <= signals.msb(57);
					output(115) <= signals.lsb(57);
					output(116) <= signals.msb(58);
					output(117) <= signals.lsb(58);
					output(118) <= signals.msb(59);
					output(119) <= signals.lsb(59);
					output(120) <= signals.msb(60);
					output(121) <= signals.lsb(60);
					output(122) <= signals.msb(61);
					output(123) <= signals.lsb(61);
					output(124) <= signals.msb(62);
					output(125) <= signals.lsb(62);
					output(126) <= signals.msb(63);
					output(127) <= signals.lsb(63);
					output(128) <= signals.msb(64);
					output(129) <= signals.lsb(64);
					output(130) <= signals.msb(65);
					output(131) <= signals.lsb(65);
					output(132) <= signals.msb(66);
					output(133) <= signals.lsb(66);
					output(134) <= signals.msb(67);
					output(135) <= signals.lsb(67);
					output(136) <= signals.msb(68);
					output(137) <= signals.lsb(68);
					output(138) <= signals.msb(69);
					output(139) <= signals.lsb(69);
					output(140) <= signals.msb(70);
					output(141) <= signals.lsb(70);
					output(142) <= signals.msb(71);
					output(143) <= signals.lsb(71);
					output(144) <= signals.msb(72);
					output(145) <= signals.lsb(72);
					output(146) <= signals.msb(73);
					output(147) <= signals.lsb(73);
					output(148) <= signals.msb(74);
					output(149) <= signals.lsb(74);
					output(150) <= signals.msb(75);
					output(151) <= signals.lsb(75);
					output(152) <= signals.msb(76);
					output(153) <= signals.lsb(76);
					output(154) <= signals.msb(77);
					output(155) <= signals.lsb(77);
					output(156) <= signals.msb(78);
					output(157) <= signals.lsb(78);
					output(158) <= signals.msb(79);
					output(159) <= signals.lsb(79);
					output(160) <= signals.msb(80);
					output(161) <= signals.lsb(80);
					output(162) <= signals.msb(81);
					output(163) <= signals.lsb(81);
					output(164) <= levelCrossings;
					output(178 downto 165) <= singleSwitches;
					output(0) <= doubleSwitches.msb(0);
					output(1) <= doubleSwitches.lsb(0);
					output(2) <= doubleSwitches.msb(1);
					output(3) <= doubleSwitches.lsb(1);
					output(4) <= doubleSwitches.msb(2);
					output(5) <= doubleSwitches.lsb(2);
					output(6) <= doubleSwitches.msb(3);
					output(7) <= doubleSwitches.lsb(3);
					output(8) <= doubleSwitches.msb(4);
					output(9) <= doubleSwitches.lsb(4);
					output(10) <= doubleSwitches.msb(5);
					output(11) <= doubleSwitches.lsb(5);
					output(12) <= doubleSwitches.msb(6);
					output(13) <= doubleSwitches.lsb(6);
					output(14) <= doubleSwitches.msb(7);
					output(15) <= doubleSwitches.lsb(7);
				end if;
			end if;
		end if;
	end process;
end Behavioral;