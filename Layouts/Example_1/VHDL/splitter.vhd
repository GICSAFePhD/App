--  splitter.vhdl : Automatically generated using ACG
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--Declare the package
use work.my_package.all;
	entity splitter is
		generic(
			N : natural := 85;
			N_SIGNALS : natural := 23;
			N_LEVELCROSSINGS : natural := 2;
			N_SINGLESWITCHES : natural := 5;
			N_ROUTES : natural := 21;
			N_TRACKCIRCUITS : natural := 11
		);
		port(
			clock : in std_logic;
			packet :  in std_logic_vector(N-1 downto 0);
			ocupation :  out std_logic_vector(N_TRACKCIRCUITS-1 downto 0);
			signals :  out signals_type;
			routes : out std_logic_vector(N_ROUTES-1 downto 0);
			levelCrossings : out std_logic_vector(N_LEVELCROSSINGS-1 downto 0);
			singleSwitches : out std_logic_vector(N_SINGLESWITCHES-1 downto 0);
			processing :  in std_logic;
			processed :  out std_logic
		);
	end entity splitter;
architecture Behavioral of splitter is
	Signal tc_s : std_logic_vector(11-1 downto 0) := (others => '0');
	Signal sig_s_i,sig_s_o : signals_type := (msb => (others => '0'), lsb => (others => '0'));
	Signal rt_s_i,rt_s_o : std_logic_vector(21-1 downto 0);
	Signal lc_s_i,lc_s_o : std_logic_vector(2-1 downto 0) := (others => '0');
	Signal ssw_s_i,ssw_s_o : std_logic_vector(5-1 downto 0) := (others => '0');
begin
	process(clock)
	begin
		if (clock = '1' and clock'Event) then
			processed <= processing;
			if processing = '1' then
				ocupation(0) <= packet(84);
				ocupation(1) <= packet(83);
				ocupation(2) <= packet(82);
				ocupation(3) <= packet(81);
				ocupation(4) <= packet(80);
				ocupation(5) <= packet(79);
				ocupation(6) <= packet(78);
				ocupation(7) <= packet(77);
				ocupation(8) <= packet(76);
				ocupation(9) <= packet(75);
				ocupation(10) <= packet(74);
				routes(0) <= packet(73);
				routes(1) <= packet(72);
				routes(2) <= packet(71);
				routes(3) <= packet(70);
				routes(4) <= packet(69);
				routes(5) <= packet(68);
				routes(6) <= packet(67);
				routes(7) <= packet(66);
				routes(8) <= packet(65);
				routes(9) <= packet(64);
				routes(10) <= packet(63);
				routes(11) <= packet(62);
				routes(12) <= packet(61);
				routes(13) <= packet(60);
				routes(14) <= packet(59);
				routes(15) <= packet(58);
				routes(16) <= packet(57);
				routes(17) <= packet(56);
				routes(18) <= packet(55);
				routes(19) <= packet(54);
				routes(20) <= packet(53);
				signals.msb(0) <= packet(52);
				signals.lsb(0) <= packet(51);
				signals.msb(1) <= packet(50);
				signals.lsb(1) <= packet(49);
				signals.msb(2) <= packet(48);
				signals.lsb(2) <= packet(47);
				signals.msb(3) <= packet(46);
				signals.lsb(3) <= packet(45);
				signals.msb(4) <= packet(44);
				signals.lsb(4) <= packet(43);
				signals.msb(5) <= packet(42);
				signals.lsb(5) <= packet(41);
				signals.msb(6) <= packet(40);
				signals.lsb(6) <= packet(39);
				signals.msb(7) <= packet(38);
				signals.lsb(7) <= packet(37);
				signals.msb(8) <= packet(36);
				signals.lsb(8) <= packet(35);
				signals.msb(9) <= packet(34);
				signals.lsb(9) <= packet(33);
				signals.msb(10) <= packet(32);
				signals.lsb(10) <= packet(31);
				signals.msb(11) <= packet(30);
				signals.lsb(11) <= packet(29);
				signals.msb(12) <= packet(28);
				signals.lsb(12) <= packet(27);
				signals.msb(13) <= packet(26);
				signals.lsb(13) <= packet(25);
				signals.msb(14) <= packet(24);
				signals.lsb(14) <= packet(23);
				signals.msb(15) <= packet(22);
				signals.lsb(15) <= packet(21);
				signals.msb(16) <= packet(20);
				signals.lsb(16) <= packet(19);
				signals.msb(17) <= packet(18);
				signals.lsb(17) <= packet(17);
				signals.msb(18) <= packet(16);
				signals.lsb(18) <= packet(15);
				signals.msb(19) <= packet(14);
				signals.lsb(19) <= packet(13);
				signals.msb(20) <= packet(12);
				signals.lsb(20) <= packet(11);
				signals.msb(21) <= packet(10);
				signals.lsb(21) <= packet(9);
				signals.msb(22) <= packet(8);
				signals.lsb(22) <= packet(7);
				levelCrossings(0) <= packet(6);
				levelCrossings(1) <= packet(5);
				singleSwitches(0) <= packet(4);
				singleSwitches(1) <= packet(3);
				singleSwitches(2) <= packet(2);
				singleSwitches(3) <= packet(1);
				singleSwitches(4) <= packet(0);
			end if;
		end if;
	end process;
end Behavioral;