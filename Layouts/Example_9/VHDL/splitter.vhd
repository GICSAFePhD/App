--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N : natural := 89;
			N_SIGNALS : natural := 25;
			N_LEVELCROSSINGS : natural := 3;
			N_SINGLESWITCHES : natural := 4;
			N_ROUTES : natural := 25;
			N_TRACKCIRCUITS : natural := 7
		);
		port(
			clock : in std_logic;
			packet :  in std_logic_vector(N-1 downto 0);
			processing :  in std_logic;
			processed :  out std_logic;
			ocupation :  out std_logic_vector(N_TRACKCIRCUITS-1 downto 0);
			signals :  out signals_type;
			routes : out std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings : out std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			reset : in std_logic
		);
	end entity splitter;
architecture Behavioral of splitter is
	Signal tc_s : std_logic_vector(7-1 downto 0);
	Signal sig_s_i,sig_s_o : signals_type;
	Signal rt_s_i,rt_s_o : std_logic_vector(25-1 downto 0);
	Signal lc_s_i,lc_s_o : std_logic_vector(3-1 downto 0);
	Signal ssw_s_i,ssw_s_o : std_logic_vector(4-1 downto 0);
begin
	process(clock,reset)
	begin
		if (clock = '1' and clock'Event) then
			if (reset = '1') then
				ocupation <= "0000000";
				signals.lsb <= "0000000000000000000000000";
				signals.msb <= "0000000000000000000000000";
				routes <= "0000000000000000000000000";
				levelCrossings <= "000";
				singleSwitches <= "0000";
				processed <= '0';
			else
				processed <= processing;
				if processing = '1' then
					ocupation(0) <= packet(88);
					ocupation(1) <= packet(87);
					ocupation(2) <= packet(86);
					ocupation(3) <= packet(85);
					ocupation(4) <= packet(84);
					ocupation(5) <= packet(83);
					ocupation(6) <= packet(82);
					routes(0) <= packet(81);
					routes(1) <= packet(80);
					routes(2) <= packet(79);
					routes(3) <= packet(78);
					routes(4) <= packet(77);
					routes(5) <= packet(76);
					routes(6) <= packet(75);
					routes(7) <= packet(74);
					routes(8) <= packet(73);
					routes(9) <= packet(72);
					routes(10) <= packet(71);
					routes(11) <= packet(70);
					routes(12) <= packet(69);
					routes(13) <= packet(68);
					routes(14) <= packet(67);
					routes(15) <= packet(66);
					routes(16) <= packet(65);
					routes(17) <= packet(64);
					routes(18) <= packet(63);
					routes(19) <= packet(62);
					routes(20) <= packet(61);
					routes(21) <= packet(60);
					routes(22) <= packet(59);
					routes(23) <= packet(58);
					routes(24) <= packet(57);
					signals.msb(0) <= packet(56);
					signals.lsb(0) <= packet(55);
					signals.msb(1) <= packet(54);
					signals.lsb(1) <= packet(53);
					signals.msb(2) <= packet(52);
					signals.lsb(2) <= packet(51);
					signals.msb(3) <= packet(50);
					signals.lsb(3) <= packet(49);
					signals.msb(4) <= packet(48);
					signals.lsb(4) <= packet(47);
					signals.msb(5) <= packet(46);
					signals.lsb(5) <= packet(45);
					signals.msb(6) <= packet(44);
					signals.lsb(6) <= packet(43);
					signals.msb(7) <= packet(42);
					signals.lsb(7) <= packet(41);
					signals.msb(8) <= packet(40);
					signals.lsb(8) <= packet(39);
					signals.msb(9) <= packet(38);
					signals.lsb(9) <= packet(37);
					signals.msb(10) <= packet(36);
					signals.lsb(10) <= packet(35);
					signals.msb(11) <= packet(34);
					signals.lsb(11) <= packet(33);
					signals.msb(12) <= packet(32);
					signals.lsb(12) <= packet(31);
					signals.msb(13) <= packet(30);
					signals.lsb(13) <= packet(29);
					signals.msb(14) <= packet(28);
					signals.lsb(14) <= packet(27);
					signals.msb(15) <= packet(26);
					signals.lsb(15) <= packet(25);
					signals.msb(16) <= packet(24);
					signals.lsb(16) <= packet(23);
					signals.msb(17) <= packet(22);
					signals.lsb(17) <= packet(21);
					signals.msb(18) <= packet(20);
					signals.lsb(18) <= packet(19);
					signals.msb(19) <= packet(18);
					signals.lsb(19) <= packet(17);
					signals.msb(20) <= packet(16);
					signals.lsb(20) <= packet(15);
					signals.msb(21) <= packet(14);
					signals.lsb(21) <= packet(13);
					signals.msb(22) <= packet(12);
					signals.lsb(22) <= packet(11);
					signals.msb(23) <= packet(10);
					signals.lsb(23) <= packet(9);
					signals.msb(24) <= packet(8);
					signals.lsb(24) <= packet(7);
					levelCrossings(0) <= packet(6);
					levelCrossings(1) <= packet(5);
					levelCrossings(2) <= packet(4);
					singleSwitches(0) <= packet(3);
					singleSwitches(1) <= packet(2);
					singleSwitches(2) <= packet(1);
					singleSwitches(3) <= packet(0);
				end if;
			end if;
		end if;
	end process;
end Behavioral;